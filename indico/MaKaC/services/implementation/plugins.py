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

from MaKaC.services.implementation.base import AdminService
from MaKaC.services.interface.rpc.common import ServiceError, NoReportError
from MaKaC.plugins import PluginsHolder
from MaKaC.webinterface.user import UserListModificationBase, UserModificationBase
from MaKaC.webinterface.rh.base import RoomBookingDBMixin

# Ictp:
from indico.core.config import Config
import os, logging
from MaKaC.common.contextManager import ContextManager
# file for appending changes
changeLog = "/opt/indico/log/changes.log"
# create LOGGER
logger = logging.getLogger(__name__)
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger.setLevel(logging.DEBUG)
logFilePath = "/opt/indico/log/crons.log"
handler = logging.handlers.RotatingFileHandler(filename = logFilePath, maxBytes=1000000, backupCount = 100)
handler.setFormatter(formatter)
handler.setLevel(logging.DEBUG)
logger.addHandler(handler)





class PluginOptionsBase (AdminService):

    def _checkParams(self):
        optionName = self._params.get('optionName', None)
        if optionName:
            options = optionName.split('.')
            ph = PluginsHolder()
            if len(options) == 3:
                pluginType, plugin, option = options
                if ph.hasPluginType(pluginType):
                    if ph.getPluginType(pluginType).hasPlugin(plugin):
                        self._targetOption = ph.getPluginType(pluginType).getPlugin(plugin).getOption(option)
                    else:
                        raise ServiceError('ERR-PLUG4', 'plugin: ' + str(plugin) + ' does not exist')
                else:
                    raise ServiceError('ERR-PLUG3', 'pluginType: ' + str(pluginType) + ' does not exist, is not visible or not active')
            elif len(options) == 2:
                pluginType, option = options
                if ph.hasPluginType(pluginType):
                    self._targetOption = ph.getPluginType(pluginType).getOption(option)
                else:
                    raise ServiceError('ERR-PLUG3', 'pluginType: ' + str(pluginType) + ' does not exist, is not visible or not active')
            else:
                raise ServiceError('ERR-PLUG1', 'optionName argument does not have the proper pluginType.plugin.option format')
        else:
            raise ServiceError('ERR-PLUG0', 'optionName argument not present')


class PluginOptionsAddUsers ( PluginOptionsBase, UserListModificationBase):

    def _checkParams(self):
        PluginOptionsBase._checkParams(self)
        UserListModificationBase._checkParams(self)

    def _getAnswer(self):
        if self._targetOption.getType() == 'users' or self._targetOption.getType() == 'usersGroups':
            optionValue = self._targetOption.getValue()
            existingUserIds = set([u.getId() for u in optionValue])
            for u in self._avatars:
                if not u.getId() in existingUserIds:
                    optionValue.append(u)
            self._targetOption._notifyModification()
        else:
            raise ServiceError('ERR-PLUG2', "option %s.%s.%s is not of type 'users'" % (self._pluginType, self._plugin, self._targetOption))

        return True

class PluginOptionsRemoveUser ( PluginOptionsBase, UserModificationBase ):

    def _checkParams(self):
        PluginOptionsBase._checkParams(self)
        UserModificationBase._checkParams(self)

    def _getAnswer(self):
        if self._targetOption.getType() == 'users' or self._targetOption.getType() == 'usersGroups':
            self._targetOption.getValue().remove(self._targetUser)
            self._targetOption._notifyModification()
        else:
            raise ServiceError('ERR-PLUG2', "option %s.%s.%s is not of type 'users'" % (self._pluginType, self._plugin, self._targetOption))

        return True

class PluginOptionsAddRooms ( RoomBookingDBMixin, PluginOptionsBase ):

    def _checkParams(self):
        PluginOptionsBase._checkParams(self)

    def _getAnswer(self):
        if self._targetOption.getType() == 'rooms':
            optionValue = self._targetOption.getValue()
            roomToAdd = self._params.get("room")
            if roomToAdd not in optionValue:
                optionValue.append(roomToAdd)
            self._targetOption._notifyModification()
        else:
            raise ServiceError('ERR-PLUG2', "option %s.%s.%s is not of type 'rooms'" % (self._pluginType, self._plugin, self._targetOption))

        return True

class PluginOptionsRemoveRooms ( PluginOptionsBase ):

    def _checkParams(self):
        PluginOptionsBase._checkParams(self)

    def _getAnswer(self):
        if self._targetOption.getType() == 'rooms':
            roomToRemove=self._params.get("room")
            self._targetOption.getValue().remove(roomToRemove)
            self._targetOption._notifyModification()
        else:
            raise ServiceError('ERR-PLUG2', "option %s.%s.%s is not of type 'rooms'" % (self._pluginType, self._plugin, self._targetOption))

        return True

class PluginOptionsAddLink ( PluginOptionsBase ):

    def _checkParams(self):
        PluginOptionsBase._checkParams(self)
        # ICTP: get ALL available parameters
        #self._linkName = self._params.get('name', None)
        #self._linkStructure = self._params.get('structure', None)
        for p in self._params.keys():
        	setattr(self, '_link'+p.capitalize(), self._params.get(p, None))        

    def _getAnswer(self):
        links = self._targetOption.getValue()     
        for link in links:
        	if link['name'] == self._linkName:
        		return {'success': False, 'table': links}

        # ICTP: append ALL available properties
        # links.append({'name': self._linkName, 'structure': self._linkStructure})
        dict = {}
        for p in dir(self):
        	if p.startswith('_link'):
        	    val = p.replace('_link','').lower()
        	    dict[val] = getattr(self,p)
        if dict.has_key('optionname') and dict['optionname'] == 'ictp_addons.sponsor_management.sponsors':
            user = ContextManager.get("currentUser")
            logger.info("Added Sponsor: "+dict['title']+" by "+user.getName()+" ("+user.email+")")
        links.append(dict)

        self._targetOption.setValue(self._targetOption.getValue())
        self._targetOption._notifyModification()
        return {'success': True, 'table': links}
        
        

                
         

     

class PluginOptionsRemoveLink ( PluginOptionsBase ):

    def _checkParams(self):
        PluginOptionsBase._checkParams(self)
        self._linkName = self._params.get('name', None)

    def _getAnswer(self):
        links = self._targetOption.getValue()
        htdocsDir = Config.getInstance().getHtdocsDir()
        logoDir = "/css/ICTP/images/sponsor-logo/"
        for link in links:
            if link['name'] == self._linkName:
                links.remove(link)
                if link.has_key('logo') and link['logo']:
                    # remove logo from FS                   
                    filePath = htdocsDir + logoDir + link['logo'] 
                    try:
                        os.remove(filePath)
                    except OSError:
                        pass
                if link.has_key('optionname') and link['optionname'] == 'ictp_addons.sponsor_management.sponsors':
                    user = ContextManager.get("currentUser")
                    logger.info("Removed Sponsor: "+link['title']+" by "+user.getName()+" ("+user.email+")")
                    
                    
                    
        self._targetOption._notifyModification()
        return {'success': True, 'table': links}


methodMap = {
    "addUsers": PluginOptionsAddUsers,
    "removeUser": PluginOptionsRemoveUser,
    "addRooms": PluginOptionsAddRooms,
    "removeRooms": PluginOptionsRemoveRooms,
    "addLink": PluginOptionsAddLink,
    "removeLink": PluginOptionsRemoveLink
}
