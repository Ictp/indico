<%inherit file="ConfDisplayBodyBase.tpl"/>

<%block name="title">
    ${body_title}
</%block>

<%block name="content">
    <%include file="ConfContributionListFilters.tpl"/>
    <div id="contributionList">
        % for contrib in contributions:
            <% poster = True if contrib.getSession() and contrib.getSession().getScheduleType() == "poster" else False %>

                <%include file="ConfContributionListContribMin.ICTP.tpl" args="contrib=contrib, poster=poster"/>
        % endfor
    </div>
</%block>
