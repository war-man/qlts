﻿(function () {
    'use strict';

    angular
        .module('app')
        .controller('MainCtrl', MainCtrl);

    function MainCtrl($scope, $rootScope, $http) {

        var vm = this;
        vm.data = {};

        vm.controllerId = {
            NhanVienListPopup: 'NhanVienListPopupCtrl',
            NhanVienListPopupSearch: 'NhanVienListPopupSearch',
            TamUngEditCtrl: 'TamUngEditCtrl',
            TamUngListCtrl: 'TamUngListCtrl'
        }

        vm.onInitView = function (config) {
        }

        activate();

        function activate() {
            catchNhanVienListPopupEvent();
            catchNhanVienListPopupSearchEvent();
        }
        function catchNhanVienListPopupEvent() {
            $scope.$on(vm.controllerId.NhanVienListPopup + '.action.ap-dung', function (event, data) {
                $rootScope.$broadcast(vm.controllerId.TamUngEditCtrl + '.data.listNhanVien', data);
                $('#NhanVienListPopup').collapse('hide');
            });
          
            $('#NhanVienListPopup').on('show.bs.collapse', function () {
                $scope.$broadcast(vm.controllerId.NhanVienListPopup + '.action.get-filters', { searchString: '' });
            });
        }
        function catchNhanVienListPopupSearchEvent() {
            $scope.$on(vm.controllerId.NhanVienListPopupSearch + '.action.ap-dung', function (event, data) {
                $rootScope.$broadcast(vm.controllerId.TamUngListCtrl + '.data.listNhanVienSearch', data);
                $('#NhanVienListPopupSearch').collapse('hide');
            });
            $('#NhanVienListPopupSearch').on('show.bs.collapse', function () {
                $scope.$broadcast(vm.controllerId.NhanVienListPopup + '.action.get-filters', { searchString: '' });
            });
        }

    }
})();