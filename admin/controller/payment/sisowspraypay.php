<?php 

include 'sisow/sisow.php';

class ControllerPaymentSisowSpraypay extends ControllerPaymentSisow {
	public function index() {
		$this->_index('sisowspraypay');
	}

	public function validate() {
		return $this->_validate('sisowspraypay');
	}
}
?>
