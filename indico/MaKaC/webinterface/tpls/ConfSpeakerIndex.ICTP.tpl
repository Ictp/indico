<%inherit file="ConfDisplayBodyBase.tpl"/>

<%block name="title">
    ${body_title}
</%block>

<%block name="content">

    <div class="speakerIndex index">
        % for key, item in items.iteritems():        
            <% 
            # Shows only not protected Items
            pItems=[item[0]]
            for j in range(1, len(item)):
                if not(item[j]['isProtected']):
                    pItems.append(item[j])
            %>    
                
            % if len(pItems) > 1:
                <div class="speakerIndexItem item">
                    <div style="padding-bottom: 10px">
                        <span class="speakerIndexItemText text">${item[0]['fullName']}</span>
                        % if item[0]['affiliation']:
                            <span style="color: #888">(${item[0]['affiliation']})</span>
                        % endif
                    </div>
                    
                    % for i in range(1, len(pItems)):
                        <div class="contribItem">
                            <a href="${pItems[i]['url']}">${pItems[i]['title']}</a>
                            % if pItems[i]['materials']:
                                <img class="material_icon" title="${_('materials')}" src="${Config.getInstance().getBaseURL()}/images/material_folder.png" width=12 height=12 style="cursor: pointer;"/>
                                <%include file="MaterialListPopup.tpl" args="materials=pItems[i]['materials']"/>
                            % endif
                        </div>
                    % endfor
                </div>
                
            % endif
            
        % endfor
    </div>
</%block>
