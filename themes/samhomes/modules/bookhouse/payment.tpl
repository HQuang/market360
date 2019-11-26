<!-- BEGIN: main -->
<div class="payment">
    <ul class="list-info">
        <li><label>{LANG.account}:</label> {USER_INFO.username}</li>
        <li><label>ID {LANG.account}:</label> {USER_INFO.userid}</li>
    </ul>
    <!-- BEGIN: refresh -->
    <p>{LANG.payment_refresh_note}</p>
    <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover">
            <colgroup>
                <col span="2" />
                <col width="200" />
            </colgroup>
            <thead>
                <tr>
                    <th>{LANG.refresh_number}</th>
                    <th>{LANG.price}</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <!-- BEGIN: option -->
                <tr>
                    <td>{OPTION.number}</td>
                    <td>{OPTION.price_format}<sup>{MONEY_UNIT}</sup></td>
                    <td class="text-center"><input type="radio" name="option" value="{OPTION.number}" data-price="{OPTION.price_sale}" data-tokenkey="{OPTION.tokenkey}" data-checksum="{OPTION.checksum}" class="payment-option" {OPTION.checked} /> <!-- BEGIN: discount --> <span class="show price_discount">{LANG.price_discount} {OPTION.price_discount}<sup>{MONEY_UNIT}</sup></span> <!-- END: discount --></td>
                </tr>
                <!-- END: option -->
            </tbody>
        </table>
    </div>
    <!-- END: refresh -->
    <!-- BEGIN: group -->
    <div class="payment-group">
        <p>{GROUP.description}</p>
        <div class="table-responsive">
            <table class="table table-striped table-bordered table-hover">
                <colgroup>
                    <col span="2" />
                    <col width="200" />
                </colgroup>
                <thead>
                    <tr>
                        <th>{LANG.time}</th>
                        <th>{LANG.price}</th>
                        <th class="text-center">{LANG.buy_chosen}</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- BEGIN: option -->
                    <tr>
                        <td>{OPTION.time} {OPTION.unit}</td>
                        <td>{OPTION.price_format}<sup>{MONEY_UNIT}</sup></td>
                        <td class="text-center"><input type="radio" name="option" value="{OPTION.time}" data-groupid="{GROUP.bid}" data-price="{OPTION.price_sale}" data-tokenkey="{OPTION.tokenkey}" data-checksum="{OPTION.checksum}" class="payment-option" onchange="nv_payment_option_change($(this)); return !1;" {OPTION.checked} /> <!-- BEGIN: discount --> <span class="show price_discount">{LANG.price_discount} {OPTION.price_discount}<sup>{MONEY_UNIT}</sup></span> <!-- END: discount --></td>
                    </tr>
                    <!-- END: option -->
                </tbody>
            </table>
        </div>
    </div>
    <!-- END: group -->
    <!-- BEGIN: upgrade_group -->
    <div class="payment-group">
        <p>{GROUP.description}</p>
        <div class="table-responsive">
            <table class="table table-striped table-bordered table-hover">
                <colgroup>
                    <col span="2" />
                    <col width="200" />
                </colgroup>
                <thead>
                    <tr>
                        <th>{LANG.time}</th>
                        <th>{LANG.price}</th>
                        <th class="text-center">{LANG.buy_chosen}</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- BEGIN: option -->
                    <tr>
                        <td>{OPTION.time} {OPTION.unit}</td>
                        <td>{OPTION.price_format}<sup>{MONEY_UNIT}</sup></td>
                        <td class="text-center"><input type="radio" name="option" value="{OPTION.time}" data-groupid="{GROUP.bid}" data-price="{OPTION.price_sale}" data-tokenkey="{OPTION.tokenkey}" data-checksum="{OPTION.checksum}" class="payment-option" onchange="nv_payment_option_change($(this)); return !1;" {OPTION.checked} /> <!-- BEGIN: discount --> <span class="show price_discount">{LANG.price_discount} {OPTION.price_discount}<sup>{MONEY_UNIT}</sup></span> <!-- END: discount --></td>
                    </tr>
                    <!-- END: option -->
                </tbody>
            </table>
        </div>
    </div>
    <!-- END: upgrade_group -->
    <div class="text-center">
        <button class="btn btn-warning ws_c_d" id="payment-btn" data_product_id="{GROUP.id}" data_title="{INFO.title}" data_money="{FIRST.price_sale}" data_money_unit="VND" data_tokenkey="{FIRST.tokenkey}" data-checksum="{FIRST.checksum}" data-mod="{MOD}" data-groupid="{GROUP.bid}">{LANG.payment}</button>
        <button class="btn btn-danger" data-dismiss="modal">{LANG.cancel}</button>
    </div>
</div>
<script>
    var LANG = {};
    LANG['payment_confirm'] = '{LANG.payment_confirm}';
    LANG['url_item'] = '{URL_ITEM}';
</script>
<!-- END: main -->