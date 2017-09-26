﻿(function () {
    'use strict';

    angular
        .module('app')
        .factory('utility', utility);


    function utility() {
        var service = {
            clearArray: clearArray,
            clone: cloneObject,
            getQueryString: getParameterByName,
            setQueryString: updateQueryStringParameter,
            checkInValid: checkInValid,
            joinStr: joinStr,
            convertDateFormat: convertDateFormat,
            initTableState: initTableState,
            getFileExt: getFileExt,
            autoCheckAll: autoCheckAll,
            checkAll: checkAll,
            getListPopup: getListPopup
        };

        return service;

        // danh sách popup đang mở (reverse: true = bot to top, false = top to bot )
        function getListPopup(reverse) {
            reverse = reverse || false;

            var list = $('.panel.ui-draggable.fade.in');
            var length = list.length;

            if (length <= 1) { return list; }

            var temp_swap;
            for (var i = 0; i < length - 1; i++) {
                for (var j = i + 1; j < length; j++) {
                    if ((reverse === false && parseInt($(list[i]).css("zIndex"), 10) > parseInt($(list[j]).css("zIndex"), 10))
                        || (reverse === true && parseInt($(list[i]).css("zIndex"), 10) < parseInt($(list[j]).css("zIndex"), 10))) {
                        temp_swap = list[i];
                        list[i] = list[j];
                        list[j] = temp_swap;
                    }
                }
            }
            return list;
        }

        function getFileExt(fileName) {
            var fileNameSplit = fileName.split('.');
            return fileNameSplit[fileNameSplit.length - 1];
        }

        function initTableState(tableState) {
            tableState = tableState || {};

            tableState.draw = tableState.draw || 0;

            tableState.pagination = tableState.pagination || {};
            tableState.pagination.numberOfPages = tableState.pagination.numberOfPages || 0;
            tableState.pagination.start = tableState.pagination.start || 0;
            tableState.pagination.number = tableState.pagination.number || 10;

            tableState.sort = tableState.sort || {};
            tableState.sort.predicate = '';
            tableState.sort.reverse = false;

            return tableState;
        }

        /* tự đông check / uncheck checkAll */
        function autoCheckAll(list) {
            if (!list || list.length == 0) {
                return false;
            }

            for (var i = 0; i < list.length; i++) {
                if (list[i].isSelected) {
                } else {
                    return false;
                }
            }

            return true;
        }

        /* checkAll / uncheckAll */
        function checkAll(list, isSelected) {
            if (!list || list.length == 0) {
                return false;
            }

            for (var i = 0; i < list.length; i++) {
                list[i].isSelected = isSelected;
            }
            return isSelected;
        }

        function checkInValid(value, type) {
            switch (type) {
                case 'isCode':
                    var pattern = /^[a-zA-Z0-9- ]*$/;
                    if (value == 'undefined' || value == null || value == '' || pattern.test(value) == false)
                        return true;
                    break;

                case 'isEmpty': if (value == undefined || value == null || value == '')
                    return true;
                    break;

                case 'isNumber':
                    var pattern = /^-?\d+\.?\d*$/;// /^[0-9- ]*$/;
                    if (value == 'undefined' || value == null || value == '' || pattern.test(value) == false)
                        return true;
                    break;
                case 'Email':
                    var pattern = /^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/;
                    if (value == 'undefined' || value == null || value == '' || pattern.test(value) == false)
                        return true;
                    break;
            }
            return false;
        }

        function joinStr(array, property, separator) {
            separator = separator || '|';
            var result = '';

            var list = new Array();
            for (var i = 0; i < array.length; i++) {
                list.push(array[i][property]);
            }

            result = list.join(separator);
            result = result || '';

            return result;
        }

        function clearArray(array) {
            while (array.length) { array.pop(); }
        }

        function convertDateFormat(strDate, formatInput, formatOutput) {
            var result = moment(strDate, formatInput).format(formatOutput);
            result = result == 'Invalid date' ? '' : result;
            return result;
        }

        // http://stackoverflow.com/questions/122102/what-is-the-most-efficient-way-to-deep-clone-an-object-in-javascript
        function cloneObject(obj) {
            return JSON.parse(JSON.stringify(obj));
        }

        // http://stackoverflow.com/questions/901115/how-can-i-get-query-string-values-in-javascript
        function getParameterByName(name, url) {
            if (!url) {
                url = window.location.href;
            }
            name = name.replace(/[\[\]]/g, "\\$&");
            var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
                results = regex.exec(url);
            if (!results) return null;
            if (!results[2]) return '';
            return decodeURIComponent(results[2].replace(/\+/g, " "));
        }

        // http://stackoverflow.com/questions/5999118/add-or-update-query-string-parameter
        function updateQueryStringParameter(key, value, uri) {
            if (!uri) {
                uri = window.location.href;
            }
            var re = new RegExp("([?&])" + key + "=.*?(&|$)", "i");
            var separator = uri.indexOf('?') !== -1 ? "&" : "?";
            if (uri.match(re)) {
                return uri.replace(re, '$1' + key + "=" + value + '$2');
            }
            else {
                return uri + separator + key + "=" + value;
            }
        }
    }
})();