<?php 

include 'sisow/sisow.php';

class ControllerPaymentSisowBillink extends ControllerPaymentSisow {
	public function index() {
		$this->_index('sisowbillink');
	}

	public function validate() {
		return $this->_validate('sisowbillink');
	}
}
?>
