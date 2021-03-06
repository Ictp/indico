
<div class="conferencetitlelink blue">
    ${conf.getTitle()}
</div>

<div class="conferenceDetails">

  <div class="grid">
  <div class="info_line date">
      <span  title="${_("Date/Time")}" class="icon icon-time" aria-hidden="true"></span>
      <div class="text">
        
        % if conf.getOwner().getOwner().getId() == '2l133':
            <div class="date_start">${_('Starts <span class="datetime">{0} {1}</span>').format(dateInterval[0], dateInterval[1])}</div>
        % else:
            <div class="date_start">${_('Starts <span class="datetime">{0}</span>').format(dateInterval[0])}</div>
        % endif
        
        % if conf.getOwner().getOwner().getId() == '2l133':
            <div class="date_end">${_('Ends <span class="datetime">{0} {1}</span>').format(dateInterval[2], dateInterval[3])}</div>
        % else:
            <div class="date_end">${_('Ends <span class="datetime">{0}</span>').format(dateInterval[2])}</div>
        % endif
        <div class="timezone">${conf.getTimezone().replace('Europe/Rome','Central European Time')}</div>
      </div>
  </div>

  % if location:
    <div class="info_line location">
        <span title="${_("Location")}" class="icon icon-location" aria-hidden="true"></span>
        <div class="place text">
          ${location}
        </div>
      % if room:
        <div class="room text nohtml">${room}</div>
      % endif
      % if address:
        <div class="address text nohtml">${address}</div>
      % endif
    </div>
  % endif

  </div>


  <div class="grid">
    <div itemprop="description" class="description ${'nohtml' if not description_html else ''}">${description}</div>
  </div>

  <div class="grid">
  % if chairs:
  <div class="info_line chairs clear">
      <span  title="${_("Chairpersons")}" class="icon icon-chair" aria-hidden="true"></span>
      <ul class="chair_list text">
        % for chair in chairs:
        <li>
          % if chair.getEmail():
            % if self_._aw.getUser():
              <a href="mailto:${chair.getEmail()}">${chair.getFullName()}</a>
            % else:
              <a href="#" class="nomail">${chair.getFullName()}</a>
            % endif
          % else:
            ${chair.getFullName()}
          % endif
        </li>
        % endfor
      </ul>
  </div>
  % endif

  % if material or isSubmitter:
  <div class="info_line material">
      <span title="${_("Materials")}" class="icon icon-material-download" aria-hidden="true"></span>
      % if material:
          <ul class="text" style="float: left; padding: 0; max-width: 190px;">
            % for mat in material:
              <li>${mat.replace('_',' ')}</li>
            % endfor
          </ul>
      % else:
          <span class="text" style="float: left; font-style: italic; padding: 10px 0px 0px">${_("No material")}</span>
      % endif

  </div>
  % endif

  % if moreInfo:
  <div class="info_line info">
      <span  title="${_("Extra information")}" class="icon icon-info" aria-hidden="true"></span>
      <div class="text ${'nohtml' if not moreInfo_html else ''}">${ moreInfo }</div>
  </div>
  % endif
  
  

  
  
  % if conf.getRolesVal() != '':
  <div class="info_line roles">   
      <span title="${_("Roles")}" class="icon icon-list" aria-hidden="true"></span>
      <div class="rolesContainer"></div>
  </div>
  % endif  
  
  </div>

</div>

${ actions }


<script type="text/javascript">
                
      var fg = $('div.rolesContainer').fieldgrouping();
      fg.fieldgrouping("setInfo", ${conf.getRolesJS()});
      fg.fieldgrouping("getStructuredInfo");     

        // ICTP specific: move Secretary to last
        var dts = $('#Secretary').nextUntil('dt')
        $('#Secretary').appendTo('#rolesList');
        dts.appendTo('#rolesList');

      $('.chair_list .nomail').qtip({
             content: {
                 text: $T("Login to see email address"),
             },
         });

% if isSubmitter:
    $('.info_line.material').addClass('highlighted-area');
    $('.info_line.material').css('background-color', '#f2f2f2');
    $('.info_line.material').append('<span title="${_("Manage materials")}" class="right i-button icon-edit icon-only" style="float: right" id="manageMaterials" aria-hidden="true" ></span>');


    $("#manageMaterials").click(function(){
      IndicoUI.Dialogs.Material.editor(${conf.getId() |n,j}, '','','',
                                       ${conf.getAccessController().isProtected() |n,j},
                                       ${conf.getMaterialRegistry().getMaterialList(conf) |n,j},
                                       ${'Indico.Urls.UploadAction.conference'}, true);
    });

% endif

</script>
