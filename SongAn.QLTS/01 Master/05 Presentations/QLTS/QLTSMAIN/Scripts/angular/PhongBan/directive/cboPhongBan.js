﻿(function () {
    'use strict';
    var module = angular.module('app');

    module.directive('cboPhongBan', function () {
        return {
            restrict: 'E',
            scope: {
                onSelected: '&',
                input: '<',
                config: '<',
                value: '=',
                disabled: '<'
            },
            controller: controller,
            controllerAs: 'ctrl',
            templateUrl: function (elem, attrs) {
                return attrs.templateUrl || 'directive.html';
            }
        }
    });

    function controller($scope, $http, PhongBanService, $q, $timeout) {

        /*** PRIVATE ***/

        var vm = this,
            service = PhongBanService, userInfo;

        /*** VIEW MODEL ***/

        vm.status = {};

        vm.data = {};
        vm.inputSearch = {};
        vm.inputSearch.SearchString = '';
        vm.inputSearch.PhongBanId = 0;

        /*** INIT FUNCTION ***/

        function onInitView(config) {
            console.log(config);
            if (config && config.controllerId) {
                vm.controllerId = config.controllerId;
            }
            if (config && config.NameId) {
                vm.NameId = config.NameId;
            }
            if (config && config.userInfo) {
                userInfo = config.userInfo;
            }
        }


        $scope.$watch('value', function (newValue, oldValue) {
            
            if (!newValue) {
                vm.data.PhongBan = {};
                return;
            } 
            vm.inputSearch = {};
            vm.inputSearch.PhongBanId = newValue;

            getPage().then(function (success) {
                console.log('________________ CBXPHONGBAN_________________________________');
                if (success.data.data && success.data.data.length > 0) {
                    vm.data.PhongBan = success.data.data[0];
                } else {
                    delete vm.data.PhongBan;
                    vm.data.PhongBan = {};
                }
                $scope.onSelected({data:vm.data.PhongBan});
            });
        });

        activate()
        function activate() {
            onInitView($scope.config);

        }


        /*** ACTION FUNCTION ***/

        vm.action = {};

        vm.action.onSelected = function () {
            console.log('ITEM CBX PHONG BAN');
            $scope.onSelected({ data: vm.data.PhongBan });
            $scope.value = vm.data.PhongBan.PhongBanId;
        };
        vm.action.search = function ($select) {
            $select.search = $select.search || '';
            vm.inputSearch = {};
            vm.inputSearch.SearchString = $select.search;
            getPage();
        }

        /*** BIZ FUNCTION ***/

        /*** API FUNCTION ***/

        function getPage() {
            var CoSoId = userInfo.CoSoId || 0;
            var NhanVienId = userInfo.NhanVienId || 0;
            var search = vm.inputSearch.SearchString || '';
            var PhongBanId = vm.inputSearch.PhongBanId || 0;

            return $q(function (resolve, reject) {
                service.getComboboxById(CoSoId, NhanVienId, vm.inputSearch.SearchString, PhongBanId)
                    .then(function (success) {
                        vm.status.isLoading = false;
                        console.log(success);
                        if (success.data.data) {
                            vm.data.PhongBanListDisplay = success.data.data;
                        }
                        return resolve(success);
                    }, function (error) {
                        console.log(error);
                        
                        return reject(error);
                    });
            });
        }
    }
})();