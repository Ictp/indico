<% import MaKaC.webinterface.urlHandlers as urlHandlers %>
<% from MaKaC.conference import Link %>
<% from MaKaC.webinterface.general import strfFileSize %>
<div id="buttonBar" class="materialButtonBar">
% if (material.canModify(accessWrapper) or canSubmitResource):
    <span id="manageMaterial" class="fakeLink" style="font-weight: bold">${_("Edit")}</span>
% endif
</div>

<h1 class="materialTitle">
    ${material.getTitle()}
    <div class="materialDescription">${material.getDescription()}</div>
</h2>
<div>
    <div class="materialMainContent">
        <div class="materialDetail">
            % if material.getResourceList() and material.canView(accessWrapper):
            <div class="materialSection">
                <div>
                <ul class="materialItem">
                % for resource in material.getResourceList():
                    <li>
                    % if isinstance(resource, Link):
                        <img src="${Config.getInstance().getSystemIconURL('link')}" style="vertical-align: middle; border: 0;">
                        <a href="${getURL(resource)}">${resource.getName() if resource.getName() != "" and resource.getName() != resource.getURL() else resource.getURL()}</a>
                        % if resource.getDescription().strip():
                        <ul class="resourceDetail">
                            <li>${resource.getDescription()}</li>
                        </ul>
                        % endif
                        % if resource.isProtected():
                            <img src="${Config.getInstance().getSystemIconURL('protected')}" style="vertical-align: middle; border: 0;">
                        % endif
                    % else:
                        <div>
                        % if resource.getFileType() == 'mp4':
                            <div style="display: inline-block;">
                                <video id="${resource.getFileName()}" class="materialVideo"> 
                                  <source src="${fileAccessURLGen(resource)}" type="video/mp4" />
                                    "Your browser does not support HTML5 video."
                                </video>
                                <br/><a id="resize_${resource.getFileName()}" href="javascript:resizeVideo('${resource.getFileName()}')" style="float:right;">Bigger size</a>
                            </div>    
                        % endif

                            <div class="materialData">
                                <% image = Config.getInstance().getFileTypeIconURL( resource.getFileType()) %>
                                <img src="${image if image else Config.getInstance().getSystemIconURL('smallfile')}" style="vertical-align: middle; border: 0;">
                                <a href="${fileAccessURLGen(resource)}">${resource.getName()}</a>
                                % if resource.isProtected():
                                    <img src="${Config.getInstance().getSystemIconURL('protected')}" style="vertical-align: middle; border: 0;">
                                % endif
                                <ul class="resourceDetail">
                                    <li>${resource.getDescription()}</li>
                                    <li><span style="font-weight: bold">${_("File name")}: </span>${resource.getFileName()}</li>
                                    <li><span style="font-weight: bold">${_("File size")}: </span>${strfFileSize(resource.getSize())}</li>
                                    <li><span style="font-weight: bold">${_("File creation date")}: </span>${resource.getCreationDate().strftime("%d %b %Y %H:%M")}</li>
                                </ul>
                            </div>

                        </div>
                    % endif
                    </li>
                % endfor
                </ul>
                </div>
            </div>
            % endif
        </div>
    </div>
</div>

<script type="text/javascript">
    $("#manageMaterial").click(function(){
        IndicoUI.Dialogs.Material.editor('${material.getConference().getId() if material.getConference() else ""}', '${material.getSession().getId() if material.getSession() else ""}',
                '${material.getContribution().getId() if material.getContribution() else ""}','${material.getSubContribution().getId() if material.getSubContribution() else ""}',
                ${jsonEncode(material.getOwner().getAccessController().isProtected())}, ${jsonEncode(material.getOwner().getMaterialRegistry().getMaterialList(material.getOwner()))}, ${uploadAction}, true);
     });


    $(".materialVideo").mouseenter(function() {
        $('.materialVideo').attr('controls',true);
    }).mouseleave(function(){
       $('.materialVideo').attr('controls',false);
    });

    function resizeVideo(name) {
        v = document.getElementById(name);
        l = document.getElementById('resize_'+name);
        var width = v.offsetWidth;
        if (width == 250) {
            v.style.width = '100%';
            l.innerHTML = "Smaller size";
        } else {
            v.style.width = '250px';
            l.innerHTML = "Bigger size";
        };
            
    };
</script>







