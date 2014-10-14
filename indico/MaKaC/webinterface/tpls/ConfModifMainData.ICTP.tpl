<table class="groupTable">
<%include file="EventModifMainData.ICTP.tpl" args="evtType='conference', confObj=self_._conf"/>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Screen dates")}</span></td>
        <td class="blacktext">${screenDates}</td>
        <td align="right" valign="bottom">
        <form action="${screenDatesURL}" method="POST">
            <input type="submit" class="btn" value="${ _("modify")}">
        </form>
        </td>
    </tr>
    <tr>
        <td colspan="3" class="horizontalLine">&nbsp;</td>
    </tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Types of contributions")}</span></td>
        <td bgcolor="white" colspan="2" class="blacktext">
            <form action="${removeTypeURL}" method="post">
                <table width="100%">
                    <tr>
                        <td width="100%">
                            ${typeList}
                        </td>
                        <td valign="bottom" align="right">
                            <input type="submit" class="btn" name="action" value="${ _("remove")}">
                            </form>
                            <form action="${addTypeURL}" method="post">
                            <input type="submit" class="btn" value="${ _("add")}">
                               </form>
                        </td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>
    <tr>
        <td colspan="3" class="horizontalLine">&nbsp;</td>
    </tr>
    
<tr>
    <td colspan="3">
        <div class="sis">* - This field's value could be OVERWRITTEN by SIS data</div>
        <div class="sis">** - This field is displayed in main ICTP website and part of the content is from SIS: BE CAREFUL</div>
    </td>
</tr>
    
    
</table>

<script type="text/javascript">
function removeItem(number, form)
{
    form.selChair.value = number;
    form.submit();
}
</script>
