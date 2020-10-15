<?php

include 'sisow.php';

class ControllerPaymentSisowEps extends ControllerPaymentSisow {
	protected function index() {
		$this->_index('sisoweps');
	}

	public function notify() {
		$this->_notify('sisoweps');
	}

	public function redirectbank() {
		$this->_redirectbank('sisoweps');
	}
}
?>
