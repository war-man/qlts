﻿(function () {
    'use strict';
    var module = angular.module('app');
    module.controller('CongViecTruocDayEditCtrl', function ($scope, utility, CongViecTruocDayService) {

        /*** PRIVATE ***/

        var service = CongViecTruocDayService,
            vm = this,
            nhanVienId = 0,
            CongViecTruocDayId = 0,
            userInfo;

        /*** VIEW MODEL ***/

        vm.controllerId = 'CongViecTruocDayEditCtrl';

        vm.status = {};
        vm.status.isLoading = false;

        vm.error = {};

        vm.data = {};
        vm.data.CongViecTruocDay = {};

        /*** INIT FUNCTION ***/

        vm.onInitView = function (config) {
            console.log(config);
            if (config === undefined) { return; }
            nhanVienId = config.nhanVienId || nhanVienId;
            vm.controllerId = config.controllerId || vm.controllerId;
            userInfo = config.userInfo || userInfo;
            initEventListener();
        }

        /*** ACTION FUNCTION ***/

        vm.action = {};
        vm.action.checkQuyenTacVu = checkQuyenUI;

        vm.action.keyPressEnter = function (event) {
            if (event.keyCode != 13) { return; }
            if (checkInput($(event.target).data('name')) === false) {
                return;
            }
            $('[data-name="' + $(event.target).data('next') + '"]').focus();
        }

        vm.action.apDung = function () {
            var data = { CongViecTruocDay: row };
            emitApDung(data);
        }
        vm.action.refresh = function () {
            refresh();
        }
        vm.action.save = function () {
            if (vm.status.isLoading) { return; }
            if (checkInput() === false) { return; }

            if (checkQuyenUI('M') == false) { return; }

            if (CongViecTruocDayId) {
                update(vm.data.CongViecTruocDay);
            } else {
                insert(vm.data.CongViecTruocDay);
            }
        }
        vm.action.remove = function () {
            if (vm.status.isLoading) { return; }

            if (checkQuyenUI('D') == false) { return; }
            if (confirm('Bạn có muốn xóa không ?')) {
                remove(vm.data.CongViecTruocDay);
            }
        }
        vm.action.close = function () {
            if (vm.status.isLoading) { return; }
            close();
        }

        /*** BROADCAST / EMIT / ON EVENT FUNCTION ***/

        function initEventListener() {
            $scope.$on(vm.controllerId + '.action.edit', function (e, v) {
                console.log(v);
                if (v && v.CongViecTruocDay) {
                    CongViecTruocDayId = v.CongViecTruocDay.CongViecTruocDayId;
                    refresh();
                }
            });
            $scope.$on(vm.controllerId + '.action.create', function (e, v) {
                console.log(v);
                if (v && v.NhanVienId) {
                    nhanVienId = v.nhanVienId || nhanVienId;
                }
            });
            $(document).ready(function () {
                $('#' + vm.controllerId).on('shown.bs.collapse', function () {
                    $('#' + vm.controllerId + ' input[autofocus]').focus();
                });

                $('#' + vm.controllerId).on('hidden.bs.collapse', function () {
                    reset();
                });
            });
        }

        function emitApDung(data) {
            console.log(vm.controllerId + '.action.ap-dung');
            $scope.$emit(vm.controllerId + '.action.ap-dung', data);
        }

        /*** BIZ FUNCTION ***/

        /* kiểm tra quyền tác vụ */
        function checkQuyenUI(quyen) {
            var lisQuyenTacVu;

            // kiểm tra danh sách quyền # null
            if (userInfo && userInfo.DsQuyenTacVu) {
                var lisQuyenTacVu = userInfo.DsQuyenTacVu.split(',');
            } else { return false; }

            return lisQuyenTacVu.indexOf(quyen) >= 0;
        }

        function close() {
            $('#' + vm.controllerId).collapse('hide');
        }

        function checkInput(inputName) {
            var has_error = false;
            var first_error_name = '';
            var name = '';

            name = 'CongTy';
            if (!inputName || inputName === name) {
                vm.error[name] = '';
                if (utility.checkInValid(vm.data.CongViecTruocDay[name], 'isEmpty')) {
                    first_error_name = has_error ? first_error_name : name;
                    vm.error[name] = '.';
                    has_error = true;
                }
            }
            name = 'TuNgay';
            if (!inputName || inputName === name) {
                vm.error[name] = '';
                if (utility.checkInValid(vm.data.CongViecTruocDay[name], 'isEmpty')) {
                    first_error_name = has_error ? first_error_name : name;
                    vm.error[name] = '.';
                    has_error = true;
                }
            }
            name = 'DenNgay';
            if (!inputName || inputName === name) {
                vm.error[name] = '';
                if (utility.checkInValid(vm.data.CongViecTruocDay[name], 'isEmpty') ||
                    compareDate(vm.data.CongViecTruocDay.TuNgay, vm.data.CongViecTruocDay.DenNgay) == -1) {
                    first_error_name = has_error ? first_error_name : name;
                    vm.error[name] = '.';
                    has_error = true;
                }
            }
            name = 'MoTa';
            if (!inputName || inputName === name) {
                vm.error[name] = '';
                if (utility.checkInValid(vm.data.CongViecTruocDay[name], 'isEmpty')) {
                    first_error_name = has_error ? first_error_name : name;
                    vm.error[name] = '.';
                    has_error = true;
                }
            }

            if (first_error_name) {
                $('[data-name="' + first_error_name + '"]').focus();
            }

            return !has_error;
        }

        function reset() {
            CongViecTruocDayId = 0;
            refresh();
        }

        function compareDate(startDate, endDate, format) {
            format = format || 'DD/MM/YYYY';
            var TuNgay = moment(startDate, format);
            var DenNgay = moment(endDate, format);
            if (TuNgay > DenNgay) {
                return -1;
            }
            return 1;
        }

        function refresh() {
            delete vm.data.error;
            vm.error = {};

            getById(CongViecTruocDayId);
        }

        /*** API FUNCTION ***/

        function fixData(data) {
            data.TuNgay = utility.convertDateFormat(data.TuNgay, 'YYYY-MM-DD', 'DD/MM/YYYY');
            data.DenNgay = utility.convertDateFormat(data.DenNgay, 'YYYY-MM-DD', 'DD/MM/YYYY');
        }

        function prepareData(data) {
            data.TuNgay = utility.convertDateFormat(data.TuNgay, 'DD/MM/YYYY', 'YYYY-MM-DD');
            data.DenNgay = utility.convertDateFormat(data.DenNgay, 'DD/MM/YYYY', 'YYYY-MM-DD');
        }

        function getById(id) {
            if (!id) {
                delete vm.data.CongViecTruocDay;
                vm.data.CongViecTruocDay = {};
                return;
            }

            vm.status.isLoading = true;

            var data = {};
            data.search = id;

            service.getById(data).then(function (result) {
                console.log(result);
                delete vm.data.CongViecTruocDay;
                if (result && result.data && result.data.data && result.data.data.length) {
                    vm.data.CongViecTruocDay = result.data.data[0];
                    fixData(vm.data.CongViecTruocDay);
                } else {
                    vm.data.CongViecTruocDay = {};
                }
                vm.status.isLoading = false;
            }, function (result) {
                console.log(result);
                if (result.data.error != null) {
                    alert(result.data.error.message);
                } else {
                    alert(result.data.Message);
                }
                vm.status.isLoading = false;
            });
        }
        function insert(data) {
            vm.status.isLoading = true;

            var param = utility.clone(data);
            prepareData(param);
            param.NhanVienId = nhanVienId;
            param.loginId = userInfo.NhanVienId || 0;

            service.insert(param).then(function (result) {
                console.log(result);
                if (result && result.data && result.data.data && result.data.data.length) {
                    alert('Thêm thành công');
                    CongViecTruocDayId = result.data.data[0].CongViecTruocDayId;
                    refresh();
                }
                emitApDung();
                vm.status.isLoading = false;
            }, function (result) {
                console.log(result);
                if (result.data.error != null) {
                    alert(result.data.error.message);
                } else {
                    alert(result.data.Message);
                }
                vm.status.isLoading = false;
            });
        }
        function update(data) {
            vm.status.isLoading = true;

            var param = utility.clone(data);
            prepareData(param);
            param.loginId = userInfo.NhanVienId || 0;

            service.update(param).then(function (result) {
                console.log(result);
                if (result && result.data && result.data.data && result.data.data.length) {
                    alert('Cập nhật thành công');
                    refresh();
                }
                emitApDung();
                vm.status.isLoading = false;
            }, function (result) {
                console.log(result);
                if (result.data.error != null) {
                    alert(result.data.error.message);
                } else {
                    alert(result.data.Message);
                }
                vm.status.isLoading = false;
            });
        }
        function remove(data) {
            vm.status.isLoading = true;

            var param = utility.clone(data);
            prepareData(param);
            param.loginId = userInfo.NhanVienId || 0;

            service.remove(param).then(function (result) {
                console.log(result);
                alert('Xóa thành công');
                emitApDung();
                vm.status.isLoading = false;
            }, function (result) {
                console.log(result);
                if (result.data.error != null) {
                    alert(result.data.error.message);
                } else {
                    alert(result.data.Message);
                }
                vm.status.isLoading = false;
            });
        }

        /*** HELPER FUNCTION ***/
    });
})();