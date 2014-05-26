<%page args="material, sessionId='', contribId='', subContId=''"/>
<span class="materialGroup">
    <a href="${urlHandlers.UHMaterialDisplay.getURL(material)}" class="material materialGroup" title="${material.description}">
    
    <img class="material_icon" title="${_('materials')}" src="${Config.getInstance().getImagesBaseURL()}/material_folder.png" width=12 height=12/>
    
    
        ${material.type}
        ${material.title.replace('_',' ')}
        % if material.isItselfProtected():
            <img src="${Config.getInstance().getImagesBaseURL()}/protected.png" border="0" alt="locked" style="margin-left: 3px;"/>
        % endif
    </a>
</span>

