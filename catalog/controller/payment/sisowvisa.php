<?php

include 'sisow.php';

class ControllerPaymentSisowVisa extends ControllerPaymentSisow {
	protected function index() {
		$this->_index('sisowvisa');
	}

	public function notify() {
		$this->_notify('sisowvisa');
	}

	public function redirectbank() {
		$this->_redirectbank('sisowvisa');
	}
}
?>
