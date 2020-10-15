<!--<h2><?php echo $text_header; ?></h2>-->
<div id="sisowovb_payment" class="checkout-content">
<input type="hidden" name="payment" value="overboeking"/>
  <img src="https://www.sisow.nl/Sisow/images/ideal/logo_sisow_klein.png" alt="Sisow OverBoeking" title="Sisow OverBoeking" style="vertical-align: middle;" />
  <br/>
  <?php echo $text_ovb; ?>
</div>
<div class="buttons">
<?php if (substr(VERSION, 0, 3) == '1.4') { ?>
  <table>
    <tr>
      <td align="left"><a onclick="location = '<?php echo str_replace('&', '&amp;', $back); ?>'" class="button"><span><?php echo $button_back; ?></span></a></td>
      <td align="right"><a id="sisowovb_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></td>  
    </tr>
  </table>
<?php } else { ?>
  <div class="right"><a id="sisowovb_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></div>  
<?php } ?>
</div>

<script type="text/javascript"><!--
$('#sisowovb_confirm').on('click', function() {
	$.ajax({ 
		type: 'POST',
		url: 'index.php?route=payment/sisowovb/redirectbank',
		data: $('#sisowovb_payment :input'),
		dataType: 'json',
		cache: false,
		beforeSend: function() {
			$('#sisowovb_confirm').button('loading');
		},
		complete: function() {
			$('#sisowovb_confirm').button('reset');
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