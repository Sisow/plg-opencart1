<?php

include 'sisow.php';

class ControllerPaymentSisowVvv extends ControllerPaymentSisow {
	protected function index() {
		$this->_index('sisowvvv');
	}

	public function notify() {
		$this->_notify('sisowvvv');
	}

	public function redirectbank() {
		$this->_redirectbank('sisowvvv');
	}
}
?>
