<div class="container" style="max-width: 1000px; overflow: visible;">
<form id="conferenceCreationForm" name="conferenceCreationForm" action="${ postURL }" method="POST">
    <input type="hidden" name="event_type" value="${ event_type }">

    <em>${ _("Please follow the steps to create a conference")}</em>

    <div class="groupTitle">${ _("Step 1: Choose a category")}</div>

    <div style="padding: 10px">
        <input type="hidden" value="${ categ['id'] }" name="categId" id="createCategId"/>
        <span class="selectedCategoryName">${ _("The event will be created in:")} <span id="categTitle" class="categTitleChosen">${ categ['title'] }</span></span><input ${'style="display: none;"' if nocategs else ""} id="buttonCategChooser" type="button" value="${ _("Browse...")}" onclick="openCategoryChooser()"/>
    </div>

    <div class="groupTitle">${ _("Step 2: Enter basic information about the conference") }</div>

    <table class="groupTable">
        <tr>
            <td nowrap class="titleCellTD"><span class="titleCellFormat"> ${ _("Title")}</span></td>
            <td nowrap class="contentCellTD">
                <input type="text" name="title" size="80" value="${ title }">
            </td>
        </tr>
        <tr>
            <td nowrap class="titleCellTD"><span class="titleCellFormat"> ${ _("Start date")}</span></td>
            <td nowrap class="contentCellTD">
                <span id="sDatePlace"></span>
                <input type="hidden" id="sDay" name="sDay" value="${ sDay }">
                <input type="hidden" id="sMonth"  name="sMonth" value="${ sMonth }">
                <input type="hidden" id="sYear" name="sYear" value="${ sYear }">
                <input type="hidden" id="sHour" name="sHour" value="${ sHour }">
                <input type="hidden" id="sMinute" name="sMinute" value="${ sMinute }">
            </td>
        </tr>
        <tr>
            <td nowrap class="titleCellTD"><span class="titleCellFormat"> ${ _("End date")}</span></td>
            <td nowrap class="contentCellTD">
                <span id="eDatePlace"></span>
                <input type="hidden" id="eDay" name="eDay" value="${ eDay }">
                <input type="hidden" id="eMonth"  name="eMonth" value="${ eMonth }">
                <input type="hidden" id="eYear" name="eYear" value="${ eYear }">
                <input type="hidden" id="eHour" name="eHour" value="${ eHour }">
                <input type="hidden" id="eMinute" name="eMinute" value="${ eMinute }">
                <span><a href="#" onclick="new ShowConcurrentEvents(createDatesDict()).execute()">${ _("Show existing events during these dates")}</a></span>
            </td>
        </tr>
        <!-- Fermi timezone awareness -->
        <tr>
            <td nowrap class="titleCellTD"><span class="titleCellFormat">${ _("Timezone")}</span></td>
            <td nowrap class="contentCellTD">
                <select id="Timezone" name="Timezone">${ timezoneOptions }</select>
            </td>
        </tr>
        <!-- Fermi timezone awareness(end) -->
        <%include file="EventLocationInfo.tpl" args="modifying=False, showParent=False, conf=False"/>
        <tr>
            <td>&nbsp;</td>
            <td class="contentCellTD" style="font-style: italic; padding-top: 10px;"><span id="advancedOptionsText" class="fakeLink">&nbsp;</span></td>
        </tr>

        <tr id="advancedOptions" style="display:none"><td colspan="2">

            <table class="groupTable">
                <tr>
                    <td nowrap class="titleCellTD">
                        <span class="titleCellFormat"> ${ _("Description")}</span>
                        <input type="hidden" id="description" name="description" value="">
                    </td>
                    <td nowrap  id="descriptionBox" class="contentCellTD">
                    </td>
                </tr>
                <tr>
                    <td nowrap class="titleCellTD"><span class="titleCellFormat"> ${ _("Additional info")}</span></td>
                    <td nowrap class="contentCellTD">
                        <textarea name="contactInfo" cols="80" rows="6" wrap="soft">${ contactInfo }</textarea>
                    </td>
                </tr>
                <tr>
                    <td nowrap class="titleCellTD"><span class="titleCellFormat"> ${ _("Support email")}</span></td>
                    <td class="contentCellTD">
                <input type="text" name="supportEmail" value="${ supportEmail }" size="33">
                </td>
                </tr>
                <tr>
                    <td nowrap class="titleCellTD"><span class="titleCellFormat">${ _("Default layout style")}</span></td>
                    <td  class="contentCellTD">
                        <select name="defaultStyle">${ styleOptions }</select>
                    </td>
                </tr>
                <tr>
                    <td nowrap class="titleCellTD">
                        <span class="titleCellFormat">${ _("Chairperson") }</span>
                    </td>
                    <%include file="EventParticipantAddition.tpl"/>
                </tr>
                <tr>
                    <td nowrap class="titleCellTD">
                        <span class="titleCellFormat">${ _("Additional Roles") }</span>
                    </td>
                    <td class="contentCellTD">
                    <input type="hidden" name="roles" id="roles" value="" />   
                    <div id="rolesContainer"></div>
                    </td>
                </tr>                
                <tr>
                    <td nowrap class="titleCellTD"><span class="titleCellFormat"> ${ _("Keywords")}</span></td>
                    <td nowrap class="contentCellTD">

                        <select name="menu">
                            <option value="#">Choose keyword...</option>
                                % for kw in availableKeywords:
                                    <option value="${ kw }">${ kw }</option>
                                % endfor
                            </select>
                            <input class="addKeywordButton" value="Add" type="button" onclick="addKeyword()">
                            <br/>

                        <div id="keywordsToAdd" style="border:1px solid #B0B0B0;padding: 10px; margin: 10px 10px 10px 0;"></div>


                        <textarea id="keywords" name="keywords" style="display:none;"></textarea>


                    </td>
                </tr>
            </table>
        </td>
        </tr>
    </table>



    <%include file="EventSetProtection.tpl" args="eventType='conference'"/>

    <table class="groupTable" style="background-color: #ECECEC; border-top: 1px dashed #777777;">
        <tr>
            <td width="15%" nowrap>&nbsp;</td>
            <td nowrap  style="padding: 10px 0;">
                <input style="font-weight: bold;" type="submit" name="ok" value="${ _("Create conference")}">
            </td>
        </tr>
    </table>
</form>





</div>
<%include file="EventCreationJS.tpl"/>

<script type="text/javascript">

    // ICTP: Keywords management

    function createRadioElement(name) {
        var node = document.createElement('div');
        node.id = "KEY"+name
        node.innerHTML = '<input type="checkbox" onclick="removeKeyword(\''+name+'\')" class="addedKeyword" checked="checked"><label>'+ name +'</label>';    
        return node;
    }

    function addKeyword() {
        var sel_val = document.conferenceCreationForm.menu.options[document.conferenceCreationForm.menu.selectedIndex].value;
        var txt_val = document.conferenceCreationForm.keywords.value;
        var k = document.getElementById('keywordsToAdd');
        if (sel_val != '#') {
            if (txt_val.indexOf(sel_val) == -1) {
                var r = createRadioElement(sel_val);
                k.appendChild(r);
                document.conferenceCreationForm.keywords.value+=sel_val+"\n";
            }
        }
    }

    function removeKeyword(name) {
        var element = document.getElementById("KEY"+name);
        element.parentNode.removeChild(element);
        // remove also from textarea
        var txt_val = document.conferenceCreationForm.keywords.value;
        document.conferenceCreationForm.keywords.value = txt_val.replace(name+"\n","")
    }







    //---- chairperson management

    var uf = new UserListField('VeryShortPeopleListDiv', 'PeopleList',
            null, true, null,
            true, false, false, {"grant-manager": [${ jsonEncode(_("event modification"))}, false], "presenter-grant-submission": [$T("submission rights"), false]},
            true, false, true,
            userListNothing, userListNothing, userListNothing);

    $E('chairpersonsContainer').set(uf.draw());
    


    // ----- show concurrent events
    function createDatesDict() {
        if (verifyDates()) {

            var res = {};

            res["sDate"] = Util.formatDateTime(dates.item(0).get(), IndicoDateTimeFormats.Server, IndicoDateTimeFormats.Default);
            res["eDate"] = Util.formatDateTime(dates.item(1).get(), IndicoDateTimeFormats.Server, IndicoDateTimeFormats.Default);
            res["timezone"] = $E('Timezone').get();

            return res;
        }else{
            var popup = new ErrorPopup("Invalid dates", ["Dates have an invalid format: dd/mm/yyyy hh:mm"], "");
            popup.open();
            return null;
        }

    }

    // ----- Categ Chooser
    var categoryChooserHandler = function(categ, protection){
        $E("createCategId").set(categ.id);
        $E("categTitle").set(categ.title);
        $E("buttonCategChooser").set("Change...")
        IndicoUI.Effect.highLightBackground($E("categTitle"));

        updateProtectionChooser(categ.title, protection);
    };

    var openCategoryChooser = function() {
        var categoryChooserPopup = new CategoryChooser(${ categ | n,j}, categoryChooserHandler, true);
        categoryChooserPopup.open();
    }


    // ---- On Load
    IndicoUI.executeOnLoad(function()
    {
        showAdvancedOptions();

        if ("${categ["id"]}" != ""){
            $E("buttonCategChooser").set("${ _("Change...")}");
        }

        protectionChooserExecOnLoad("${categ["id"]}", "${protection}");

        var startDate = IndicoUI.Widgets.Generic.dateField(true,null,['sDay', 'sMonth', 'sYear','sHour', 'sMinute'])
        $E('sDatePlace').set(startDate);

        var endDate = IndicoUI.Widgets.Generic.dateField(true,null,['eDay', 'eMonth', 'eYear', 'eHour', 'eMinute'])
        $E('eDatePlace').set(endDate);

        % if sDay != '':
            startDate.set('${ sDay }/${ sMonth }/${ sYear } ${ sHour }:${ sMinute }');
        % endif

        % if eDay != '':
            endDate.set('${ eDay }/${ eMonth }/${ eYear } ${ eHour }:${ eMinute }');
        % endif

        dates.append(startDate);
        dates.append(endDate);

        injectValuesInForm($E('conferenceCreationForm'), function() {
                if (!verifyDates()) {
                    var popup = new ErrorPopup("Invalid dates", [$T('Dates have an invalid format: dd/mm/yyyy hh:mm')], "");
                    popup.open();
                    return false
                }
                if ($E("createCategId").get() == "") {
                    var popup = new ErrorPopup($T('Missing mandatory data'), [$T('Please, choose a category (step 1)')], "");
                    popup.open();
                    return false;
                }
                if( editor.clean()){
                    $E('chairperson').set(Json.write(uf.getUsers()));
                    $E('description').set(editor.get());
                    injectFromProtectionChooser();
                }
                else
                    return false;
        });

                var editor = new ParsedRichTextWidget(500, 200,"", "rich", "IndicoMinimal");
        $E('descriptionBox').set(editor.draw());
    });
    

    //---- fieldgrouping management
    var fg = $("#rolesContainer").fieldgrouping();
    
    // Default roles: non editable
    var rolesDefault = [];
    var raw = ${rolesData};
    for (var i=0;i<raw.length;i++) {
        raw[i].editable = false;
        rolesDefault.push(raw[i]);
    }    
    fg.fieldgrouping("setInfo", rolesDefault);    

    // ---- save roles values when submitting
    $("#conferenceCreationForm").submit(function() {
        // fix id numbers and remove new empty children
        //var raw = fg.fieldgrouping("getInfo");
        var raw = fg.fieldgrouping("getManagedInfo");
        $("input[name=roles]").val(raw);
    }); 






</script>