{* DO NOT EDIT THIS FILE! Use an override template instead. *}
<form name="currencylist" action={'shop/currencylist'|ezurl} method="post">

<div class="context-block">
{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

<h1 class="context-title">{'Available currencies'|i18n( 'design/admin/shop/currencylist' )}</h1>

{* DESIGN: Mainline *}<div class="header-mainline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{section show=$currency_list}
{* DESIGN: Content START *}<div class="box-ml"><div class="box-mr"><div class="box-content">

{* Items per page selector. *}
<div class="context-toolbar">
<div class="block">
<div class="left">
    <p>
    {switch match=$limit}
        {case match=25}
        <a href={'/user/preferences/set/currencies_list_limit/1'|ezurl} title="{'Show 10 items per page.'|i18n( 'design/admin/shop/currencylist' )}">10</a>
        <span class="current">25</span>
        <a href={'/user/preferences/set/currencies_list_limit/3'|ezurl} title="{'Show 50 items per page.'|i18n( 'design/admin/shop/currencylist' )}">50</a>
        {/case}

        {case match=50}
        <a href={'/user/preferences/set/currencies_list_limit/1'|ezurl} title="{'Show 10 items per page.'|i18n( 'design/admin/shop/currencylist' )}">10</a>
        <a href={'/user/preferences/set/currencies_list_limit/2'|ezurl} title="{'Show 25 items per page.'|i18n( 'design/admin/shop/currencylist' )}">25</a>
        <span class="current">50</span>
        {/case}

        {case}
        <span class="current">10</span>
        <a href={'/user/preferences/set/currencies_list_limit/2'|ezurl} title="{'Show 25 items per page.'|i18n( 'design/admin/shop/currencylist' )}">25</a>
        <a href={'/user/preferences/set/currencies_list_limit/3'|ezurl} title="{'Show 50 items per page.'|i18n( 'design/admin/shop/currencylist' )}">50</a>
        {/case}

        {/switch}
    </p>
</div>
<div class="break"></div>
</div>
</div>

<table class="list" cellspacing="0">
<tr>
    <th class="tight"><img src={'toggle-button-16x16.gif'|ezimage} alt="{'Invert selection.'|i18n( 'design/admin/shop/currencylist' )}" title="{'Invert selection.'|i18n( 'design/admin/shop/currencylist' )}" onclick="ezjs_toggleCheckboxes( document.currencylist, 'DeleteCurrencyList[]' ); return false;" /></th>
    <th class="tight">&nbsp;</th>
	<th class="name">{'Name'|i18n( 'design/admin/shop/currencylist' )}</th>
    <th class="class">{'Code'|i18n( 'design/admin/shop/currencylist' )}</th>
    <th class="class">{'Symbol'|i18n( 'design/admin/shop/currencylist' )}</th>
    <th class="class">{'Status'|i18n( 'design/admin/shop/currencylist' )}</th>
    <th class="tight">{'Auto rate'|i18n( 'design/admin/shop/currencylist' )}</th>
    <th class="tight">{'Custom rate'|i18n( 'design/admin/shop/currencylist' )}</th>
    <th class="tight">{'Factor'|i18n( 'design/admin/shop/currencylist' )}</th>
    <th class="tight">{'Rate'|i18n( 'design/admin/shop/currencylist' )}</th>
</tr>

{def $custom_rate = ''
     $auto_rate = ''
     $rate = ''
     $factor = ''}

{if is_set( $currency_names )|not}
    {def $currency_names = hash()}
{/if}
{include uri='design:shop/currencynames.tpl'}

{foreach $currency_list as $currency sequence array( bglight, bgdark ) as $bg_class_style}
    {if is_set( $currency_rates[$currency.code] )}
        {set custom_rate = $currency_rates[$currency.code].custom_value
             auto_rate = $currency_rates[$currency.code].auto_value
             factor = $currency_rates[$currency.code].factor
             rate = $currency_rates[$currency.code].rate_value}
    {else}
        {set custom_rate = 'N/A'|i18n( 'design/admin/shop/currencylist' )
             auto_rate = 'N/A'|i18n( 'design/admin/shop/currencylist' )
             factor = 'N/A'|i18n( 'design/admin/shop/currencylist' )
             rate = 'N/A'|i18n( 'design/admin/shop/currencylist' )}
    {/if}

    {if eq( $currency.status, 2 ) }
        {set $bg_class_style = "object-cannot-remove"}
    {/if}

    <tr class="{$bg_class_style}">
        <td><input type="checkbox" name="DeleteCurrencyList[]" value="{$currency.code}" title="{'Use these checkboxes to select items for removal. Click the "Remove selected" button to actually remove the selected items.'|i18n( 'design/admin/shop/currencylist' )|wash()}" /></td>
        <td><a href={concat( 'shop/editcurrency/(currency)/', $currency.code)|ezurl}><img src={'edit.gif'|ezimage} alt="{'Edit'|i18n( 'design/admin/shop/currencylist' )}" title="{"Edit '%currency_code' currency."|i18n( 'design/admin/shop/currencylist',, hash( '%currency_code', $currency.code ) )|wash}" /></a>
        </td>
        <td>
            {if is_set( $currency_names[$currency.code] )}
    	        {$currency_names[$currency.code]}
            {else}
                {'Unknown currency name'|i18n( 'design/admin/shop/currencylist' )}
            {/if}
        </td>
        <td>{$currency.code}</td>
        <td>{$currency.symbol}</td>
        <td><select name="CurrencyList[{$currency.code}][status]" title="{'Select status'|i18n( 'design/admin/shop/currencylist' )}">
                <option value="active" {if eq($currency.status, 1)}selected = "selected"{/if} >Active</option>
                <option value="inactive" {if eq($currency.status, 2)}selected = "selected"{/if}>Inactive</option>
            </select>
        </td>
        <td class="number">{$auto_rate}</td>
        <td class="number"><input type="text" size="10" name="RateList[{$currency.code}][custom_value]" value="{$custom_rate}" /></td>
        <td class="number"><input type="text" size="10" name="RateList[{$currency.code}][factor]" value="{$factor}" /></td>
        <td class="number">{$rate}</td>
    	
    </tr>

{/foreach}
</table>

<div class="context-toolbar">
{include name=navigator
         uri='design:navigator/google.tpl'
         page_uri='/shop/currencylist'
         item_count=$currency_list_count
         view_parameters=$view_parameters
         item_limit=$limit}
</div>

{* DESIGN: Content END *}</div></div></div>

{* Button bar for remove and add currency. *}
<div class="controlbar">

{* DESIGN: Control bar START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">

<div class="block">
    <div class="left">
        {* Remove button *}
        <input class="button" type="submit" name="RemoveCurrencyButton" value="{'Remove selected'|i18n( 'design/admin/shop/currencylist' )}" title="{'Remove selected currencies from the list above.'|i18n( 'design/admin/shop/currencylist' )}" />
        {* Add button *}
        <input class="button" type="submit" name="AddCurrencyButton" value="{'Add new'|i18n( 'design/admin/shop/currencylist' )}" title="{'Add new currnecy to the list above.'|i18n( 'design/admin/shop/currencylist' )}" />
    </div>
    <div class="right">
        {* Update status button *}
        <input class="button" type="submit" name="UpdateStatusButton" value="{'Update status'|i18n( 'design/admin/shop/currencylist' )}" title="{'Update status.'|i18n( 'design/admin/shop/currencylist' )}" />
        {* Set currency rate button *}
        <input class="button" type="submit" name="SetRatesButton" value="{'Set rates'|i18n( 'design/admin/shop/currencylist' )}" title="{'Set rates.'|i18n( 'design/admin/shop/currencylist' )}" />
    </div>
    <div class="break"></div>
</div>
{* DESIGN: Control bar END *}</div></div></div></div></div></div>

</div>

{section-else}
{* DESIGN: Content START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-bl"><div class="box-br"><div class="box-content">

<div class="block">
<p>{'The available currency list is empty'|i18n( 'design/admin/shop/currencylist' )}</p>
</div>
{* DESIGN: Content END *}</div></div></div></div></div></div>
{/section}

</div>

<input type="hidden" name="Offset" value="{$view_parameters.offset}" />

</form>
