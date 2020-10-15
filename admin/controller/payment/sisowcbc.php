<?php 

include 'sisow/sisow.php';

class ControllerPaymentSisowCbc extends ControllerPaymentSisow {
	public function index() {
		$this->_index('sisowcbc');
	}

	public function validate() {
		return $this->_validate('sisowcbc');
	}
}
?>
