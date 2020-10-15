<!--<h2><?php echo $text_header; ?></h2>-->
<div id="sisowpp_payment" class="checkout-content">
  <img src="https://www.sisow.nl/Sisow/images/ideal/paypal.gif" border="0" />
  <input type="hidden" name="payment" value="paypalec"/>
</div>
<div class="buttons">
<?php if (substr(VERSION, 0, 3) == '1.4') { ?>
  <table>
    <tr>
      <td align="left"><a onclick="location = '<?php echo str_replace('&', '&amp;', $back); ?>'" class="button"><span><?php echo $button_back; ?></span></a></td>
      <td align="right"><a id="sisowpp_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></td>  
    </tr>
  </table>
<?php } else { ?>
  <div class="right"><a id="sisowpp_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></div>  
<?php } ?>
</div>
<script type="text/javascript"><!--
$('#sisowpp_confirm').on('click', function() {
	$.ajax({ 
		type: 'POST',
		url: 'index.php?route=payment/sisowpp/redirectbank',
		data: $('#sisowpp_payment :input'),
		dataType: 'json',
		cache: false,
		beforeSend: function() {
			$('#sisowpp_confirm').button('loading');
		},
		complete: function() {
			$('#sisowpp_confirm').button('reset');
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

