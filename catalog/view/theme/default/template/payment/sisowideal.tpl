<!--<h2><?php echo $text_header; ?></h2>-->
<div id="sisowideal_payment" class="checkout-content">
  <img src="catalog/view/theme/default/image/ideal.png" height="75px"/>
  <?php echo $text_bank; ?>
  &nbsp;
  <select id="sisowbank" name="sisowbank">
    <option value="">Kies uw bank...</option>
<?php foreach ($banks as $bankid => $bankname) { ?>
    <option value="<?php echo $bankid; ?>"><?php echo $bankname; ?></option>
<?php } ?>
  </select>
</div>
<div class="buttons">
<?php if (substr(VERSION, 0, 3) == '1.4') { ?>
  <table>
    <tr>
      <td align="left"><a onclick="location = '<?php echo str_replace('&', '&amp;', $back); ?>'" class="button"><span><?php echo $button_back; ?></span></a></td>
      <td align="right"><a id="sisowideal_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></td>  
    </tr>
  </table>
<?php } else { ?>
  <div class="right"><a id="sisowideal_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></div>  
<?php } ?>
</div>

<script type="text/javascript"><!--
$('#sisowideal_confirm').on('click', function() {
	$.ajax({ 
		type: 'POST',
		url: 'index.php?route=payment/sisowideal/redirectbank',
		data: $('#sisowideal_payment :input'),
		dataType: 'json',
		cache: false,
		beforeSend: function() {
			$('#sisowideal_confirm').button('loading');
		},
		complete: function() {
			$('#sisowideal_confirm').button('reset');
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
//--></script> 
