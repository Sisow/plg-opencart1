<?php
 
include 'sisow.php';

class ControllerPaymentSisowBillink extends ControllerPaymentSisow {
	protected function index() {
		$this->_index('sisowbillink');
	}

	public function notify() {
		$this->_notify('sisowbillink');
	}

	public function redirectbank() {
		$this->_redirectbank('sisowbillink');
	}
}
?>
