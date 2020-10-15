<form id="sisowafterpay_payment" class="form-horizontal">
	<fieldset>
		<img src="https://www.afterpay.nl/assets/images/logo.jpg" alt="Afterpay" title="Afterpay" style="vertical-align: middle;" /><br/>
		
		<div class="form-group required">
			<label class="col-sm-2 control-label" for="gender">Aanhef</label>
			<div class="col-sm-10">
				<select name="sisowgender" id="gender" class="form-control">
					<option value="">Kies aanhef</option>
					<option value="M">De heer</option>
					<option value="F">Mevrouw</option>
				</select>
			</div>
		</div>
		
		<div class="form-group required">
			<label class="col-sm-2 control-label" for="sisowphone">Telefoonnummer</label>
			<div class="col-sm-10">
				<input type="text" id="sisowphone" name="sisowphone" class="form-control" maxlength="12" value="" />
			</div>
		</div>
		
		<div class="form-group required">
			<label class="col-sm-2 control-label" for="sisowday">Geboortedatum</label>
			<div class="col-sm-10">
				<select id="sisowday" name="sisowday">
					<option value="">Dag</option>
					<?php for($i = 1; $i < 32; $i++) { ?>
						<option value="<?php print_r(sprintf("%02d", $i)); ?>"><?php echo $i; ?></option>
					<?php } ?>
				</select>
				<select id="sisowmonth" name="sisowmonth">
					<option value="">Maand</option>
					<?php for($i = 1; $i < 13; $i++) { ?>
						<option value="<?php print_r(sprintf("%02d", $i)); ?>"><?php echo $i; ?></option>
					<?php } ?>
				</select>
				<select id="sisowyear" name="sisowyear">
					<option value="">Jaar</option>
					<?php for($i = date("Y") - 17; $i > date("Y") - 150; $i--) { ?>
						<option value="<?php print_r(sprintf("%02d", $i)); ?>"><?php echo $i; ?></option>
					<?php } ?>
				</select>
			</div>
		</div>
		
		<?php if($afterpay_b2b == 'true') {?>
			
			<div class="form-group required">
				<label class="col-sm-2 control-label" for="sisowcoc">KvK nummer</label>
				<div class="col-sm-10">
					<input type="text" id="sisowcoc" name="sisowcoc" class="form-control" maxlength="10" value="" />
				</div>
			</div>
			
		<?php } ?>
		
		<div class="checkbox required">
			<div class="col-sm-10 col-sm-offset-2">
				<label>
					<input type="checkbox" name="afterpay_terms" value="agree"> Ik ga akkoord met de <a href="<?php echo $afterpay_terms; ?>" target="_blank">betalingsvoorwaarden</a> van Afterpay
				</label>
			</div>
		</div>
		
		<?php echo $text_paymentfee; ?>

		<div class="buttons pull-right">
			<input type="button" value="<?php echo $button_confirm; ?>" id="sisowafterpay_confirm" class="btn btn-primary" />
		</div>
	</fieldset>
</form>
<script type="text/javascript"><!--
	$('#sisowafterpay_confirm').on('click', function() {
		$.ajax({ 
			type: 'POST',
			url: 'index.php?route=payment/sisowafterpay/redirectbank',
			data: jQuery('#sisowafterpay_payment').serializeArray(),
			dataType: 'json',
			cache: false,
			beforeSend: function() {
				$('#sisowafterpay_confirm').button('loading');
			},
			complete: function() {
				$('#sisowafterpay_confirm').button('reset');
			},		
			success: function(json) {
				if (json['error']) {
					alert(json['error']);
				}
				
				if (json['redirect']) {
					location = json['redirect'];
				}
			}		
		});
	});
	//-->
</script>

