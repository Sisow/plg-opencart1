<?php

include 'sisow.php';

class ControllerPaymentSisowAfterpay extends ControllerPaymentSisow {
	protected function index() {
		$this->_index('sisowafterpay');
	}

	public function notify() {
		$this->_notify('sisowafterpay');
	}

	public function redirectbank() {
		$this->_redirectbank('sisowafterpay');
	}
}
?>
