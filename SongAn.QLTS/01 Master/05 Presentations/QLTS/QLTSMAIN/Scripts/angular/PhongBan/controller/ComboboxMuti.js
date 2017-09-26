﻿'use strict';

var app = angular.module('app');

app.filter('propsFilter', function () {
    return function (items, props) {
        var out = [];

        if (angular.isArray(items)) {
            items.forEach(function (item) {
                var itemMatches = false;

                var keys = Object.keys(props);
                for (var i = 0; i < keys.length; i++) {
                    var prop = keys[i];
                    var text = props[prop].toLowerCase();
                    if (item[prop].toString().toLowerCase().indexOf(text) !== -1) {
                        itemMatches = true;
                        break;
                    }
                }

                if (itemMatches) {
                    out.push(item);
                }
            });
        } else {
            // Let the output be the input untouched
            out = items;
        }

        return out;
    }
});

app.controller('PhongBanCombobox', function ($rootScope, $scope, PhongBanService) {
    var vm = this;
    var userInfo;
    vm.controllerId = 'PhongBanCombobox';
    vm.NameId = 'cbxPhongBan';
    vm.data = {
        PhongBanList: [],
        PhongBanListDisplay: [],
        PhongBan: {},
        isLoading: false,
        searchString: ''
    };

    vm.action = {
        getPage: getPage,
        OnClickSelect: OnClickSelect,
    };


    activate();
    vm.onInitView = onInitView;
    function activate() {
        eventAutoReload();
      
    }
    function onInitView(config) {
        if (config && config.controllerId) {
            vm.controllerId = config.controllerId;
        }
        if (config && config.NameId) {
            vm.NameId = config.NameId;
        }
        if (config && config.userInfo) {
            userInfo = config.userInfo;
        }
        initEventListener();
        getPage();
    }
    function initEventListener() {
        $scope.$on(vm.controllerId + '.action.loadData', function (event, data) {
            vm.data.PhongBan = data;
        });
        $scope.$on(vm.controllerId + '.action.clearData', function (event) {
            vm.data.PhongBan = {};
        });
        
    }
    function eventAutoReload() {
        $scope.$on('sa.qltsmain.cbxphongban.cbxphongban.reload', function (event) {
            getPage();
        });
    }
    function OnClickSelect() {
        $scope.$emit(vm.controllerId + '.action.SelectData', vm.data.PhongBan.selected);
    }
    function getPage() {
        var CoSoId = userInfo.CoSoId;
        var NhanVienId = userInfo.NhanVienId;
        var Search = '';
        PhongBanService.getCombobox(CoSoId, NhanVienId,Search).then(function (success) {
            if (success.data.data) {
                vm.data.PhongBanListDisplay = success.data.data;
            }
            vm.data.isLoading = false;
        }, function (error) {
            vm.data.isLoading = false;
            if (error.data.error != null) {
                alert(error.data.error.message);
            } else {
                alert(error.data.Message);

            }
        });
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

});