﻿(function () {
    'use strict';

    angular
        .module('app')
        .factory('ChiNhanhService', KhoNhomHangHoaService);

    function KhoNhomHangHoaService($http, API_BASE) {
        var api = {};
        api.url = API_BASE + 'api.QLNS/chinhanh/';
        api.GetById = 'GetChiNhanhById';
        api.insert = 'InsertChiNhanh';
        api.update = 'UpdateChiNhanh';
        api.removeList = 'UpdateXoaListChiNhanh';
        api.GetPage = 'GetListChiNhanhByCriteria';

        var service = {};
        service.getById = function (data) {
            var url = api.url + api.GetById;
            var req = {
                url: url,
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
                data: $.param(data)
            }
            return $http(req);
        };
        service.insert = function (data) {
            var url = api.url + api.insert;
            var req = {
                url: url,
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
                data: $.param(data)
            }
            return $http(req);
        }
        service.update = function (data) {
            var url = api.url + api.update;
            var req = {
                url: url,
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
                data: $.param(data)
            }
            return $http(req);
        }
        service.removeList = function (data) {
            var url = api.url + api.removeList;

            var req = {
                url: url,
                method: 'POST',
                headers: {
                    'Content-type': 'application/json'
                },
                data: { listChiNhanh: angular.toJson(data.list), loginId: data.loginId }
            }

            return $http(req);
        }
        service.getPage = function (data) {
            var url = api.url + api.GetPage;

            var req = {
                url: url,
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
                data: $.param(data)
            }

            return $http(req);
        };
        return service;
    }
})();