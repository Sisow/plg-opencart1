<?php 

include 'sisow/sisow.php';

class ControllerPaymentSisowIdealqr extends ControllerPaymentSisow {
	public function index() {
		$this->_index('sisowidealqr');
	}

	public function validate() {
		return $this->_validate('sisowidealqr');
	}
}
?>
