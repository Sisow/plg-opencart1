<?php 

include 'sisow/sisow.php';

class ControllerPaymentSisowKbc extends ControllerPaymentSisow {
	public function index() {
		$this->_index('sisowkbc');
	}

	public function validate() {
		return $this->_validate('sisowkbc');
	}
}
?>
