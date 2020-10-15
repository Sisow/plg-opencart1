<?php 

include 'sisow/sisow.php';

class ControllerPaymentSisowFocum extends ControllerPaymentSisow {
	public function index() {
		$this->_index('sisowfocum');
	}

	public function validate() {
		return $this->_validate('sisowfocum');
	}
}
?>
