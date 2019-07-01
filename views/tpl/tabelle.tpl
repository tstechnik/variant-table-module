[{$smarty.block.parent}]
[{block name="varianten_block"}]

    [{assign var="products" value=$oView->getVariantList()}]
    [{assign var="currency" value=$oView->getActCurrency()}]
    [{assign var="attributes" value=$oView->getAttributes()}]
    [{capture assign=pageScript}]
    $(document).ready(function() {
    $('#variantTable').DataTable( {
    "language": {
    "lengthMenu": "Zeige _MENU_ Varianten pro Seite",
    "zeroRecords": "Kein Artikel gefunden",
    "info": "Seite _PAGE_ von _PAGES_",
    "infoEmpty": "Keine Varianten verfügbar",
    "infoFiltered": "(filtered from _MAX_ total records)",
    "paginate": {
    "first":      "Erste",
    "last":       "Letzte",
    "next":       "Nächste",
    "previous":   "Zurück"
    },
    },
    "bSort": false,
    "searching": false,
    initComplete: function () {
    this.api().columns().every( function () {
    var column = this;
    var select = $('<select class="form-control"><option value=""></option></select>')
    .appendTo( $(column.footer()).empty() )
    .on( 'change', function () {
    var val = $.fn.dataTable.util.escapeRegex(
    $(this).val()
    );

    column
    .search( val ? '^'+val+'$' : '', true, false )
    .draw();
    } );

    column.data().unique().sort().each( function ( d, j ) {
    select.append( '<option value="'+d+'">'+d+'</option>' )
    } );
    } );
    }
    } );

    } );
    [{/capture}]
    [{oxscript add=$pageScript}]
    [{oxstyle include=$oViewConf->getModuleUrl('tstechnik/variant-table-module','libs/css/varianttable.css')}]
    [{oxstyle include=$oViewConf->getModuleUrl('tstechnik/variant-table-module','libs/css/datatable.css')}]
    [{if $products|@count gt 0}]
    <div class="h2 page-header">Alle verfügbare Varianten</div>
    <table id="variantTable" class="display" cellspacing="0" width="100%">
        <thead>
        <tr role="row">
            <th>Art.Nr.</th>
            <th>Produktbild</th>
            [{if $attributes}]
            [{foreach from=$oView->getAttributes() item=oAttr name=attribute}]
            <td id="attrTitle_[{$smarty.foreach.attribute.iteration}]">[{$oAttr->title}]</td>
            [{/foreach}]
            [{/if}]
            <th>Preis</th>
            <th align="right">Bestellungen</th>
        </tr>
        </thead>
        <tbody>
        [{foreach from=$products name=variants item=_product}]
            <tr class="productRaw_[{$smarty.foreach.attribute.iteration}]">
                <td><a href="[{$_product->getLink()}]">[{$_product->oxarticles__oxartnum->value}]</a></td>
                <td>
                    <img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$_product->getIconUrl()}]">
                </td>
                [{if $attributes}]
                [{foreach from=$_product->getAttributes() item=oAttr name=attribute}]
                <td id="attrValue_[{$smarty.foreach.attribute.iteration}]">[{$oAttr->oxattribute__oxvalue->value}]</td>
                [{/foreach}]
                [{/if}]
                <td><b>[{$_product->getFPrice()}] [{$currency->sign}]</b></td>
                <td class="variantLastRow">
                    <form name="tobasketproductList_1" id="toBasketForm" action="[{$oViewConf->getSelfActionLink()}]" method="post">
                        <div class="hidden">
                            <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]">
                            <input type="hidden" name="aid" value="[{$_product->oxarticles__oxid->value}]">
                            <input type="hidden" name="anid" value="[{$_product->oxarticles__oxnid->value}]">
                            <input type="hidden" name="parentid" value="[{if !$_product->oxarticles__oxparentid->value}][{$_product->oxarticles__oxid->value}][{else}][{$_product->oxarticles__oxparentid->value}][{/if}]">
                            <input type="hidden" name="panid" value="">
                            [{if !$_product->isNotBuyable()}]
                        <input type="hidden" name="fnc" value="tobasket">
                            [{/if}]
                        </div>
                        <input id="amountToBasket" type="number" class="textbox form-control text-center" name="am" value="1" size="3" min="1" style="width:60px; float:left;"><button type="submit" class="btn btn-default hasTooltip" data-placement="bottom" title="" data-original-title="">
                            <i class="fa fa-shopping-cart"></i>
                        </button>
                    </form>
                </td>
            </tr>
            [{/foreach}]
        </tbody>

    </table>
    [{/if}]
    [{oxscript include="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"}]
    [{oxscript include="https://cdn.datatables.net/rowreorder/1.2.3/js/dataTables.rowReorder.min.js"}]
    [{oxscript include="https://cdn.datatables.net/responsive/2.2.0/js/dataTables.responsive.min.js"}]
    [{/block}]