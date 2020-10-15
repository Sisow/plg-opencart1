<?php 

include 'sisow/sisow.php';

class ControllerPaymentSisowEps extends ControllerPaymentSisow {
	public function index() {
		$this->_index('sisoweps');
	}

	public function validate() {
		return $this->_validate('sisoweps');
	}
}
?>
