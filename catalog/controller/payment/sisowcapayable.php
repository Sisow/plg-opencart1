<?php
 
include 'sisow.php';

class ControllerPaymentSisowCapayable extends ControllerPaymentSisow {
	protected function index() {
		$this->_index('sisowcapayable');
	}

	public function notify() {
		$this->_notify('sisowcapayable');
	}

	public function redirectbank() {
		$this->_redirectbank('sisowcapayable');
	}
}
?>
