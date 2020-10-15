<?php

include 'sisow.php';

class ControllerPaymentSisowSpraypay extends ControllerPaymentSisow {
	protected function index() {
		$this->_index('sisowspraypay');
	}

	public function notify() {
		$this->_notify('sisowspraypay');
	}

	public function redirectbank() {
		$this->_redirectbank('sisowspraypay');
	}
}
?>
