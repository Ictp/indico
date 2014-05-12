<%page args="contrib=None, slot=False, poster=False"/>
    % if slot:
    <% from MaKaC.schedule import SlotSchedule %>
        <div class="contributionListContribItem" data-id="${contrib.getId()}" data-session="${contrib.getSchEntry().getSchedule().getOwner().getId() if isinstance(contrib.getSchEntry().getSchedule(), SlotSchedule) else '-1'}" data-track="${contrib.getTrack().getId() if contrib.getTrack() else '-1'}" data-type="${contrib.getType().getId() if contrib.getType() else '-1'}">
    % else:
        <div class="contributionListContribItem" data-id="${contrib.getId()}" data-session="${contrib.getSession().getId() if contrib.getSession() else '-1'}" data-track="${contrib.getTrack().getId() if contrib.getTrack() else '-1'}" data-type="${contrib.getType().getId() if contrib.getType() else '-1'}">
    % endif
        <div>
            <a href="${str( urlHandlers.UHContributionDisplay.getURL( contrib ))}" style="font-size:14px">${contrib.getTitle()}</a>
        </div>
        <div class="contributionListContribHeader">
            % if contrib.getType() != None:
                <span style="font-weight:bold">${_("Type")}: </span>${contrib.getType().getName()}
            % endif
            % if contrib.getSession() != None:
                <span style="font-weight:bold">${_("Session")}: </span>
                <a class="lightGreyLink" href="${str(urlHandlers.UHSessionDisplay.getURL( contrib.getSession() ))}">${contrib.getSession().getTitle()}</a>
                <div style="background-color: ${contrib.getSession().getColor()};" class="sessionSquare"></div>
            % endif
            % if contrib.getTrack() != None:
                <span style="font-weight:bold">${_("Track")}: </span>${contrib.getTrack().getTitle()}
            % endif
            % if poster == True and contrib.getBoardNumber() != '':
                <span style="font-weight:bold">${_("Board #")}: </span>
                ${contrib.getBoardNumber()}
            % endif;
            
            % if contrib.getAllMaterialList():
                <ul class="" style="text-align:right;">
                  % for material in contrib.getAllMaterialList():
                    <li class="section" >    
                          <ul class="">
                            % for resource in material.getResourceList():
                              <li style="padding-top: 10px;">
                                <a class="material" href="${str( urlHandlers.UHContributionDisplay.getURL( contrib ))+'/material/'+resource.getLocator()['materialId']+'/'+resource.getLocator()['resId']+'.'+resource.getLocator()['fileExt']}">
                                    <img class="material_icon" title="${_('materials')}" src="${Config.getInstance().getImagesBaseURL()}/material_folder.png" width=12 height=12/>
                                    ${resource.getFileName()}
                                </a>
                              </li>
                            % endfor
                          </ul>
                    </li>
                  % endfor
                </ul>
            % endif

        </div>
        <%block name="description" args="contrib=None">
        </%block>

<%block name="footer" args="contrib=None">
</%block>
</div>
