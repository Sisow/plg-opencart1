<!--<h2><?php echo $text_header; ?></h2>-->
<div id="sisowbunq_payment" class="checkout-content">
<input type="hidden" name="payment" value="bunq"/>
  <img src="catalog/view/theme/default/image/bunq.png" height="75px"/>
</div>
<div class="buttons">
<?php if (substr(VERSION, 0, 3) == '1.4') { ?>
  <table>
    <tr>
      <td align="left"><a onclick="location = '<?php echo str_replace('&', '&amp;', $back); ?>'" class="button"><span><?php echo $button_back; ?></span></a></td>
      <td align="right"><a id="sisowbunq_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></td>  
    </tr>
  </table>
<?php } else { ?>
  <div class="right"><a id="sisowbunq_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></div>  
<?php } ?>
</div>
<script type="text/javascript"><!--
$('#sisowbunq_confirm').on('click', function() {
	$.ajax({ 
		type: 'POST',
		url: 'index.php?route=payment/sisowbunq/redirectbank',
		data: $('#sisowbunq_payment :input'),
		dataType: 'json',
		cache: false,
		beforeSend: function() {
			$('#sisowbunq_confirm').button('loading');
		},
		complete: function() {
			$('#sisowbunq_confirm').button('reset');
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
