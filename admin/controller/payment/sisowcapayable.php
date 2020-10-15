<?php 

include 'sisow/sisow.php';

class ControllerPaymentSisowCapayable extends ControllerPaymentSisow {
	public function index() {
		$this->_index('sisowcapayable');
	}

	public function validate() {
		return $this->_validate('sisowcapayable');
	}
}
?>
