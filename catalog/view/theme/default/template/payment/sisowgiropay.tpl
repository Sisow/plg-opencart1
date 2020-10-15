<!--<h2><?php echo $text_header; ?></h2>-->
<link rel="stylesheet" href="https://bankauswahl.giropay.de/widget/v2/style.css" />
<script src="https://bankauswahl.giropay.de/widget/v2/girocheckoutwidget.js"></script>
 
<div id="sisowideal_payment" class="checkout-content">
  <img src="catalog/view/theme/default/image/giropay.png" alt="Giropay" title="Giropay" style="vertical-align: middle;" /><br/>
  Mit giropay zahlen Sie einfach, schnell und sicher im Online-Banking Ihrer teilnehmenden Bank oder Sparkasse. Sie werden direkt zum Online-Banking Ihrer Bank weitergeleitet, wo Sie die &Uuml;berweisung durch Eingabe von PIN und TAN freigeben.<br/>
<form id="payment" class="form-horizontal">
  <div class="form-group required">
	  <label class="col-sm-2 control-label" for="bic_giropay">Bankleitzahl:</label>
	  <div class="col-xs-10 col-sm-10 col-md-3 col-lg-2">
		<input type="text" id="giropay_bic" name="giropay_bic" value="" onkeyup="girocheckout_widget(this, event, 'bic', '0')">
	  </div>
	</div>
	</form>
</div>
<div class="buttons">
<?php if (substr(VERSION, 0, 3) == '1.4') { ?>
  <table>
    <tr>
      <td align="left"><a onclick="location = '<?php echo str_replace('&', '&amp;', $back); ?>'" class="button"><span><?php echo $button_back; ?></span></a></td>
      <td align="right"><a id="sisowgiropay_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></td>  
    </tr>
  </table>
<?php } else { ?>
  <div class="right"><a id="sisowgiropay_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></div>  
<?php } ?>
</div>
<script type="text/javascript"><!--
$('#sisowgiropay_confirm').on('click', function() {
	$.ajax({ 
		type: 'POST',
		url: 'index.php?route=payment/sisowgiropay/redirectbank',
		data: $('#sisowideal_payment :input'),
		dataType: 'json',
		cache: false,
		beforeSend: function() {
			$('#sisowgiropay_confirm').button('loading');
		},
		complete: function() {
			$('#sisowgiropay_confirm').button('reset');
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