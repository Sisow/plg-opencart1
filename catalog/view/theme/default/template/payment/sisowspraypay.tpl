<!--<h2><?php echo $text_header; ?></h2>-->
<div id="sisowspraypay_payment" class="checkout-content">
<input type="hidden" name="payment" value="spraypay"/>
  <img src="https://www.sisow.nl/logo/payment/spraypay.png" height="75px"/>
</div>
<div class="buttons">
<?php if (substr(VERSION, 0, 3) == '1.4') { ?>
  <table>
    <tr>
      <td align="left"><a onclick="location = '<?php echo str_replace('&', '&amp;', $back); ?>'" class="button"><span><?php echo $button_back; ?></span></a></td>
      <td align="right"><a id="sisowspraypay_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></td>  
    </tr>
  </table>
<?php } else { ?>
  <div class="right"><a id="sisowspraypay_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></div>  
<?php } ?>
</div>

<script type="text/javascript"><!--
$('#sisowspraypay_confirm').on('click', function() {
	$.ajax({ 
		type: 'POST',
		url: 'index.php?route=payment/sisowspraypay/redirectbank',
		data: $('#sisowspraypay_payment :input'),
		dataType: 'json',
		cache: false,
		beforeSend: function() {
			$('#sisowspraypay_confirm').button('loading');
		},
		complete: function() {
			$('#sisowspraypay_confirm').button('reset');
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
