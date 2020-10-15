<?php 

include 'sisow/sisow.php';

class ControllerPaymentSisowVisa extends ControllerPaymentSisow {
	public function index() {
		$this->_index('sisowvisa');
	}

	public function validate() {
		return $this->_validate('sisowvisa');
	}
}
?>
