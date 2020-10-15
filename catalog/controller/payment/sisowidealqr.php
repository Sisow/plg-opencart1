<?php

include 'sisow.php';

class ControllerPaymentSisowIdealqr extends ControllerPaymentSisow {
	protected function index() {
		$this->_index('sisowidealqr');
	}

	public function notify() {
		$this->_notify('sisowidealqr');
	}

	public function redirectbank() {
		$this->_redirectbank('sisowidealqr');
	}
}
?>
