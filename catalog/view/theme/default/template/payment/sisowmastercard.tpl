<!--<h2><?php echo $text_header; ?></h2>-->
<div id="sisowmastercard_payment" class="checkout-content">
<input type="hidden" name="payment" value="mastercard"/>
  <img src="catalog/view/theme/default/image/mastercard.png" height="75px"/>
</div>
<div class="buttons">
<?php if (substr(VERSION, 0, 3) == '1.4') { ?>
  <table>
    <tr>
      <td align="left"><a onclick="location = '<?php echo str_replace('&', '&amp;', $back); ?>'" class="button"><span><?php echo $button_back; ?></span></a></td>
      <td align="right"><a id="sisowmastercard_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></td>  
    </tr>
  </table>
<?php } else { ?>
  <div class="right"><a id="sisowmastercard_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></div>  
<?php } ?>
</div>

<script type="text/javascript"><!--
$('#sisowmastercard_confirm').on('click', function() {
	$.ajax({ 
		type: 'POST',
		url: 'index.php?route=payment/sisowmastercard/redirectbank',
		data: $('#sisowideal_payment :input'),
		dataType: 'json',
		cache: false,
		beforeSend: function() {
			$('#sisowmastercard_confirm').button('loading');
		},
		complete: function() {
			$('#sisowmastercard_confirm').button('reset');
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
