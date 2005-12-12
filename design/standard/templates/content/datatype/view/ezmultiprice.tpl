{* DO NOT EDIT THIS FILE! Use an override template instead. *}
{def $multiprice = $attribute.content
     $price_list = $multiprice.inc_vat_price_list
     $currency_list = $multiprice.currency_list}

    {*
    {if $multiprice.has_discount}
        {'Price'|i18n( 'design/standard/content/datatype' )}: <strike>{$multiprice.inc_vat_price|l10n( currency )}</strike> <br/>
        {'Your price'|i18n( 'design/standard/content/datatype' )}: {$multiprice.discount_price_inc_vat|l10n( currency )}<br />
        {'You save'|i18n( 'design/standard/content/datatype' )}: {sub($multiprice.inc_vat_price,$multiprice.discount_price_inc_vat)|l10n( currency )} ( {$multiprice.discount_percent} % )
    {else}
        {'Price'|i18n( 'design/standard/content/datatype' )} {$attribute.content.inc_vat_price|l10n( currency )}<br/>
    {/if}
    *}

    {'Price'|i18n( 'design/standard/content/datatype' )}: <br />
    {foreach $price_list as $price}
        {$price.value} {$currency_list[$price.currency_code].symbol}{if eq( $price.type, 2 )}{'(Autoprice)'|i18n( 'design/standard/content/datatype' )}{/if}<br />
    {/foreach}
{undef}