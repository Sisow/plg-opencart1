<?php

include 'sisow.php';

class ControllerPaymentSisowGiropay extends ControllerPaymentSisow {
	protected function index() {
		$this->_index('sisowgiropay');
	}

	public function notify() {
		$this->_notify('sisowgiropay');
	}

	public function redirectbank() {
		$this->_redirectbank('sisowgiropay');
	}
}
?>
