<!--<h2><?php echo $text_header; ?></h2>-->
<div id="sisowde_payment" class="checkout-content">
<input type="hidden" name="payment" value="sofort"/>
  <img src="https://www.sisow.nl/Sisow/images/ideal/payment_small.png" border="0" />
</div>
<div class="buttons">
<?php if (substr(VERSION, 0, 3) == '1.4') { ?>
  <table>
    <tr>
      <td align="left"><a onclick="location = '<?php echo str_replace('&', '&amp;', $back); ?>'" class="button"><span><?php echo $button_back; ?></span></a></td>
      <td align="right"><a id="sisowde_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></td>  
    </tr>
  </table>
<?php } else { ?>
  <div class="right"><a id="sisowde_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></div>  
<?php } ?>
</div>
<script type="text/javascript"><!--
$('#sisowde_confirm').on('click', function() {
	$.ajax({ 
		type: 'POST',
		url: 'index.php?route=payment/sisowde/redirectbank',
		data: $('#sisowde_payment :input'),
		dataType: 'json',
		cache: false,
		beforeSend: function() {
			$('#sisowde_confirm').button('loading');
		},
		complete: function() {
			$('#sisowde_confirm').button('reset');
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
