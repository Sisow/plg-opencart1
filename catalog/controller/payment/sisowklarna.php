<?php

include 'sisow.php';

class ControllerPaymentSisowKlarna extends ControllerPaymentSisow {
	protected function index() {
		$this->_index('sisowklarna');
	}

	public function notify() {
		$this->_notify('sisowklarna');
	}

	public function redirectbank() {
		$this->_redirectbank('sisowklarna');
	}
}
?>
