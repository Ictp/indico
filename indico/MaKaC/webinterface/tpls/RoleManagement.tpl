<%page args="rolesData=None"/>
<form action="${postURL}" method="GET" id="target">
<table width="90%" align="left" border="0">
  <tr>
    <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Roles Creation")}</span></td>
    <td bgcolor="white" class="blacktext">
        <div id="inPlaceEditRoles"></div>
        <input type="hidden" name="roles" value="" />
    </td>


    <tr>
    <td>&nbsp;</td>
    <td><input type="submit" class="btn" value="${ _("save")}"></input></td>
    </tr>

  </tr>
</table>
</form>

<script type="text/javascript">

    var fa = $('#inPlaceEditRoles').fieldarea();
    var rData = ${rolesData};

    % if rData != []:
        fa.fieldarea("setInfo", rData);
    % endif

    $("#target").submit(function( event ) {            
        // fix id numbers and remove new empty children
        var raw = fa.fieldarea("getInfo");
        var fix = [];
        for (var i=0;i<raw.length;i++) {
            raw[i].id = i;
            fix.push(raw[i]);
        }
        $("input[name=roles]").val(JSON.stringify(fix));
    });

    
</script>    
