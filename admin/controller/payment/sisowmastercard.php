<?php 

include 'sisow/sisow.php';

class ControllerPaymentSisowMastercard extends ControllerPaymentSisow {
	public function index() {
		$this->_index('sisowmastercard');
	}

	public function validate() {
		return $this->_validate('sisowmastercard');
	}
}
?>
