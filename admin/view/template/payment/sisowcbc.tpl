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
        <td colspan="2"><input type="text" name="sisowcbc_merchantid" value="<?php echo $sisowcbc_merchantid; ?>" />
          <br />
          <?php if ($error_username) { ?>
          <span class="error"><?php echo $error_username; ?></span>
          <?php } ?></td>
      </tr>
      <tr>
        <td width="25%"><span class="required">*</span> <?php echo $entry_merchantkey; ?><br /></td>
        <td colspan="2"><input type="text" name="sisowcbc_merchantkey" value="<?php echo $sisowcbc_merchantkey; ?>" />
          <br />
          <?php if ($error_username) { ?>
          <span class="error"><?php echo $error_username; ?></span>
          <?php } ?></td>
      </tr>
	  <tr>
            <td><?php echo $entry_shopid; ?></td>
            <td colspan="2"><input type="text" name="sisowcbc_shopid" value="<?php echo $sisowcbc_shopid; ?>" /></td>
          </tr>  
      <tr>
      <tr>
        <td><?php echo $entry_success; ?></td>
        <td colspan="2"><select name="sisowcbc_status_success">
            <?php foreach ($order_statuses as $order_status) { ?>
            <?php if ($order_status['order_status_id'] == $sisowcbc_status_success) { ?>
            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
            <?php } ?>
            <?php } ?>
          </select></td>
      </tr>
      <tr>
        <td><?php echo $entry_testmode; ?></td>
        <td colspan="2"><select name="sisowcbc_testmode">
            <?php if ($sisowcbc_testmode=="true") { ?>
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
        <td colspan="2"><input type="text" name="sisowcbc_paymentfee" value="<?php echo $sisowcbc_paymentfee; ?>" /></td>
      </tr>
          <tr>
            <td><?php echo $entry_sisowcbcfee_tax; ?></td>
            <td><select name="sisowcbcfee_tax">
                <option value=""><?php echo $text_none; ?></option>
                <?php foreach ($tax_classes as $tax_class) { ?>
                <?php if ($tax_class['tax_class_id'] == $sisowcbcfee_tax) { ?>
                <option value="<?php echo $tax_class['tax_class_id']; ?>" selected="selected"><?php echo $tax_class['title']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $tax_class['tax_class_id']; ?>"><?php echo $tax_class['title']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_total; ?></td>
            <td colspan="2"><input type="text" name="sisowcbc_total" value="<?php echo $sisowcbc_total; ?>" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_totalmax; ?></td>
            <td colspan="2"><input type="text" name="sisowcbc_totalmax" value="<?php echo $sisowcbc_totalmax; ?>" /></td>
          </tr>
        <tr>
          <td><?php echo $entry_geo_zone; ?></td>
          <td><select name="sisowcbc_geo_zone_id">
              <option value="0"><?php echo $text_all_zones; ?></option>
              <?php foreach ($geo_zones as $geo_zone) { ?>
              <?php if ($geo_zone['geo_zone_id'] == $sisowcbc_geo_zone_id) { ?>
              <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select></td>
        </tr>
      <tr>
        <td><?php echo $entry_status; ?></td>
        <td colspan="2"><select name="sisowcbc_status">
            <?php if ($sisowcbc_status) { ?>
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
        <td colspan="2"><input type="text" name="sisowcbc_sort_order" value="<?php echo $sisowcbc_sort_order; ?>" size="1" /></td>
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
