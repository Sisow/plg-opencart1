<?php
class ModelTotalSisowBelfiusFee extends Model {
	public function getTotal(&$total_data, &$total, &$taxes) {
		$this->session->data['sisowbelfiusfee']['fee'] = false;
		$this->session->data['sisowbelfiusfee']['feetax'] = false;
		//$this->session->data['sisowbelfiusfee']['feetaxrate'] = false;
		if (isset($this->session->data['payment_method']) && $this->session->data['payment_method']['code'] == 'sisowbelfius' && ($fee = $this->config->get('sisowbelfius_paymentfee'))) {
			if ($fee < 0) {
				$fee = round($total * -$fee / 100.0, 2);
			}
			$total += $fee;
			$total_data[] = array(
				'code'       => 'sisowbelfiusfee',
				'title'      => 'SofortBanking fee',
				'text'       => $this->currency->format($fee),
				'value'      => $fee,
				'sort_order' => $this->config->get('sisowbelfiusfee_sort_order')
			);
			$feetax = 0;
			$rate = 0;
			if (($tax = $this->config->get('sisowbelfiusfee_tax'))) {
				if (method_exists($this->tax, 'getRate')) {
					$rate = $this->tax->getRate($tax);
					if (!isset($taxes[$tax])) {
						$taxes[$tax] = $feetax = $fee * $rate / 100;
					}
					else {
						$taxes[$tax] += $feetax = $fee * $rate / 100;
					}
				}
				else {
					$tax_rates = $this->tax->getRates($fee, $tax);
					foreach ($tax_rates as $tax_rate) {
						if (!isset($taxes[$tax_rate['tax_rate_id']])) {
							$taxes[$tax_rate['tax_rate_id']] = $feetax = $tax_rate['amount'];
						}
						else {
							$taxes[$tax_rate['tax_rate_id']] += $feetax = $tax_rate['amount'];
						}
					}
				}
			}
			$this->session->data['sisowbelfiusfee']['fee'] = $fee;
			$this->session->data['sisowbelfiusfee']['feetax'] = $feetax;
			//$this->session->data['sisowbelfiusfee']['feetaxrate'] = $rate;
		}
	}
}
?>