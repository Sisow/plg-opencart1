<?php 

include 'sisow/sisow.php';

class ControllerPaymentSisowBelfius extends ControllerPaymentSisow {
	public function index() {
		$this->_index('sisowbelfius');
	}

	public function validate() {
		return $this->_validate('sisowbelfius');
	}
}
?>
