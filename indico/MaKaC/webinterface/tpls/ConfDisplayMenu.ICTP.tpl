


% if menu:
  <!--Left menu-->
  <div class="conf_leftMenu">
  

  





<div class="search_box type1_box">
    <h3>Search</h3>
    <div class="type1_box_content">
        <div>Search in Conferences:</div>
    
        <form method="get" action="/search" id="searchBoxForm" >
            <div id="UISearchLeftBox">
                <div id="searchControls">
                    <input name="p" id="searchText" autocomplete="off" type="text" style="outline: none; background-color: transparent;">
                    <div class="searchButton"></div>

            </div>

            </div>
        </form>
    </div>
</div>









  
    <ul id="outer" class="clearfix">
      % for link in menu.getEnabledLinkList():
        % if link.isVisible():

          % if link.getType() == "spacer":
            <li class="spacer"></li>
          % else:
            <li id="menuLink_${link.getName()}"
              % if menu.isCurrentItem(link):
                class="menuConfTitle selected menuConfSelected"
              % else:
                class="menuConfTitle"
              % endif
            >
              <a href="${link.getURL()}"
                 % if link.getType() == "extern":
                   target="${link.getDisplayTarget()}"
                 % endif
              >${link.getCaption()}</a>

            <ul class="inner">
            % for sublink in link.getEnabledLinkList():
                % if sublink.isVisible():
              <li id="menuLink_${sublink.getName()}"
                   % if menu.isCurrentItem(sublink):
                     class="sublink selected menuConfSelected menuConfMiddleCell"
                   % else:
                     class="menuConfMiddleCell"
                   % endif
              >
                <a href="${sublink.getURL()}"
                   % if sublink.getType() == 'external':
                     target="${sublink.getDisplayTarget()}"
                   % endif
               >${_(sublink.getCaption())}</a>
              </li>
                 % endif
            % endfor
            </ul>
          </li>
          % endif
        % endif
      % endfor
    </ul>
    
    
    % if poster:
        <ul class="poster_box">
            <li>
                <a href="${poster['folderurl']}">
                    <img src="data:image/jpg;base64,${poster['data']}" title="poster" alt="poster" />
                </a>
            </li>
        </ul>
    % endif     
    
    
    
    
    % if materials:
    <ul class="support_box">
    <h3>${_("Material")}</h3>
    <li>
        <div class="materialList clearfix">
        % for material in materials:
            <%include file="events/include/Material.tpl" args="material=material"/>
        % endfor
        </div>

    </li>
    </ul>
    % endif
    
    
    
    
    % if not support_info.isEmpty():
    <div class="type1_box">
      <h3>${support_info.getCaption()}</h3>

          <div class="type1_box_content">
            <ul>
            % for email in support_info.getEmail().split(','):
              <li>
                <span class="icon icon-mail" aria-hidden="true"></span>
                <a href="mailto:${email}?subject=${event.getTitle() | h}"> ${email}</a>
              </li>
            % endfor

            % if support_info.hasTelephone():
                % for tel in support_info.getTelephone().split(','):
                  <li>
                    <span class="icon icon-phone" aria-hidden="true"></span>
                    <a href="tel:${tel}"> ${tel}</a>
                  </li>
                % endfor
            % endif
        
            </ul>
          </div>

    </div>
    % endif
    
    
    % if photo:
        <ul class="poster_box">
            <li>
                <a href="${photo['folderurl']}">
                    <img src="data:image/jpg;base64,${photo['data']}" title="photo" alt="photo" />
                </a>
            </li>
        </ul>
    % endif      
    
    
    
  </div>
% endif
