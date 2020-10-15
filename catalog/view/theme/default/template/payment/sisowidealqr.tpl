<!--<h2><?php echo $text_header; ?></h2>-->
<div id="sisowidealqr_payment" class="checkout-content">
<input type="hidden" name="payment" value="idealqr"/>
  <img src="catalog/view/theme/default/image/ideal.png" height="75px"/>
</div>
<div class="buttons">
<?php if (substr(VERSION, 0, 3) == '1.4') { ?>
  <table>
    <tr>
      <td align="left"><a onclick="location = '<?php echo str_replace('&', '&amp;', $back); ?>'" class="button"><span><?php echo $button_back; ?></span></a></td>
      <td align="right"><a id="sisowidealqr_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></td>  
    </tr>
  </table>
<?php } else { ?>
  <div class="right"><a id="sisowidealqr_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></div>  
<?php } ?>
</div>

<script type="text/javascript"><!--
$('#sisowidealqr_confirm').on('click', function() {
	$.ajax({ 
		type: 'POST',
		url: 'index.php?route=payment/sisowidealqr/redirectbank',
		data: $('#sisowidealqr_payment :input'),
		dataType: 'json',
		cache: false,
		beforeSend: function() {
			$('#sisowidealqr_confirm').button('loading');
		},
		complete: function() {
			$('#sisowidealqr_confirm').button('reset');
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
