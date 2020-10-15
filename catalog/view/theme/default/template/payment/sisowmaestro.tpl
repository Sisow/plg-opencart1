<!--<h2><?php echo $text_header; ?></h2>-->
<div id="sisowideal_payment" class="checkout-content">
<input type="hidden" name="payment" value="maestro"/>
  <img src="catalog/view/theme/default/image/maestro.png" height="75px"/>
</div>
<div class="buttons">
<?php if (substr(VERSION, 0, 3) == '1.4') { ?>
  <table>
    <tr>
      <td align="left"><a onclick="location = '<?php echo str_replace('&', '&amp;', $back); ?>'" class="button"><span><?php echo $button_back; ?></span></a></td>
      <td align="right"><a id="sisowmaestro_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></td>  
    </tr>
  </table>
<?php } else { ?>
  <div class="right"><a id="sisowmaestro_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></div>  
<?php } ?>
</div>

<script type="text/javascript"><!--
$('#sisowmaestro_confirm').on('click', function() {
	$.ajax({ 
		type: 'POST',
		url: 'index.php?route=payment/sisowmaestro/redirectbank',
		data: $('#sisowideal_payment :input'),
		dataType: 'json',
		cache: false,
		beforeSend: function() {
			$('#sisowmaestro_confirm').button('loading');
		},
		complete: function() {
			$('#sisowmaestro_confirm').button('reset');
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
