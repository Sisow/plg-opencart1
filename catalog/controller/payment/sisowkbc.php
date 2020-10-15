<?php
 
include 'sisow.php';

class ControllerPaymentSisowKbc extends ControllerPaymentSisow {
	protected function index() {
		$this->_index('sisowkbc');
	}

	public function notify() {
		$this->_notify('sisowkbc');
	}

	public function redirectbank() {
		$this->_redirectbank('sisowkbc');
	}
}
?>
