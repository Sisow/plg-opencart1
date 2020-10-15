<?php
 
include 'sisow.php';

class ControllerPaymentSisowBunq extends ControllerPaymentSisow {
	protected function index() {
		$this->_index('sisowbunq');
	}

	public function notify() {
		$this->_notify('sisowbunq');
	}

	public function redirectbank() {
		$this->_redirectbank('sisowbunq');
	}
}
?>
