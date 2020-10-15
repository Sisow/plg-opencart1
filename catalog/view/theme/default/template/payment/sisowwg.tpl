<!--<h2><?php echo $text_header; ?></h2>-->
<div id="sisowwg_payment" class="checkout-content">
  <img src="https://www.sisow.nl/Sisow/images/ideal/logowsgc.gif" border="0" height="40" />
  <input type="hidden" name="payment" value="webshop"/>
</div>
<div class="buttons">
<?php if (substr(VERSION, 0, 3) == '1.4') { ?>
  <table>
    <tr>
      <td align="left"><a onclick="location = '<?php echo str_replace('&', '&amp;', $back); ?>'" class="button"><span><?php echo $button_back; ?></span></a></td>
      <td align="right"><a id="sisowwg_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></td>  
    </tr>
  </table>
<?php } else { ?>
  <div class="right"><a id="sisowwg_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></div>  
<?php } ?>
</div>

<script type="text/javascript"><!--
$('#sisowwg_confirm').on('click', function() {
	$.ajax({ 
		type: 'POST',
		url: 'index.php?route=payment/sisowwg/redirectbank',
		data: $('#sisowwg_payment :input'),
		dataType: 'json',
		cache: false,
		beforeSend: function() {
			$('#sisowwg_confirm').button('loading');
		},
		complete: function() {
			$('#sisowwg_confirm').button('reset');
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

