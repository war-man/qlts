﻿
(function () {
    'use strict';
    var app = angular.module('app');
    app.controller('GhiTangEditCtrl', function ($rootScope, $scope, GhiTangService, TaiSanService, utility, $timeout, KhoaSoLieuService, $q) {
        /*** PRIVATE ***/

        var vm = this;

        //HOT-KEY       
        vm.keys = {
            F2: function (name, code) {
                CreateListChiTiet();
                var fc = function () {
                    $("#txtMaTaiSan" + (vm.data.listChiTiet.length - 1).toString()).focus();
                }
                $timeout(fc, 6);
            },
            F8: function (name, code) {
                vm.action.save();
            },
            DELETE: function (name, code) {
                var fc = function () {
                    vm.data.listChiTiet.splice(vm.data.listChiTiet.length - 1, 1);
                    $("#txtMaTaiSan" + (vm.data.listChiTiet.length - 1).toString()).focus();
                }
                $timeout(fc, 6);
            }
        };
        //end HOT-KEY

        var _tableState;
        var userInfo;
        var linkUrl = '';
        var phieuGhiTangId = 0;

        /*** VIEW MODEL ***/

        vm.controllerId = 'GhiTangEditCtrl';
        vm.getphieuGhiTangId = function () {
            return phieuGhiTangId || 0;
        }

        vm.error = {};

        vm.data = {};
        vm.data.phieuGhiTang = {};
        vm.data.listChiTiet = [];
        vm.data.listChiTietGoc = [];
        vm.data.fullDateString = '';
        vm.data.linkUrl = '';
        vm.data.listQuyenTacVu = [];
        vm.data.showButtonSave = false;
        vm.data.showButtonXoa = false;
        vm.data.showButtonNew = false;
        vm.data.Tilte = 'Thêm';
        /*** INIT FUNCTION ***/

        // chạy khi controller được khởi tạo
        (function activate() {

        })();

        // nhận config từ view
        vm.onInitView = function (config) {
            vm.data.fullDateString = fullDateString(moment().format('DDMMYYYY'), 'DDMMYYYY');


            if (config && config.userInfo) {
                userInfo = config.userInfo;
                vm.data.listQuyenTacVu = config.userInfo.DsQuyenTacVu.split(',');
                setEnableButton();
            }

            if (config && config.linkUrl) {
                vm.data.linkUrl = config.linkUrl;
            }

            if (config && config.ghiTangId) {
                phieuGhiTangId = config.ghiTangId;
                if (config.ghiTangId > 0) {
                    getphieuGhiTangById(config.ghiTangId);
                    vm.data.Tilte = 'Sửa';
                }
            }
            else if (config && config.ghiTangId === 0) {
                vm.data.phieuGhiTang.NgayChungTu = moment().format('DD/MM/YYYY');
                vm.data.phieuGhiTang.NgayGhiTang = moment().format('DD/MM/YYYY');
                CreateListChiTiet();
            }

            initEventListener();
            $("#txtSoChungTu").focus();
        };

        /* ACTION FUNCTION */

        vm.action = {};

        vm.action.goBack = function () {
            window.history.back();
        };

        vm.action.In = function () {
            $('#reportmodal').find('iframe').attr('src', '../../../QLTSMAIN/CrystalReport/ReportPage.aspx?name=rptGhiTangById&data=' + phieuGhiTangId);
            $('#reportmodal').modal('show');
        };

        vm.action.add = function () {
            CreateListChiTiet();
            var fc = function () {
                $("#txtMaTaiSan" + (vm.data.listChiTiet.length - 1).toString()).focus();
            }
            $timeout(fc, 6);
        };

        vm.action.save = function () {

            var obj = InvalidateDataPhieuGhiTang();

            if (obj == null)
                return;
            if (InvalidateDataPhieuGhiTangChiTiet())
                return;
            checkKhoaSoLieuNam().then(function (success) {

                if (phieuGhiTangId > 0) {
                    var cp = compareList();
                    update(cp);
                }
                else {
                    insert();
                }
            }, function (error) {
                utility.AlertError('Số liêu năm ' + vm.data.phieuGhiTang.NgayGhiTang.substring(6, 12) + ' đã bị khóa. Vui lòng kiểm tra lại !');
            });
        };

        vm.action.removePhieuGhiTang = function () {

            if (phieuGhiTangId <= 0) {
                alert("Phiếu này không tồn tại trong hệ thống!");
                return;
            }

            if (!confirm('Bạn có muốn xóa phiếu này?')) {
                return;
            }

            var GhiTangListSelected = new Array();

            GhiTangListSelected.push(phieuGhiTangId);

            var ids = GhiTangListSelected.join(',');
            if (ids.length > 0) {
                checkKhoaSoLieuNam().then(function (success) {

                    GhiTangService.DeleteList(ids).then(function (success) {

                        if (success.data.data > 0) {
                            if (GhiTangListSelected.length > parseInt(success.data.data)) {
                                var sl = GhiTangListSelected.length - parseInt(success.data.data);
                                utility.AlertSuccess(sl + ' phiếu được xóa thành công.');
                            }
                            else
                                utility.AlertError('Tài sản đã được sử dụng. Không thể xóa!');
                        } else {
                            utility.AlertSuccess('Xóa thành công!');
                        }

                        $timeout(function () {
                            window.location.href = vm.data.linkUrl + 'ghitang/list';
                        }, 600);
                    }, function (error) {
                        alert(error.data.error.code + " : " + error.data.error.message);
                    });
                }, function (error) {
                    utility.AlertError('Số liêu năm ' + vm.data.phieuGhiTang.NgayGhiTang.substring(6, 12) + ' đã bị khóa. Vui lòng kiểm tra lại !');
                });

            } else {
                utility.AlertError('Không tìm thấy phiếu để xóa!');
            }
        };
        vm.action.keyPressGhiTang = function (value, fromId, ToId, event) {

            var obj = vm.data.phieuGhiTang;
            //check Enter key is press
            if (event.keyCode == '13') {
                //set condition of has-error
                if (fromId == 'txtNgayChungTu') {
                    vm.error.NgayChungTu = utility.checkInValid(obj.NgayChungTu, 'isEmpty');
                    if (vm.error.NgayChungTu) {
                        $("#" + fromId).focus();
                    } else $("#" + ToId).focus();
                }
                else if (fromId == 'txtNgayGhiTang') {
                    vm.error.NgayGhiTang = utility.checkInValid(obj.NgayGhiTang, 'isEmpty');
                    if (vm.error.NgayGhiTang) {
                        $("#" + fromId).focus();
                    } else $("#" + ToId).focus();
                }
                else if (fromId == 'txtSoChungTu') {
                    vm.error.SoChungTu = utility.checkInValid(obj.SoChungTu, 'isEmpty');
                    if (vm.error.SoChungTu) {
                        $("#" + fromId).focus();
                    } else $("#" + ToId).focus();
                }
                else if (fromId == 'txtNoiDung') {
                    vm.error.NoiDung = utility.checkInValid(obj.NoiDung, 'isEmpty');
                    if (vm.error.NoiDung) {
                        $("#" + fromId).focus();
                    } else $("#" + ToId).focus();
                }
                else $("#" + ToId).focus();


            }
        }
        vm.action.keyPress = function (value, fromId, ToId, index, event) {
            //check Enter key is press
            if (event.keyCode == '13') {
                //set condition of has-error
                if (fromId == ('txtSoLuong' + index)) {
                    if ($("#txtSoLuong" + (index + 1)).length == 0) {
                        CreateListChiTiet();
                        var fc = function () {
                            $("#txtMaTaiSan" + (parseInt(index) + 1).toString()).focus();
                        }
                        $timeout(fc, 6);
                    }
                    else {
                        $("#txtMaTaiSan" + (parseInt(index) + 1).toString()).focus();
                    }
                }
                else if (fromId == ('txtMaTaiSan' + index)) {

                    vm.data.listChiTiet[index].TempMaTaiSan = value;
                    $timeout(function () {
                        if (vm.data.listChiTiet[index].TaiSanId > 0) {
                            $("#" + ToId + " input").focus();
                        }
                    }, 100);
                    //if (value != "") {
                    //    $timeout(function () {
                    //        getTaiSan(value);
                    //    }, 0);

                    //    $timeout(function () {
                    //        vm.data.listChiTiet[index].TaiSanId = vm.data.TaiSan.TaiSanId;
                    //        vm.data.listChiTiet[index].NguyenGia = vm.data.TaiSan.NguyenGia;
                    //        vm.data.listChiTiet[index].DonViTinh = vm.data.TaiSan.DonViTinh;
                    //    }, 100);
                    //} else {
                    //    vm.data.listChiTiet[index].TaiSanId = 0;
                    //    vm.data.listChiTiet[index].NguyenGia = 0;
                    //    vm.data.listChiTiet[index].DonViTinh = "";
                    //}
                }
                else $("#" + ToId).focus();
            }
                //check TAB key is press
            else if (event.keyCode == '9') {
                if (fromId == ('txtMaTaiSan' + index)) {
                    vm.data.listChiTiet[index].TempMaTaiSan = value;
                }
            }
        }

        vm.action.resetNhanVienId = function (data, index) {
            //console.log(data);
            //console.log(index);
            vm.data.listChiTiet[index.$index].PhongBanId = data.PhongBanId;
            vm.data.listChiTiet[index.$index].NhanVienId = 0;
        }
        vm.action.getDataTaiSan = function (data, index) {
            //console.log(data);
            //console.log(index);

            vm.data.listChiTiet[index.$index].TaiSanId = data.TaiSanId;
            vm.data.listChiTiet[index.$index].MaTaiSan = data.MaTaiSan || vm.data.listChiTiet[index.$index].MaTaiSan;;
            vm.data.listChiTiet[index.$index].NguyenGia = data.NguyenGia;
            vm.data.listChiTiet[index.$index].DonViTinh = data.DonViTinh;
            //if (data.TaiSanId > 0) $("#cbxPhongBan" + index.$index).find('input').focus();

        }
        vm.action.nhanVienByPhongBanSelected = function (data, index) {
            //console.log(data);
            vm.data.listChiTiet[index.$index].NhanVienId = data.NhanVienId;
        }


        /*** BROADCAST / EMIT / ON FUNCTION ***/

        function initEventListener() {

        }

        /*** BIZ FUNCTION ***/

        function setEnableButton() {
            if (document.referrer.toUpperCase().indexOf("TRACUUTAISAN") > 1) {
                return;
            }
            if (vm.data.listQuyenTacVu.length > 0) {

                // Co quyen them moi
                if (vm.data.listQuyenTacVu.indexOf("N") > 0) {
                    vm.data.showButtonNew = true;
                }

                // Co quyen Xoa
                if (vm.data.listQuyenTacVu.indexOf("D") > 0) {
                    vm.data.showButtonXoa = true;
                }

                // Co quyen Sua
                if (vm.data.listQuyenTacVu.indexOf("M") > 0) {
                    vm.data.showButtonSave = true;
                }
                if (vm.data.listQuyenTacVu.indexOf("L") > 0) {
                    vm.data.showButtonSave = true;
                }
            }
        }

        function CreateListChiTiet() {
            var chitiet = {};
            chitiet.PhieuGhiTangChiTietId = 0;
            chitiet.GhiTangId = 0;
            chitiet.TaiSanId = 0;
            chitiet.NgayBatDauSuDung = moment().format('DD/MM/YYYY');
            chitiet.PhongBanId = 0;
            chitiet.NhanVienId = 0;
            chitiet.SoLuong = 0;
            vm.data.listChiTiet.push(chitiet);
            $timeout(function () {
                $//("#txtMaTaiSan" + (vm.data.listChiTiet.length - 1).toString()).focus();
                jQuery("#txtNgayBatDauSuDung" + (vm.data.listChiTiet.length - 1)).datetimepicker({
                    mask: '39/19/9999', format: 'd/m/Y', timepicker: false, scrollInput: false, startDate: '+1971/05/01'
                })
            }, 100);
        }

        function insert() {
            utility.addloadding($('body'));
            vm.data.phieuGhiTang.CoSoId = userInfo.CoSoId;

            var phieuGhiTang = utility.clone(vm.data.phieuGhiTang);
            var data = {};
            data.phieuGhiTang = angular.toJson(phieuGhiTang);
            data.listChiTiet = angular.toJson(vm.data.listChiTiet);
            data.loginId = userInfo ? userInfo.NhanVienId : 0;
            GhiTangService.insert(data)
                .then(function success(result) {
                    utility.removeloadding();
                    if (parseInt(result.data.data[0]["GhiTangIdI"]) < 0) {
                        utility.AlertError("Năm đã chốt hoặc ngày ghi tăng không hợp lệ!");
                    }
                    else {
                        utility.AlertSuccess("Ghi tăng thành công");

                        $timeout(function () {
                            window.location = vm.data.linkUrl + 'ghitang/edit/' + result.data.data[0].GhiTangIdI;
                        }, 2000);
                    }

                }, function error(result) {
                    console.log(result);
                    utility.removeloadding();
                    if (result.status === 400) {
                        alert(result.data.error.message);
                    } else {
                        utility.AlertError('Không thể thêm');
                    }
                });
        }

        function update(compare) {
            utility.addloadding($('body'));
            vm.data.phieuGhiTang.CoSoId = userInfo.CoSoId;

            var phieuGhiTang = utility.clone(vm.data.phieuGhiTang);
            var data = {};
            data.ghiTangId = phieuGhiTangId;
            data.phieuGhiTang = angular.toJson(phieuGhiTang);
            data.listChiTiet = angular.toJson(vm.data.listChiTiet);
            data.loginId = userInfo ? userInfo.NhanVienId : 0;
            data.compare = compare; // 1: update header
            GhiTangService.update(data)
                .then(function success(result) {
                    utility.removeloadding();
                    if (parseInt(result.data.data[0]["ID"]) < 0) {
                        if (parseInt(result.data.data[0]["ID"]) == -1)
                            utility.AlertError("Không thể cập nhật. Tài sản đã được sử dụng. Số lượng không đủ!");
                        else if (parseInt(result.data.data[0]["ID"]) == -2)
                            utility.AlertError("Phiếu đã duyệt. Không thể chỉnh sửa!");
                        else if (parseInt(result.data.data[0]["ID"]) == -3)
                            utility.AlertError("Năm đã chốt hoặc ngày ghi tăng không hợp lệ!");
                    }
                    else
                        utility.AlertSuccess("Cập nhật thành công");
                }, function error(result) {
                    console.log(result);
                    utility.removeloadding();
                    if (result.status === 400) {
                        alert(result.data.error.message);
                    } else {
                        utility.AlertError('Không thể cập nhật');
                    }
                });
        }

        function InvalidateDataPhieuGhiTang() {
            var obj = vm.data.phieuGhiTang;

            vm.error.SoChungTu = utility.checkInValid(obj.SoChungTu, 'isEmpty');
            if (vm.error.SoChungTu) {
                $("#txtSoChungTu").focus();
                return null;
            }

            vm.error.NgayChungTu = utility.checkInValid(obj.NgayChungTu, 'isEmpty');
            if (vm.error.NgayChungTu) {
                $("#txtNgayChungTu").focus();
                return null;
            }
            vm.error.NgayGhiTang = utility.checkInValid(obj.NgayGhiTang, 'isEmpty');
            if (vm.error.NgayGhiTang) {
                $("#txtNgayGhiTang").focus();
                return null;
            }


            return 1;
        }

        function InvalidateDataPhieuGhiTangChiTiet() {
            var hasError = false;

            if (!vm.data.listChiTiet || vm.data.listChiTiet.length == 0) {
                utility.AlertError('Bạn chưa nhập thông tin chi tiết!');
                return true;
            }
            for (var index = 0; index < vm.data.listChiTiet.length; index++) {
                if (utility.checkInValid(vm.data.listChiTiet[index].TaiSanId, 'isEmpty')) {
                    hasError = true;
                    vm.data.listChiTiet[index].isError = true;
                    return hasError;
                }
                else if (utility.checkInValid(vm.data.listChiTiet[index].PhongBanId, 'isEmpty')) {
                    hasError = true;
                    vm.data.listChiTiet[index].isError = true;
                    return hasError;
                }
                else if (utility.checkInValid(vm.data.listChiTiet[index].NhanVienId, 'isEmpty')) {
                    hasError = true;
                    vm.data.listChiTiet[index].isError = true;
                    utility.AlertError('Vui lòng chọn lại nhân viên !');
                    return hasError;
                }
                else if (utility.checkInValid(vm.data.listChiTiet[index].NgayBatDauSuDung, 'isEmpty')) {
                    hasError = true;
                    vm.data.listChiTiet[index].isError = true;
                    return hasError;
                }
                else if (utility.checkInValid(vm.data.listChiTiet[index].SoLuong, 'isEmpty')) {
                    hasError = true;
                    vm.data.listChiTiet[index].isError = true;
                    return hasError;
                }
                else {
                    hasError = false;
                    vm.data.listChiTiet[index].isError = false;
                }
            }

            return hasError;
        }

        function getphieuGhiTangById(id) {

            GhiTangService.GetPageHeaderById(id)
                .then(function success(result) {
                    console.log(result);
                    delete vm.data.phieuGhiTang;

                    if (result.data && result.data.data && result.data.data.length) {
                        vm.data.phieuGhiTang = result.data.data[0];

                        getphieuGhiTangChiTietById(vm.data.phieuGhiTang.GhiTangId);
                    }
                }, function error(result) {
                    console.log(result);
                });
        }

        function getphieuGhiTangChiTietById(id) {

            GhiTangService.GetPageDetail(id)
                .then(function success(result) {
                    vm.data.listChiTiet = [];

                    if (result.data && result.data.data && result.data.data.length) {
                        console.log(result.data.data);
                        vm.data.listChiTiet = result.data.data;
                        vm.data.listChiTietGoc = angular.copy(result.data.data);
                        $timeout(function () {
                            jQuery("#txtNgayBatDauSuDung" + (vm.data.listChiTiet.length - 1)).datetimepicker({
                                mask: '39/19/9999', format: 'd/m/Y', timepicker: false, scrollInput: false, startDate: '+1971/05/01'
                            })
                        }, 100);
                    }
                }, function error(result) {
                    console.log(result);
                });
        }

        function getTaiSan(maTaiSan) {
            var CoSoId = userInfo.CoSoId || 0;
            var NhanVienId = userInfo.NhanVienId || 0;

            TaiSanService.getCombobox(CoSoId, NhanVienId, "")
                .then(function (success) {

                    console.log(success);
                    if (success.data.data) {

                        for (var index in success.data.data) {
                            if (success.data.data[index].MaTaiSan.toUpperCase() == maTaiSan.toUpperCase()) {
                                vm.data.TaiSan = success.data.data[index];
                                return;
                            }
                        }
                    }
                }, function error(result) {
                    console.log(result);

                    if (result.status === 400) {
                        alert(result.data.error.message);
                    } else {

                    }
                });
        }

        function reset() {
            vm.data.phieuGhiTang = {};
            vm.data.listChiTiet = "";
            vm.data.TaiSan = {};
        }

        function compareList() {

            for (var index1 in vm.data.listChiTiet) {
                if (typeof vm.data.listChiTietGoc[index1] === "undefined") {
                    return 0;
                }
                else {
                    vm.data.listChiTietGoc[index1].TaiSanId = parseInt(vm.data.listChiTietGoc[index1].TaiSanId);
                    vm.data.listChiTietGoc[index1].isError = false;
                }

                if (angular.toJson(vm.data.listChiTiet[index1]) === angular.toJson(vm.data.listChiTietGoc[index1])) {

                }
                else {
                    return 0;
                }
            }
            return 1;
        }
        function checkKhoaSoLieuNam() {
            debugger
            var deferred = $q.defer();
            var Nam = vm.data.phieuGhiTang.NgayGhiTang.substring(6, 12);
            KhoaSoLieuService.CheckKhoaSoLieu(Nam, userInfo.CoSoId).then(function (success) {
                console.log(success);
                if (success.data.data[0].TrangThai == 1) {
                    return deferred.reject(success);
                } else {
                    return deferred.resolve(success);
                }
            }, function (error) {
                console.log(error);
                if (error.status === 400) {
                    utility.AlertError(error.data.error.message);
                } else {
                    utility.AlertError('Lỗi !');
                }
            });
            return deferred.promise;
        }


        /*** HELPERS ***/
        function compare(dateTimeA, dateTimeB) {
            var momentA = moment(dateTimeA, "DD/MM/YYYY");
            var momentB = moment(dateTimeB, "DD/MM/YYYY");
            if (momentA > momentB) return 1;
            else if (momentA < momentB) return -1;
            else return 0;
        }

        function fullDateString(strDate, strFormat) {
            var date = moment(strDate, strFormat);
            return 'ngày ' + date.format('DD') + ' tháng ' + date.format('MM') + ' năm ' + date.format('YYYY');
        }

        function removeListItem(list, item, prop) {
            var list_length = list.length;
            for (var i = 0; i < list_length; i++) {
                if (list[i][prop] === item[prop]) {
                    list.splice(i, 1);
                    break;
                }
            }

            return list;
        }

    });// end controller

    app.directive("keyboard", keyboard);
    //HOT-KEY
    function keyboard($document, keyCodes) {
        return {
            link: function (scope, element, attrs) {

                var keysToHandle = scope.$eval(attrs.keyboard);
                var keyHandlers = {};

                // Registers key handlers
                angular.forEach(keysToHandle, function (callback, keyName) {
                    var keyCode = keyCodes[keyName];
                    keyHandlers[keyCode] = { callback: callback, name: keyName };
                });

                // Bind to document keydown event
                $document.on("keydown", function (event) {

                    var keyDown = keyHandlers[event.keyCode];

                    // Handler is registered
                    if (keyDown) {
                        event.preventDefault();

                        //// Invoke the handler and digest
                        //scope.$apply(function () {
                        //    keyDown.callback(keyDown.name, event.keyCode);
                        //})
                    }
                });
            }
        }
    };
    //end HOT-KEY

})();