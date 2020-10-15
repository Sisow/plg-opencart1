<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
<div class="box"> 
  <div class="left"></div> 
  <div class="right"></div> 
  
  <div class="heading">
    <h1><img src="view/image/payment.png" alt="" /> <?php echo $heading_title; ?></h1>
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location='<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
  </div>
  
  <div class="content">
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
    <table class="form">
      <tr>
        <td width="25%"><span class="required">*</span> <?php echo $entry_merchantid; ?><br /></td>
        <td colspan="2"><input type="text" name="sisowovb_merchantid" value="<?php echo $sisowovb_merchantid; ?>" />
          <br />
          <?php if ($error_username) { ?>
          <span class="error"><?php echo $error_username; ?></span>
          <?php } ?></td>
      </tr>
      <tr>
        <td width="25%"><span class="required">*</span> <?php echo $entry_merchantkey; ?><br /></td>
        <td colspan="2"><input type="text" name="sisowovb_merchantkey" value="<?php echo $sisowovb_merchantkey; ?>" />
          <br />
          <?php if ($error_username) { ?>
          <span class="error"><?php echo $error_username; ?></span>
          <?php } ?></td>
      </tr>
      <tr>
            <td><?php echo $entry_shopid; ?></td>
            <td colspan="2"><input type="text" name="sisowovb_shopid" value="<?php echo $sisowovb_shopid; ?>" /></td>
          </tr>  
      <tr>
	  <tr>
        <td> <?php echo $entry_ovbprefix; ?><br /></td>
        <td colspan="2"><input type="text" name="sisowovb_prefix" value="<?php echo $sisowovb_prefix; ?>" />
          <br />
        </td>
      </tr>
	  
	  <tr>
        <td><?php echo $entry_success; ?></td>
        <td colspan="2"><select name="sisowovb_status_success">
            <?php foreach ($order_statuses as $order_status) { ?>
            <?php if ($order_status['order_status_id'] == $sisowovb_status_success) { ?>
            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
            <?php } ?>
            <?php } ?>
          </select></td>
      </tr>
      <tr>
        <td><?php echo $entry_businessonly; ?></td>
        <td colspan="2"><select name="sisowovb_businessonly">
            <?php if ($sisowovb_businessonly=="true") { ?>
            <option value="true" selected="selected"><?php echo $text_yes; ?></option>
            <option value="false"><?php echo $text_no; ?></option>
            <?php } else { ?>
            <option value="true"><?php echo $text_yes; ?></option>
            <option value="false" selected="selected"><?php echo $text_no; ?></option>
            <?php } ?>
          </select></td>
      </tr>
      <tr>
        <td><?php echo $entry_days; ?></td>
        <td colspan="2"><input type="text" name="sisowovb_days" value="<?php echo $sisowovb_days; ?>" size="1" /></td>
      </tr>
      <tr>
        <td><?php echo $entry_paylink; ?></td>
        <td colspan="2"><select name="sisowovb_paylink">
            <?php if ($sisowovb_paylink=="true") { ?>
            <option value="true" selected="selected"><?php echo $text_yes; ?></option>
            <option value="false"><?php echo $text_no; ?></option>
            <?php } else { ?>
            <option value="true"><?php echo $text_yes; ?></option>
            <option value="false" selected="selected"><?php echo $text_no; ?></option>
            <?php } ?>
          </select></td>
      </tr>
	  	  <tr>
        <td><?php echo $entry_paymentfee; ?></td>
        <td colspan="2"><input type="text" name="sisowovb_paymentfee" value="<?php echo $sisowovb_paymentfee; ?>" /></td>
      </tr>
          <tr>
            <td><?php echo $entry_sisowovbfee_tax; ?></td>
            <td><select name="sisowovbfee_tax">
                <option value=""><?php echo $text_none; ?></option>
                <?php foreach ($tax_classes as $tax_class) { ?>
                <?php if ($tax_class['tax_class_id'] == $sisowovbfee_tax) { ?>
                <option value="<?php echo $tax_class['tax_class_id']; ?>" selected="selected"><?php echo $tax_class['title']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $tax_class['tax_class_id']; ?>"><?php echo $tax_class['title']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_total; ?></td>
            <td colspan="2"><input type="text" name="sisowovb_total" value="<?php echo $sisowovb_total; ?>" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_totalmax; ?></td>
            <td colspan="2"><input type="text" name="sisowovb_totalmax" value="<?php echo $sisowovb_totalmax; ?>" /></td>
          </tr>
        <tr>
          <td><?php echo $entry_geo_zone; ?></td>
          <td><select name="sisowovb_geo_zone_id">
              <option value="0"><?php echo $text_all_zones; ?></option>
              <?php foreach ($geo_zones as $geo_zone) { ?>
              <?php if ($geo_zone['geo_zone_id'] == $sisowovb_geo_zone_id) { ?>
              <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select></td>
        </tr>
      <tr>
        <td><?php echo $entry_status; ?></td>
        <td colspan="2"><select name="sisowovb_status">
            <?php if ($sisowovb_status) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
          </select></td>
      </tr>
      <tr>
        <td><?php echo $entry_sort_order; ?></td>
        <td colspan="2"><input type="text" name="sisowovb_sort_order" value="<?php echo $sisowovb_sort_order; ?>" size="1" /></td>
      </tr>
      <tr>
       <td colspan="3" height="24"></td>
      </tr>
      <tr>
       <td style="vertical-align: middle;"><?php echo $entry_version_status ?></td>
       <td colspan="2" style="vertical-align: middle;"><?php echo $text_version ?></td>
      </tr>
      <tr>
       <td><?php echo $entry_author; ?></td>
       <td>Sisow B.V.<br />
           Email: <a href="mailto:info@sisow.nl">info@sisow.nl</a><br />
           Web: <a href="http://www.sisow.nl" target="_blank">http://www.sisow.nl</a><br />
       </td>
       <td>
         <a href="mailto:info@sisow.nl">
	   <img src="view/image/payment/sisow.png" alt="Sisow" title="Sisow" height="60" />
	 </a>
       </td>
      </tr>
    </table>
    </form>
  </div>
<script type="text/javascript"><!--
$.tabs('.tabs a'); 
//--></script>
</div>
</div>
<?php echo $footer; ?>
