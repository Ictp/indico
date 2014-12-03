/*
* -*- mode: text; coding: utf-8; -*-


   This file is part of Indico.
   Copyright (C) 2002 - 2013 European Organization for Nuclear Research (CERN).

   Indico is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public License as
   published by the Free Software Foundation; either version 3 of the
   License, or (at your option) any later version.

   Indico is distributed in the hope that it will be useful, but
   WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with Indico; if not, see <http://www.gnu.org/licenses/>.
*/

var avatars = {};

(function($) {
    $.widget("ui.fieldgrouping", {

        options: {
            fields_caption: "Add new role",
            parameter_manager: undefined,
            parameter_type: "text",
            ui_sortable: false
        },

        _create: function() {
            avatars = {};
            this.info = [];
            this.element.addClass("field-grouping");
            this._createList();
            this._handleEvents();
            this._drawList();
        },

        destroy: function() {
            this.element.off("focusout click keyup propertychange paste");
            this.element.removeClass("field-grouping");
            this.list.remove();
        },

        _createList: function() {
            var self = this;
            self.list = $("<ul></ul>");
            self.element.append(self.list);
            if (self.options["ui_sortable"]) {
                self.list.sortable({
                    axis: "y",
                    containment: "parent",
                    cursor: "move",
                    distance: 10,
                    handle: ".handle",
                    items: "li:not(:last-child)",
                    tolerance: "pointer",
                    start: function(e, ui) {
                        self.start_index = ui.item.index();
                        ui.item.find("input").blur();
                    },
                    update: function(e, ui) {
                        _.move(self.info, self.start_index, ui.item.index());
                    }
                });
            }
            
            
        },

        _handleEvents: function() {
            var self = this;

            self.element.on("focusout", "input.fieldgrouping-caption", function(e) {
                self._updateField(this);
                self._drawNewItem();
            });
             
            self.element.on("click", "a.i-fieldgrouping-button-remove", function(e) {
                e.preventDefault();
                self._deleteItem($(this).closest("li"));
            });

            self.element.on("keyup propertychange paste", "input.fieldgrouping-caption", function(e) {
                // Enter
                if (e.type == "keyup" && e.which == 13) {
                    $(this).blur();                    
                    $(this).parent().next().find("input.fieldgrouping-caption").focus();
                }

                if ($(this).val() === "") {
                    self._deleteNewItem($(this).closest("li"));
                }
                 //lert("DNI di keyup input.fieldgrouping");
                self._drawNewItem();
            });

            self.element.on("keydown", "input.fieldgrouping-caption", function(e) {
                // ESC
                if (e.which == 27) {
                    e.stopPropagation();
                    value = self._getField($(this).data("id"))["value"];
                    $(this).val(value);
                    $(this).blur();
                    $(this).trigger("propertychange");
                }
            });
        },

        _drawList: function() {
            this._reinitList();
            for (var i=0; i < this.info.length; ++i) {
                this.list.append(this._item(this.info[i]));
            }
            this._drawNewItem();
        },

        _reinitList: function() {
            this.next_id = -1;
            this.new_item = undefined;
            this.list.find("li").each(function() {
                $(this).remove();
            });
        },

        _drawNewItem: function() {
            if (this.new_item === undefined || this.new_item.find("input").val() !== "") {                
                this.new_item = this._item(this._addNewFieldInfo());
                this.list.append(this.new_item);
                this.element.scrollTop(this.element[0].scrollHeight);
                this._scrollFix();
            }
        },

        _deleteNewItem: function(item) {
            if (item.next()[0] == this.new_item[0]) {
                this._deleteNewFieldInfo();
                this.new_item.remove();
                this.new_item = item;
                this._removeFieldFromPM(item.find("input"));
                this._scrollFix();
            }
        },

        _deleteItem: function(item) {
            if (item[0] != this.new_item[0]) {
                var id = item.find("input").data("id");
                var index = this._getFieldIndex(id);
                this.info.splice(index, 1);
                this._removeFieldFromPM(item.find("input"));
                item.remove();
                this._scrollFix();
            }
        },

        _addNewFieldInfo: function() {
            var id = this._nextId();
            var field = {"id": id, "value": "", "editable": true, "child": [] };
            this.info.push(field);
            return field;
        },

        _deleteNewFieldInfo: function() {
            this._prevId();
            this.info.pop();
        },

        _getField: function(id) {
            for (var i=0; i<this.info.length; ++i) {
                if (this.info[i]["id"] == id) {
                    return this.info[i];
                }
            }
            return undefined;
        },

        _getFieldIndex: function(id) {
            for (var i=0; i<this.info.length; ++i) {
                if (this.info[i]["id"] == id) {
                    return i;
                }
            }
            return undefined;
        },

        _addFieldToPM: function(input) {
            if (this.options["parameter_manager"] !== undefined) {
                var parameter_type = this.options["parameter_type"];
                this.options["parameter_manager"].remove(input);
                this.options["parameter_manager"].add(input, parameter_type, false);
            }
        },

        _removeFieldFromPM: function(input) {
            if (this.options["parameter_manager"] !== undefined) {
                this.options["parameter_manager"].remove(input);
            }
        },

        _item: function(field) {
            field = field || this._addNewFieldInfo();

            var self = this;
            var id = field["id"];
            var value = field["value"];
            var child = field["child"];
            if (child == '') { child = null; }
            else { 
                child = eval(child); 
                this._getField(id)["child"] = child;                
            }         
            
            var editable = field["editable"];
            var disabled = !editable ? "DISABLED " : "";
            var classe = editable ? "fieldgrouping-caption" : "fieldgrouping-caption noEdit";
            var placeholder = this.options["fields_caption"];
                        
            var item = $("<li></li>");

            if (this.options["ui_sortable"]) { item.append($("<span class='handle'></span>")); }                        
            item.append($("<input "+disabled+"type='text' class='"+classe+"' data-id='"+ id +"' placeholder='"+ placeholder+"' value='"+ value +"'/>").placeholder());
            if (editable) { item.append($("<a class='i-fieldgrouping-button-remove' title='"+ $T("Delete") +"' href='#' tabIndex='-1'><i class='icon-remove'></i></a>")); } 

            item.append($("<div id='avatarContainer"+id+"' class='avatarContainer'></div>"));
            var av = new UserListField('VeryShortPeopleListDiv', 'PeopleList', child, true, null, true, false, false, {},
                    true, false, true, false, userListNothing, userListNothing, userListNothing);

            avatars[id] = av;
                    
            var avaContainer = item.find("div.avatarContainer").get(0);                        
            $E(avaContainer).set(av.draw());
            
            item.find("a.i-fieldgrouping-button-remove").qtip({
                position: {
                    at: "top center",
                    my: "bottom center",
                    target: item.find("a")
                },
                hide: {
                    event: "mouseleave"
                }
            });

            return item;
        },


        
        _updateField: function(input) {
            input = $(input);
            var item = input.closest("li");
            if (input.val() === "") {                
                this._deleteItem(item);
            } else {
                this._getField(input.data("id"))["value"] = input.val();
                this._addFieldToPM(input);
            }
            
        },        
        
        _updateAvatars: function(obj) {
            jQuery.each(avatars, function(id, ul) {
                obj._getField(id)["child"] = Json.write(ul.getUsers());
            });
        },
        
        _nextId: function() {
            return this.next_id--;
        },

        _prevId: function() {
            return this.next_id === 0? this.next_id : this.next_id++;
        },

        _scrollFix: function() {
            if ((this.element[0].clientHeight+1 < this.element[0].scrollHeight)) {
                this.element.find("input").addClass("width-scrolling");
            } else {
                this.element.find("input").removeClass("width-scrolling");
            }
        },

        _nologo: function(strCode){
           var html = $(strCode.bold()); 
           html.find('logo').remove();
           return html.html();
        },

        getManagedInfo: function() {
            // Return a JSON Info with fixed Ids
            this._updateAvatars(this);
            var raw = this.getInfo();
            var fix = [];
            for (var i=0;i<raw.length;i++) {
                var child = [];
                if (typeof(raw[i].child) == 'object') { var ochild = raw[i].child; }
                else { var ochild = JSON.parse(raw[i].child); }                
                for (var j=0;j<ochild.length;j++) {
                    if (ochild[j].value != "") {
                        ochild[j].id = j;
                        child.push(ochild[j]);
                    }
                }    
                raw[i].id = i;
                raw[i].child = child;
                fix.push(raw[i]);
            }
            return JSON.stringify(fix);
        },
        
        getInfo: function() {
            return this.info.slice().splice(0, this.info.length-1);
        },
        
        getStructuredInfo: function() {
            var html = '<dl id="rolesList">';
            for (var i = 0; i < this.info.length; i++) {
                var child = [];
                
                var echild = eval(this.info[i].child);
                for (var j = 0; j < echild.length; j++) {
                    var val = echild[j].familyName;
                    if ('firstName' in echild[j]) { val = val + " " + echild[j].firstName; }
                    if (str(val) != '') { child.push(val); }
                }
                // ICTP Specific: do not show label if no text except <nologo> tags
                var nologo_content = this._nologo(child.join(""));
                if (child.length > 0 && nologo_content != '') {
                    html += '<dt id="'+this.info[i].value+'">'+this.info[i].value+'</dt>';
                    html += "<dd>";
                    html += child.join(", ");
                    html += "</dd>";                                
                }
            }
            html += "</dl>";
            this.list.remove();
            this.element.append($(html));
            
            return html
        },

        setInfo: function(raw_info) {            
            var info = [];
            for (var i = 0; i < raw_info.length; i++) {
                var info_item = raw_info[i];
                if (!("child" in info_item)) { info_item["child"] = []; }
                if (!("editable" in info_item)) { info_item["editable"] = true; }
                info.push(info_item);
            }
            this.info = info;
            this._drawList();
        }
    });
})(jQuery);
