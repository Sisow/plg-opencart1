<?php
require_once('sisow.cls5.php');

class ControllerPaymentSisow extends Controller {
	
	public function _index($payment) {
		$this->load->language('payment/' . $payment);
		$this->load->model('checkout/order');

		$order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);
		
		$this->data['text_fee'] = '';
		$this->data['text_paymentfee'] = '';

		if ($payment == 'sisowideal') {
			$this->data['text_bank'] = $this->language->get('text_bank');
			$sisow = new Sisow($this->config->get($payment . '_merchantid'), $this->config->get($payment . '_merchantkey'));
			$sisow->DirectoryRequest($arr, false, $this->config->get($payment . '_testmode') == 'true');
			$this->data['banks'] = $arr;
		}
		else if ($payment == 'sisowklarna' || $payment == 'sisowklaacc' || $payment == 'sisowfocum' || $payment == 'sisowbillink' || $payment == 'sisowafterpay') {
			$this->data['text_description'] = $this->language->get('text_description');
			$this->data['text_phone'] = $order_info['telephone'];
			$this->data['text_klarnaid'] = $this->config->get($payment . '_klarnaid');
			if ($payment == 'sisowklarna' || $payment == 'sisowfocum' || $payment == 'sisowbillink' || $payment == 'sisowafterpay') {
				if (isset($this->session->data['sisowklarnafee']['fee'])) {
					$fee = $this->session->data['sisowklarnafee']['fee'];
					if (isset($this->session->data['sisowklarnafee']['feetax'])) {
						$fee += $this->session->data['sisowklarnafee']['feetax'];
					}
					$this->data['text_fee'] = $fee;
					$this->data['text_paymentfee'] = str_replace('{fee}', $this->currency->format($fee), $this->language->get('text_paymentfee'));
				}
				else {
					$this->data['text_fee'] = '';
					$this->data['text_paymentfee'] = '';
				}
				
				if($payment == 'sisowafterpay')
				{
					$order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);
					
					$b2b = array_key_exists('payment_company', $order_info) && !empty($order_info['payment_company']) ? 'true' : 'false'; 
					$country = array_key_exists('payment_iso_code_2', $order_info) ? $order_info['payment_iso_code_2'] : '';
					
					$terms = 'http://www.afterpay.nl/consument-betalingsvoorwaarden';
					
					if(!empty($country) && strtoupper($country) == 'BE')
						$terms = 'https://www.afterpay.be/be/footer/betalen-met-afterpay/betalingsvoorwaarden';
					else if($b2b == 'true')
						$terms = 'https://www.afterpay.nl/nl/algemeen/zakelijke-partners/betalingsvoorwaarden-zakelijk';
					
					$this->data['afterpay_terms'] = $terms;
					$this->data['afterpay_b2b'] = $b2b;
				}
			}
			else {
				$sisow = new Sisow($this->config->get($payment . '_merchantid'), $this->config->get($payment . '_merchantkey'), $this->config->get($payment . '_shopid'));
				$m = $sisow->FetchMonthlyRequest($order_info['total']);
				$this->data['text_monthly'] = $m > 0 ? $this->currency->format(round($m / 100.0, 2)) : false;
				$this->data['text_pclass'] = $m > 0 ? $sisow->pclass : false;
				$this->data['text_fee'] = $m;
				$this->data['text_paymentfee'] = '';
			}
		}
		else if ($payment == 'sisowovb') {
			$this->data['text_ovb'] = $this->language->get('text_ovb');
		}
		
		$this->data['text_header'] = $this->language->get('text_header');
		$this->data['text_redirect'] = $this->language->get('text_redirect');
		$this->data['button_confirm'] = $this->language->get('button_confirm');
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/' . $payment . '.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/payment/' . $payment . '.tpl';
		}
		else {
			$this->template = 'default/template/payment/' . $payment . '.tpl';
		}
		
		$this->render();
	}

	public function _redirectbank($payment) {		
		// controle bankkeuze
		if ($payment == 'sisowideal') {
			if (!$this->request->post['sisowbank']) {
				$json['error'] = 'U heeft geen bank gekozen';
			}
		}
		if ($payment == 'sisowgiropay') {
			if (!$this->request->post['giropay_bic']) {
				$json['error'] = 'Bankleitzahl ist ungültig.';
			}
		}
		if ($payment == 'sisoweps') {
			if (!$this->request->post['bic_eps']) {
				$json['error'] = 'Bankleitzahl ist ungültig.';
			}
		}
		
		// controle geboortedatum
		if ($payment == 'sisowklarna' || $payment == 'sisowklaacc' || $payment == 'sisowfocum' || $payment == 'sisowafterpay' || $payment == 'sisowbillink' || $payment == 'sisowcapayable') {
			if (!isset($this->request->post['sisowgender']) || $this->request->post['sisowgender'] == '') {
				$json['error'] = 'U heeft geen aanhef gekozen';
			}
			if (!isset($this->request->post['sisowphone']) || $this->request->post['sisowphone'] == '') {
				$json['error'] = 'U heeft geen telefoonnummer ingevuld';
			}
			if ($payment == 'sisowfocum' &&  (!isset($this->request->post['sisowiban']) || $this->request->post['sisowiban'] == '')) {
				$json['error'] = 'U heeft geen IBAN ingevuld';
			}
			
			if($payment == 'sisowafterpay' && array_key_exists('sisowcoc', $this->request->post) && empty($this->request->post['sisowcoc'])){
				$json['error'] = 'Voor een B2B aanvraag is een KvK nummer verplicht!';
			}
			
			if($payment == 'sisowafterpay' && !array_key_exists('afterpay_terms', $this->request->post)){
				$json['error'] = 'U dient akkoord te gaan met de Afterpay voorwaarden';
			}
			
			$day = (int)$this->request->post['sisowday'];
			$month = (int)$this->request->post['sisowmonth'];
			$year = (int)$this->request->post['sisowyear'];
			if ($day < 1 || $day > 31 || $month < 1 || $month > 12 || $year < 0) {
				$json['error'] = 'Geboortedatum niet (correct) ingevuld';
			}
			if ($year < 100) {
				$year += 1900;
			}
			$posts['birthdate'] = sprintf('%02d%02d%04d', $day, $month, $year);
			$posts['gender'] = $this->request->post['sisowgender'];
			$posts['billing_phone'] = $this->request->post['sisowphone'];
			
			if($payment == 'sisowfocum')
				$posts['iban'] = $this->request->post['sisowiban'];
			
			if($payment == 'sisowafterpay' && array_key_exists('sisowcoc', $this->request->post))
				$posts['billing_coc'] = $this->request->post['sisowcoc'];
			
			if($this->config->get($payment . '_autoinvoice') == 'true')
				$posts['makeinvoice'] = 'true';
		}
		
		
		
		if(empty($json['error']))
		{		
			$this->load->language('payment/' . $payment);
			$this->load->model('payment/'. $payment);

			$this->load->model('checkout/order');
			$order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);
		
			$sisow = new Sisow($this->config->get($payment . '_merchantid'), $this->config->get($payment . '_merchantkey'), $this->config->get($payment . '_shopid'));
			
			switch ($payment) {
				case 'sisowideal':
					$sisow->issuerId = $this->request->post['sisowbank'];
					break;
				case 'sisowklarna':
					$sisow->payment = 'klarna';
					$fee = $feetax = $feetaxrate = 0;
					if (isset($this->session->data['sisowklarnafee']['fee'])) {
						$fee = $this->session->data['sisowklarnafee']['fee'];
						if (isset($this->session->data['sisowklarnafee']['feetax'])) {
							$feetax = $this->session->data['sisowklarnafee']['feetax'];
						}
					}
					break;
				case 'sisowfocum':
					$sisow->payment = 'focum';
					$fee = $feetax = $feetaxrate = 0;
					if (isset($this->session->data['sisowfocumfee']['fee'])) {
						$fee = $this->session->data['sisowfocumfee']['fee'];
						if (isset($this->session->data['sisowfocumfee']['feetax'])) {
							$feetax = $this->session->data['sisowfocumfee']['feetax'];
						}
					}
					break;
				case 'sisowklaacc':
					$sisow->payment = 'klarnaacc';
					break;
				case 'sisowovb':
					$sisow->payment = 'overboeking';
					break;
				case 'sisowmc':
					$sisow->payment = 'mistercash';
					break;
				case 'sisowde':
					$sisow->payment = 'sofort';
					break;
				case 'sisowhomepay':
					$sisow->payment = 'homepay';
					break;
				case 'sisoweps':
					$sisow->payment = 'eps';
					break;
				case 'sisowgiropay':
					$sisow->payment = 'giropay';
					break;
				case 'sisowwg':
					$sisow->payment = 'webshop';
					break;
				case 'sisowmaestro':
					$sisow->payment = 'maestro';
					break;
				case 'sisowmastercard':
					$sisow->payment = 'mastercard';
					break;
				case 'sisowvisa':
					$sisow->payment = 'visa';
					break;
				case 'sisowvvv':
					$sisow->payment = 'vvv';
					break;
				case 'sisowafterpay':
					$sisow->payment = 'afterpay';
					$fee = $feetax = $feetaxrate = 0;
					if (isset($this->session->data['sisowafterpayfee']['fee'])) {
						$fee = $this->session->data['sisowafterpayfee']['fee'];
						if (isset($this->session->data['sisowafterpayfee']['feetax'])) {
							$feetax = $this->session->data['sisowafterpayfee']['feetax'];
						}
					}
					break;
				case 'sisowbelfius':
					$sisow->payment = 'belfius';
					break;
				case 'sisowbunq':
					$sisow->payment = 'bunq';
					break;
				case 'sisowidealqr':
					$sisow->payment = 'idealqr';
					break;
				case 'sisowpp':
					$sisow->payment = 'paypalec';
					$fee = $feetax = $feetaxrate = 0;
					if (isset($this->session->data['sisowppfee']['fee'])) {
						$fee = $this->session->data['sisowppfee']['fee'];
						if (isset($this->session->data['sisowppfee']['feetax'])) {
							$feetax = $this->session->data['sisowppfee']['feetax'];
						}
					}
					break;
				case 'sisowbillink':
					$sisow->payment = 'billink';
					$fee = $feetax = $feetaxrate = 0;
					if (isset($this->session->data['sisowbillinkfee']['fee'])) {
						$fee = $this->session->data['sisowbillinkfee']['fee'];
						if (isset($this->session->data['sisowbillinkfee']['feetax'])) {
							$feetax = $this->session->data['sisowbillinkfee']['feetax'];
						}
					}
					break;
				default:
					$sisow->payment = substr($payment, 5);
					break;
			}
			
			if($payment == 'sisowovb')
			{
				$sisow->purchaseId = $this->config->get($payment . '_prefix') . $order_info['order_id'];
				$sisow->entranceCode = $order_info['order_id'];
			}
			else
			{
				$sisow->purchaseId = $order_info['order_id'];
			}
			
			$sisow->description = $this->config->get('config_name') . " order " . $order_info['order_id'];
			$sisow->amount = $this->currency->format($order_info['total'], $this->session->data['currency'], '', false);
			$posts['currency'] = $this->session->data['currency'];

			$sisow->notifyUrl = $this->url->link('payment/' . $payment . '/notify');
			$sisow->returnUrl = $sisow->notifyUrl;
			
			if ($this->config->get($payment . '_testmode') == 'true') {
				$posts['testmode'] = 'true';
			}
			if ($payment == 'sisowklaacc') {
				$posts['pclass'] = $this->request->post['sisowpclass'];
			}
			else if ($payment == 'sisowklarna' || $payment == 'sisowklaacc') {
				$posts['makeinvoice'] = $this->config->get($payment . '_makeinvoice'); 
				$posts['mailinvoice'] = $this->config->get($payment . '_mailinvoice'); 
			}
			else if ($payment == 'sisowovb') {
				if ($this->config->get('sisowovb_days') > 0)
					$posts['days'] = $this->config->get('sisowovb_days');
				if ($this->config->get('sisowovb_paylink') == 'true')
					$posts['including'] = 'true';
			}
			else if($payment == 'sisowgiropay' || $payment == 'sisoweps')
			{
				$posts['bic'] = $payment == 'sisowgiropay' ? $this->request->post['giropay_bic'] : $this->request->post['bic_eps'];
			}
			if ($order_info['customer_id']) {
				$posts['customer'] = $order_info['customer_id'];
			}
			$posts['ipaddress'] = $this->request->server['REMOTE_ADDR'];
			// billing
			$posts['billing_company']	= $order_info['payment_company'];
			$posts['billing_firstname']	= $order_info['payment_firstname'];
			$posts['billing_lastname']	= $order_info['payment_lastname'];
			$posts['billing_address1']	= $order_info['payment_address_1'];
			if (!empty($order_info['payment_address_2']))
				$posts['billing_address2'] = $order_info['payment_address_2'];
			
			if(array_key_exists('payment_address_3', $order_info) && strlen($order_info['payment_address_3']) > 0 && is_numeric(substr($order_info['payment_address_3'], 0, 1)))
				$posts['billing_address1'] .= ' ' . $order_info['payment_address_3'];
		
			$posts['billing_zip']		= $order_info['payment_postcode'];
			$posts['billing_city']		= $order_info['payment_city'];
			$posts['billing_mail']		= $order_info['email'];
			$posts['billing_country']	= $order_info['payment_country'];
			$posts['billing_countrycode'] =$order_info['payment_iso_code_2'];
			if(!isset($posts['billing_phone']))
				$posts['billing_phone']		= $order_info['telephone'];
			
			//$posts['billing_country']	= $order_info['payment_city'];
			// shipping
			$posts['shipping_company']	= $order_info['shipping_company'];
			$posts['shipping_firstname']	= $order_info['shipping_firstname'];
			$posts['shipping_lastname']	= $order_info['shipping_lastname'];
			$posts['shipping_address1']	= $order_info['shipping_address_1'];
			if (!empty($order_info['shipping_address_2']))
				$posts['shipping_address2'] = $order_info['shipping_address_2'];
			if(array_key_exists('shipping_address_3', $order_info) && strlen($order_info['shipping_address_3']) > 0 && is_numeric(substr($order_info['shipping_address_3'], 0, 1)))
				$posts['shipping_address1'] .= ' ' . $order_info['shipping_address_3'];
			$posts['shipping_zip']		= $order_info['shipping_postcode'];
			$posts['shipping_city']		= $order_info['shipping_city'];
			$posts['shipping_mail']		= $order_info['email'];
			$posts['shipping_phone']	= $order_info['telephone'];
			$posts['shipping_country']	= $order_info['shipping_country'];
			$posts['shipping_countrycode'] = $order_info['shipping_iso_code_2'];
			
			//currency
			/*
			if (substr(VERSION, 0, 3) == '1.4')
				$posts['currency'] = $order_info['currency'];
			else
				$posts['currency'] = $order_info['currency_code'];
			*/

			// products
			$products_info = $this->cart->getProducts();
			$i = 1;
			foreach ($products_info as $key => $data) {
				$unit_price_excl_tax = $data['price'];

				if($this->config->get('config_tax')){
					$tax_rates = $this->tax->getRates($data['total'], $data['tax_class_id']);
					
					if(count($tax_rates) > 0){
						$rate = array_shift($tax_rates);
						
						$taxAmount = $rate['amount'];
						$taxRate = $rate['rate'];
					}
					else {
						$taxRate = 0;
						$taxAmount = 0;
					}
				}else{
					$taxRate = 0;
					$taxAmount = 0;
				}
				
				$posts['product_id_' . $i] = $data['product_id'];
				$posts['product_description_' . $i] = $data['name'];
				$posts['product_quantity_' . $i] = $data['quantity'];
				$posts['product_weight_' . $i] = round($data['weight'] * 1000, 0);
				$posts['product_netprice_' . $i] = round($this->currency->format($unit_price_excl_tax, $this->session->data['currency'], '', false) * 100.0, 0);
				$posts['product_nettotal_' . $i] = round($this->currency->format($unit_price_excl_tax * $data['quantity'], $this->session->data['currency'], '', false) * 100.0, 0);

				// product total
				$unit_price_incl_tax = $this->tax->calculate($data['price'], $data['tax_class_id'], $this->config->get('config_tax'));
				$posts['product_total_' . $i] = round($this->currency->format($unit_price_incl_tax * $data['quantity'], $this->session->data['currency'], '', false) * 100.0);

				// product tax
				if ($taxRate) {
					$posts['product_taxrate_' . $i] = round($taxRate * 100, 0);
					$posts['product_tax_' . $i] = round($this->currency->format($data['price'] * $data['quantity'] * $taxRate, $this->session->data['currency'], '', false) * 100 , 0);
				}
				else
				{
					$posts['product_taxrate_' . $i] = "0";
					$posts['product_tax_' . $i] = "0";
				}

				$i++;
			}
			
			$total_data = array();
			$total = 0;

			$this->load->model('setting/extension');

			$sort_order = array(); 

			$results = $this->model_setting_extension->getExtensions('total');

			foreach ($results as $key => $value) {
				$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
			}

			array_multisort($sort_order, SORT_ASC, $results);
			$taxes = $this->cart->getTaxes();

			$klarna_tax = array();

			foreach ($results as $result) {
				if ($this->config->get($result['code'] . '_status')) {
					$this->load->model('total/' . $result['code']);

					$taxes = array();

					$this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);

					$amount = 0;

					foreach ($taxes as $tax_id => $value) {
						$amount += $value;
					}

					$klarna_tax[$result['code']] = $amount;
				}
			}
			
			foreach ($total_data as $key => $value) {
				$sort_order[$key] = $value['sort_order'];

				if (isset($klarna_tax[$value['code']])) {
					if ($klarna_tax[$value['code']]) {
						$total_data[$key]['tax_rate'] = abs($klarna_tax[$value['code']] / $value['value'] * 100);
					} else {
						$total_data[$key]['tax_rate'] = 0;
					}
				} else {
					$total_data[$key]['tax_rate'] = '0';
				}
			}
			
			foreach($total_data as $singleTotal)
			{
				if($singleTotal['code'] == 'sub_total' || $singleTotal['code'] == 'total')
					continue;
				
				$posts['product_id_' . $i] = 'fee' . $i;
				$posts['product_description_' . $i] = $singleTotal['title'];
				$posts['product_quantity_' . $i] = 1;
				$posts['product_weight_' . $i] = 0;
				$posts['product_netprice_' . $i] = round($this->currency->format($singleTotal['value'], $this->session->data['currency'], '', false) * 100, 0);
				$posts['product_nettotal_' . $i] = round($this->currency->format($singleTotal['value'], $this->session->data['currency'], '', false) * 100, 0);
				if ($singleTotal['tax_rate'] > 0) {
					$posts['product_taxrate_' . $i] = round($singleTotal['tax_rate'] * 100, 0);
					$posts['product_tax_' . $i] = round($this->currency->format($singleTotal['value'] * ($singleTotal['tax_rate'] / 100), $this->session->data['currency'], '', false) * 100.0, 0);
					$posts['product_total_' . $i] = $posts['product_netprice_' . $i] + $posts['product_tax_' . $i];
				}
				else
				{
					$posts['product_taxrate_' . $i] = "0";
					$posts['product_tax_' . $i] = "0";
					$posts['product_total_' . $i] = $posts['product_nettotal_' . $i];
				}
				$i++;
			}

			// Request
			$json = array();
			if (($ex = $sisow->TransactionRequest($posts)) < 0) {
				$this->log->write($payment . ': TransactionRequest ' . $ex . ' ' . $sisow->errorMessage);

				if($payment == 'sisowklarna' || $payment == 'sisowklarnaacc' || $payment == 'sisowfocum' || $payment == 'sisowbillink')
					$json['error'] = $ex . ' ' . $sisow->errorMessage;
				else if ($payment == 'sisowafterpay')
					$json['error'] = 'Het spijt ons u te moeten mededelen dat uw aanvraag om uw bestelling achteraf te betalen op dit moment niet door AfterPay wordt geaccepteerd. Dit kan om diverse (tijdelijke) redenen zijn.Voor vragen over uw afwijzing kunt u contact opnemen met de Klantenservice van AfterPay. Of kijk op de website van AfterPay bij “Veel gestelde vragen” via de link http://www.afterpay.nl/page/consument-faq onder het kopje “Gegevenscontrole”. Wij adviseren u voor een andere betaalmethode te kiezen om alsnog de betaling van uw bestelling af te ronden.';
				else
					$json['error'] = 'Geen communicatie mogelijk (' . $ex . ' ' . $sisow->errorCode . ')';
			}
			else if ($payment == 'sisowklarna' || $payment == 'sisowklaacc' || $payment == 'sisowfocum' || $payment == 'sisowafterpay' || $payment == 'sisowbillink') {
				if ($sisow->pendingKlarna)
					$this->model_checkout_order->confirm($order_info['order_id'], $this->config->get($payment . '_status_pending'));
				else
					$this->model_checkout_order->confirm($order_info['order_id'], $this->config->get($payment . '_status_success'));
				$message = 'Transactie ' . $sisow->trxId . ' gecontroleerd door Sisow.';
				if ($sisow->invoiceNo) {
					$message .= '<br/>'.$this->_getDesc($payment).' invoice ' . $sisow->invoiceNo . '';
				}
				else {
					$message .= '<br/><br/><a href="https://www.sisow.nl/Sisow/iDeal/RestHandler.ashx/CancelReservationRequest?report=true&merchantid=' . $this->config->get($payment . '_merchantid') . '&trxid=' . $sisow->trxId . '&sha1=' . sha1($sisow->trxId . $this->config->get($payment . '_merchantid') . $this->config->get($payment . '_merchantkey')) . '" target="_blank" onclick="return confirm(\'Bent u zeker? De '.$this->_getDesc($payment).' reservering wordt geannuleerd!\');">Annuleer '.$this->_getDesc($payment).' reservering</a>';
				}
				$message .= '<br/><br/><a href="https://www.sisow.nl/Sisow/iDeal/RestHandler.ashx/InvoiceRequest?report=true&'.($payment == 'sisowklaacc' ? '' : 'returnpdf=true&').'merchantid=' . $this->config->get($payment . '_merchantid') . '&trxid=' . $sisow->trxId . '&sha1=' . sha1($sisow->trxId . $this->config->get($payment . '_merchantid') . $this->config->get($payment . '_merchantkey')) . '" target="_blank" onclick="return confirm(\'Bent u zeker? De '.$this->_getDesc($payment).' factuur wordt gegenereerd!\');">Maak of open '.$this->_getDesc($payment).' factuur</a>';
				$message .= '<br/><br/><a href="https://www.sisow.nl/Sisow/iDeal/RestHandler.ashx/CreditInvoiceRequest?report=true&'.($payment == 'sisowklaacc' ? '' : 'returnpdf=true&').'merchantid=' . $this->config->get($payment . '_merchantid') . '&trxid=' . $sisow->trxId . '&sha1=' . sha1($sisow->trxId . $this->config->get($payment . '_merchantid') . $this->config->get($payment . '_merchantkey')) . '" target="_blank" onclick="return confirm(\'Bent u zeker? De '.$this->_getDesc($payment).' factuur wordt gecrediteerd!\');">Maak of open '.$this->_getDesc($payment).' creditnota</a>';
				$message .= '<br/><br/>';
				if ($sisow->pendingKlarna)
					$this->model_checkout_order->update($order_info['order_id'], $this->config->get($payment . '_status_pending'), $message, false);
				else
					$this->model_checkout_order->update($order_info['order_id'], $this->config->get($payment . '_status_success'), $message, false);

				$reurl = $this->url->link('checkout/success');
				$json['redirect'] = $reurl;
			}
			else if ($payment == 'sisowovb') {
				$this->model_checkout_order->confirm($order_info['order_id'], 1);
				$message = 'Transactie ' . $sisow->trxId . ' gecontroleerd door Sisow.<br />';
				$this->model_checkout_order->update($order_info['order_id'], 1, $message, false);

				$reurl = $this->url->link('checkout/success');
				
				$json['redirect'] = $reurl;
			}
			else {
				$json['redirect'] = $sisow->issuerUrl;
			}
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	public function _notify($payment) {
		if (isset($this->request->get['trxid'])) {
			$this->load->model('payment/' . $payment);

			$trxid = $this->request->get['trxid'];
			$order_id = $this->request->get['ec'];

			$this->load->model('checkout/order');
			$order_info = $this->model_checkout_order->getOrder($order_id);
			
			if($order_info['order_status_id'] == 0 || ($order_info['payment_code'] == 'sisowovb' && $order_info['order_status_id'] == 1))
			{
				if (($payment == 'sisowklarna' || $payment == 'sisowklaacc') && $this->request->get['action']) {
					if ($this->request->get['action'] == 'invoice') {
						$this->model_checkout_order->update($order_id, $order_info['order_status_id']);
						$message = 'Transactie ' . $trxid . ' gecontroleerd door Sisow.<br />';
						$message .= $this->_getDesc($payment).' invoice created.';
						$this->model_checkout_order->update($order_id, $order_info['order_status_id'], $message, false);
						echo 'OK';
					}
					else if ($this->request->get['action'] == 'creditinvoice') {
						$this->model_checkout_order->update($order_id, 7);
						$message = 'Transactie ' . $trxid . ' gecontroleerd door Sisow.<br />';
						$message .= $this->_getDesc($payment).' credit invoice created.';
						$this->model_checkout_order->update($order_id, 7, $message, false);
						echo 'OK';
					}
					else if ($this->request->get['action'] == 'cancelreservation') {
						$this->model_checkout_order->update($order_id, 7);
						$message = 'Transactie ' . $trxid . ' gecontroleerd door Sisow.<br />';
						$message .= $this->_getDesc($payment).' reservation cancelled.';
						$this->model_checkout_order->update($order_id, 7, $message, false);
						echo 'OK';
					}
					return;
				}

				$sisow = new Sisow($this->config->get($payment . '_merchantid'), $this->config->get($payment . '_merchantkey'), $this->config->get($payment . '_shopid'));
				if (($ex = $sisow->StatusRequest($trxid)) < 0) {
					$this->log->write($payment . ': StatusRequest ' . $ex . ' ' . $sisow->errorMessage);
					header("Status: 404 Not Found");
					echo 'NOK ' . $ex;
				}
				else {
					if ($sisow->status == 'Success' || $sisow->status == 'Reservation') {						
						$this->model_checkout_order->confirm($order_id, $this->config->get($payment . '_status_success'));
						$message = 'Transactie ' . $trxid . ' gecontroleerd door Sisow.<br />';
						if ($payment == 'sisowideal') {
							$message .= 'Bankrekening: ' . $sisow->consumerAccount . '.<br />';
							$message .= 'Ten name van: ' . $sisow->consumerName . '.<br />';
							$message .= 'Plaats: ' . $sisow->consumerCity . '.<br />';
						}

						$this->model_checkout_order->update($order_id, $this->config->get($payment . '_status_success'), $message, true);
					}
					if ($sisow->status == 'Denied') {

					}
				}
			}else{
				if(isset($_GET['notify']) || isset($_GET['callback'])){
					exit('order alreadey processed!');
				}
			}
		}
		
		if(!isset($_GET['notify']) && !isset($_GET['callback']))
		{
			if ($this->request->get['status'] == 'Success')
				header("Location: " . $this->url->link('checkout/success'));
			else
				header("Location: " . $this->url->link('checkout/checkout'));
		}
		exit;
	}
	
	private function _getRate($tax_class_id) {
		if (method_exists($this->tax, 'getRate')) {
			return $this->tax->getRate($tax_class_id);
		}
		else {
			$tax_rates = $this->tax->getRates(100, $tax_class_id);
			foreach ($tax_rates as $tax_rate) {
				return $tax_rate['amount'];
			}
		}
	}
	
	private function _getDesc($payment) {
		switch ($payment)
		{
			case 'sisowklarna':
				return 'Sisow Klarna Invoice';
			case 'sisowklaacc':
				return 'Sisow Klarna Account';
			default:
				return '';
		}
	}
}
?>
