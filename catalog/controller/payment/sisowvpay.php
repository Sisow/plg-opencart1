<?php

include 'sisow.php';

class ControllerPaymentSisowVpay extends ControllerPaymentSisow {
	protected function index() {
		$this->_index('sisowvpay');
	}

	public function notify() {
		$this->_notify('sisowvpay');
	}

	public function redirectbank() {
		$this->_redirectbank('sisowvpay');
	}
}
?>
