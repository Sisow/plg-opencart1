<link rel="stylesheet" href="https://bankauswahl.giropay.de/widget/v2/style.css" />
<script src="https://bankauswahl.giropay.de/widget/v2/girocheckoutwidget.js"></script>

<!--<h2><?php echo $text_header; ?></h2>-->
<div id="sisowideal_payment" class="checkout-content">
  <img src="catalog/view/theme/default/image/eps.png" alt="EPS" title="EPS" style="vertical-align: middle;" /><br/>
  Mit eps Online-&Uuml;berweisung zahlen Sie einfach, schnell und sicher im Online-Banking Ihrer Bank. Im n&auml;chsten Schritt werden Sie direkt zum Online-Banking Ihrer Bank weitergeleitet, wo Sie die Zahlung durch Eingabe von PIN und TAN freigeben.<br/>
<form id="payment" class="form-horizontal">
  <div class="form-group required">
	  <label class="col-sm-2 control-label" for="bic_eps">Bankleitzahl:</label>
	  <div class="col-xs-10 col-sm-10 col-md-3 col-lg-2">
		<input type="text" name="bic_eps" id="bic_eps"  class="form-control" onkeyup="girocheckout_widget(this, event, 'bic', '3')"/>
	  </div>
	</div>
	</form>
</div>
<div class="buttons">
<?php if (substr(VERSION, 0, 3) == '1.4') { ?>
  <table>
    <tr>
      <td align="left"><a onclick="location = '<?php echo str_replace('&', '&amp;', $back); ?>'" class="button"><span><?php echo $button_back; ?></span></a></td>
      <td align="right"><a id="sisoweps_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></td>  
    </tr>
  </table>
<?php } else { ?>
  <div class="right"><a id="sisoweps_confirm" class="button"><span><?php echo $button_confirm; ?></span></a></div>  
<?php } ?>
</div>

<script type="text/javascript"><!--
$('#sisoweps_confirm').on('click', function() {
	$.ajax({ 
		type: 'POST',
		url: 'index.php?route=payment/sisoweps/redirectbank',
		data: $('#sisowideal_payment :input'),
		dataType: 'json',
		cache: false,
		beforeSend: function() {
			$('#sisoweps_confirm').button('loading');
		},
		complete: function() {
			$('#sisoweps_confirm').button('reset');
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