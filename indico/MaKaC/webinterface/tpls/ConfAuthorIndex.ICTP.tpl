<%inherit file="ConfDisplayBodyBase.tpl"/>

<%block name="title">
    ${body_title}
</%block>

<%block name="content">
    <div class="authorIndexFiltersContainer">
        <div>
            <input type="text" id="filter_text" value="" placeholder="${ _('Search in authors') }">
        </div>
        <div class="authorIndexFilteredText">
            ${_("Displaying ")}
            <span style="font-weight:bold;" id="numberFiltered">${len(items)}</span>
            <span id="numberFilteredText">${ _("author") if len(items) == 1 else _("authors")}</span>
            ${_("out of")}
            <span style="font-weight:bold;">${len(items)}</span>
        </div>
    </div>
    <div class="authorIndex index">
        % for key, item in items.iteritems():
            <div class="authorIndexItem item">
                <div style="padding-bottom: 10px">
                    <a class="authorIndexItemText text" href="${item['authorURL']}">
                        ${item['fullName']}
                    </a>
                    % if item['affiliation']:
                        <span style="color: #888">(${item['affiliation']})</span>
                    % endif
                </div>
                % for i, contrib in enumerate(item['contributions']):
                    <div class="contribItem">
                        <a href="${contrib['url']}">${contrib['title']}</a>

                        % if contrib['materials']:

                           
                            <ul class="" style="text-align:right;">
                              % for material in contrib['materials']:
                                <li class="section" >    
        
                                      <!--<h3 class="name">${material['title']}</h3>-->
                                      <ul class="">
                                        % for resource in material['resources']:
                                          <li style="padding-top: 10px;">
                                            <a class="material" href="${resource['url']}">
                                                <img class="material_icon" title="${_('materials')}" src="${Config.getInstance().getImagesBaseURL()}/material_folder.png" width=12 height=12/>
                                                ${resource['name'] if resource['name'] else resource['url']}
                                            </a>
                                          </li>
                                        % endfor
                                      </ul>
        
                                </li>
                              % endfor
                            </ul>
            
            
            
                        % endif
                        
                        
                    </div>
                % endfor
            </div>
        % endfor
    </div>
</%block>
