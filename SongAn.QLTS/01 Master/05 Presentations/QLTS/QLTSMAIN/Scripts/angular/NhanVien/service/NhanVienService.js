﻿(function () {
    'use strict';

    angular
        .module('app')
        .factory('NhanVienService', NhanVienService);

    function NhanVienService($http, API_BASE) {
    var api = {
        url: API_BASE+'Api.QLTS/NhanVien/',
        insert: 'InsertNhanVien',
        update: 'UpdateNhanVien',
        GetList: 'GetListNhanVien',
        GetPage: 'GetListNhanVienByProjection',
        GetCombobox: 'GetListcbxNhanVienByProjection',
        GetComboboxByPhongBanId : 'GetListcbxNhanVienByPhongBanId',
        GetById: 'GetNhanVienById',
        GetListBySearchString: 'GetListNhanVienBySearchString',
        getList: 'getList',
        getListCount: 'getListCount',
        getListProjection: 'getListProjection',
        remove: 'DeleteNhanVien',
        removeList: 'DeleteListNhanVien',
    }

    var service = {
        getCombobox: getCombobox,
        GetComboboxByPhongBanId:GetComboboxByPhongBanId,
            getList: getList,
            getPage: getPage,
            getById: getById,
            insert: insert,
            update: update,
            removeList: removeList,
        };

        return service;

        function removeList(ids) {
            var url = api.url + api.removeList;

            var req = {
                url: url,
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
                data: $.param({
                    ids: ids
                })
            }

            return $http(req);
        }

        function getPage(draw, start, length, searchString, sortName, sortDir, CoSoId, NhanVienId) {
            var url = api.url + api.GetPage;

            var req = {
                url: url,
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
                data: $.param({
                    draw: draw,
                    start: start,
                    length: length,
                    search: searchString,
                    sortName: sortName,
                    sortDir: sortDir,
                    CoSoId: CoSoId,
                    NhanVienId: NhanVienId,
                })
            }

            return $http(req);
        }

        function insert(obj) {
            if (!obj) {
                return null;
            };

            var url = api.url + api.insert;
            var req = {
                url: url,
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
                data: $.param({
                    nhanVien: obj.nhanVien,
                    phongBanId: obj.phongBanId,
                    coSoId: obj.coSoId
                })
            }
            return $http(req);
        }
        function getCombobox(CoSoId, NhanVienId, Search) {
            var url = api.url + api.GetCombobox;

            var req = {
                url: url,
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
                data: $.param({
                    Search: Search,
                    CoSoId: CoSoId,
                    NhanVienId: NhanVienId
                })
            }

            return $http(req);
        }
        function GetComboboxByPhongBanId(CoSoId, NhanVienId, Search, PhongBanId, IDNhanVien) {
            var url = api.url + api.GetComboboxByPhongBanId;

            var req = {
                url: url,
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
                data: $.param({
                    Search: Search,
                    CoSoId: CoSoId,
                    NhanVienId: NhanVienId,
                    PhongBanId: PhongBanId,
                    IDNhanVien:IDNhanVien
                })
            }

            return $http(req);
        }
        function update(obj) {
            var url = api.url + api.update;
            var req = {
                url: url,
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
                data: $.param({
                    nhanVien: obj.nhanVien,
                    phongBanId: obj.phongBanId,
                    coSoId: obj.coSoId
                })
            }
            return $http(req);
        }

        function getById(id) {
            var url = api.url + api.GetById;
            var req = {
                url: url,
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
                data: $.param({ NhanVienid: id })
            }
            return $http(req);
        };

        function getList() {
            var url = api.url + api.GetListBySearchString;

            var req = {
                url: url,
                method: 'GET'
            }

            return $http(req);
        }
    }
})();