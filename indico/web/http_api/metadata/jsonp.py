# -*- coding: utf-8 -*-
##
##
## This file is part of Indico.
## Copyright (C) 2002 - 2014 European Organization for Nuclear Research (CERN).
##
## Indico is free software; you can redistribute it and/or
## modify it under the terms of the GNU General Public License as
## published by the Free Software Foundation; either version 3 of the
## License, or (at your option) any later version.
##
## Indico is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with Indico;if not, see <http://www.gnu.org/licenses/>.

from indico.web.http_api.metadata.json import JSONSerializer


class JSONPSerializer(JSONSerializer):
    """
    Just adds prefix
    """

    _mime = 'application/javascript'

    def __init__(self, jsonp='read', **kwargs):

        
        for k in kwargs:
            if k.find('jQuery') > -1:
                jsonp = k        

        super(JSONPSerializer, self).__init__(**kwargs)  
        self._prefix = jsonp

    def _execute(self, results):

        # Ictp: workaround cause jsonp parameter does not work       
        if self._obj['url'].find('jsonp=') > -1:
            import urlparse
            parsed = urlparse.urlparse(self._obj['url'])
            self._prefix = urlparse.parse_qs(parsed.query)['jsonp'][0]

        return "%s(%s);" % \
               (self._prefix,
                super(JSONPSerializer, self)._execute(results))
