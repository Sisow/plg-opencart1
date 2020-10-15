<?php

include 'sisow.php';

class ControllerPaymentSisowHomepay extends ControllerPaymentSisow {
	protected function index() {
		$this->_index('sisowhomepay');
	}

	public function notify() {
		$this->_notify('sisowhomepay');
	}

	public function redirectbank() {
		$this->_redirectbank('sisowhomepay');
	}
}
?>
