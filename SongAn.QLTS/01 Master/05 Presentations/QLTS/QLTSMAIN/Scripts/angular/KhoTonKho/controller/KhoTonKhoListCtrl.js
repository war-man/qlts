﻿(function () {
    'use strict';

    angular.module("app")
        .controller("KhoTonKhoListCtrl", controller)

    function controller($rootScope, $scope, KhoTonKhoService, utility) {
        var vm = this;
        //HOT-KEY       
        vm.keys = {
            //press ESC -> close popup
            ESC: function (name, code) {
                //alert("ESC");
                console.log('ESC');
                var index_highest = 0;
                var ele_highest;
                var ele_focus;
                var ele_current;
                // more effective to have a class for the div you want to search and 
                // pass that to your selector
                $('.panel.ui-draggable.fade.in').each(function () {
                    // always use a radix when using parseInt
                    var index_current = parseInt($(this).css("zIndex"), 10);
                    ele_current = $(this);
                    if (index_current > index_highest) {
                        index_highest = index_current;
                        ele_focus = ele_highest;
                        ele_highest = ele_current;
                    }
                });
                if (ele_highest) {
                    $(ele_highest).collapse('hide');
                    $(ele_focus).find('input[autofocus]').focus();
                }
            },
            //press F2 -> open popup
            F2: function (name, code) {
                if (vm.data.showButtonNew) {
                    var d = new Date();
                    vm.data.objThongTin.Thang = d.getMonth() + 1 + '';
                    vm.data.objThongTin.Nam = d.getFullYear() + '';
                    $('#KhoTonKhoEditPopup').collapse('show');
                    $rootScope.isOpenPopup = true;
                }
            },

            //press F3 -> run Quick search
            F3: function (name, code) {
                if (!$rootScope.isOpenPopup) {
                    $("#txtsearch").focus();
                    getPage();
                }
            },

            //press F8 -> search
            F8: function (name, code) {
                if (!$rootScope.isOpenPopup) {
                    return;
                }
            }
        };
        //end HOT-KEY
        var _tableState = {};
        vm.data = {
            userInfo: {},
            showButtonNew: false,
            showButtonXoaChon: false,
            listQuyenTacVu: [],
            KhoTonKhoList: [],
            KhoTonKhoSelected: [],
            RowChecked: true,
            isLoading: false,
            searchString: '',
            objThongTin: [],
        };
        vm.action = {
            alert: alert,
            add: add,
            getPage: getPage,
            deleteSelected: deleteSelected,
            DongY: DongY,
            close: close
        };
        activate();
        vm.onInitView = onInitView;
        function activate() {
            eventAutoReload();
        }
        function onInitView(config) {
            if (config && config.userInfo) {
                vm.data.listQuyenTacVu = config.userInfo.DsQuyenTacVu.split(',');
                vm.data.userInfo = config.userInfo;
                setEnableButton();
            }
        }
        function setEnableButton() {
            if (vm.data.listQuyenTacVu.length > 0) {

                // Co quyen them moi
                if (vm.data.listQuyenTacVu.indexOf("N") > 0) {
                    vm.data.showButtonNew = true;
                }

                // Co quyen Xoa
                if (vm.data.listQuyenTacVu.indexOf("D") > 0) {
                    vm.data.showButtonXoaChon = true;
                }

                // Co quyen Sua
                if (vm.data.listQuyenTacVu.indexOf("M") > 0) {

                }
            }
        }
        function eventAutoReload() {
            $scope.$on('sa.qltsmain.KhoTonKho.KhoTonKho.reload', function (event) {
                getPage(_tableState);
            });
        }
        function deleteSelected() {
            if (!confirm('Bạn có muốn xóa các mục đã chọn không?')) { return; }

            vm.data.isLoading = true;

            var KhoTonKhoSelected = new Array();

            for (var i = 0; i < vm.data.KhoTonKhoList.length; i++) {
                var KhoTonKho = vm.data.KhoTonKhoList[i];
                if (KhoTonKho.isSelected) {
                    KhoTonKhoSelected.push(KhoTonKho.MuaSamId);
                }
            }
            var ids = KhoTonKhoSelected.join(',');
            if (ids.length > 0) {
                KhoTonKhoService.removeList(ids).then(function (success) {
                    vm.data.isLoading = false;
                    _tableState.pagination.start = 0;
                    getPage(_tableState);
                    alert('Xóa thành công!')
                }, function (error) {
                    vm.data.isLoading = false;
                    alert(error.data.error.code + " : " + error.data.error.message);
                });

            } else {
                alert('Vui lòng đánh dấu chọn vào ô trước khi tiếp tục.');
            }



        }
        function CheckRow() {
            for (var i = 0; i < vm.data.KhoTonKhoList.length; i++) {
                var KhoTonKho = vm.data.KhoTonKhoList[i];
                if (KhoTonKho.DuyetId != 0 && KhoTonKho.isSelected) {
                    vm.data.RowChecked = false;
                    return;
                }
            }
            vm.data.RowChecked = true;
        }
        function getPage(tableState) {
            vm.data.isLoading = true;

            if (tableState) {
                _tableState = tableState;
            }
            else if (_tableState) {
                tableState = _tableState;
            }
            else {
                tableState = initTableState(tableState);
                _tableState = tableState;
            }
            utility.addloadding($('body'));
            tableState.draw = tableState.draw + 1 || 1;
            var draw = tableState.draw;
            var start = tableState.pagination.start || 0;     // This is NOT the page number, but the index of item in the list that you want to use to display the table.
            var number = tableState.pagination.number || 10;  // Number of entries showed per page.
            var sortName = tableState.sort.predicate || 'Nam';
            var sortDir = tableState.sort.reverse ? 'asc' : 'desc';
            var searchString = vm.data.searchString;
            var CoSoId = vm.data.userInfo.CoSoId;
            var NhanVienId = vm.data.userInfo.NhanVienId;
            KhoTonKhoService.getPage(draw, start, number, searchString, sortName, sortDir, CoSoId, NhanVienId).then(function (success) {
                if (success.data.data) {
                    $('#bgloadding').remove();
                    vm.data.KhoTonKhoList = success.data.data;
                    tableState.pagination.numberOfPages = Math.ceil(success.data.metaData.total / number);
                }
                vm.data.isLoading = false;
            }, function (error) {
                vm.data.isLoading = false;
                if (error.data.error != null) {
                    alert(error.data.error.message);
                } else {
                    alert(error.data.Message);
                }
                $('#bgloadding').remove();
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
        function add() {
            var d = new Date();
            vm.data.objThongTin.Thang = d.getMonth() + 1 + '';
            vm.data.objThongTin.Nam = d.getFullYear() + '';
            $('#KhoTonKhoEditPopup').collapse('show');
            $rootScope.isOpenPopup = true;
        }
        function close() {
            $('#KhoTonKhoEditPopup').collapse('hide');
            $rootScope.isOpenPopup = true;
        }
        function DongY() {
            var thangnam = pad(vm.data.objThongTin.Thang, 2) + vm.data.objThongTin.Nam.substring(2, 4);
            var Kho = vm.data.objThongTin.KhoTaiSanId;
            if(Kho)
            {
                window.location = '/QLTSMAIN/KhoTonKho/edit/' + thangnam + '-' + Kho;
            }
            else {
                utility.AlertError('Vui lòng chọn kho !');
            }
        }
        function clearArray(array) {
            while (array.length) { array.pop(); }
        }
        function pad(str, max) {
            str = str.toString();
            return str.length < max ? pad("0" + str, max) : str;
        }
    }
})();