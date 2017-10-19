﻿(function () {
    'use strict';

    angular.module("app")
        .controller("DuyetBaoCaoListCtrl", controller)
        .directive("keyboard", keyboard);        //HOT-KEY

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

    function controller($rootScope, $scope, DuyetBaoCaoService, utility, $q) {
        var vm = this;

        $rootScope.isOpenPopupTimKiem = false;
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


            //press F3 -> run Quick search
            F3: function (name, code) {
                if (!$rootScope.isOpenPopupTimKiem) {
                    $('#SearchCollapse').collapse('show');
                    $rootScope.isOpenPopupTimKiem = true;
                } else {
                    $('#SearchCollapse').collapse('hide');
                    $rootScope.isOpenPopupTimKiem = false;
                }
            },

            ////press F8 -> search
            //F8: function (name, code) {
            //    if (!$rootScope.isOpenPopup) {
            //        return;
            //    }
            //}
        };
        //end HOT-KEY
        var _tableState = {};
        vm.data = {
            userInfo: {},
            showButtonDuyet: false,
            RowChecked: true,
            listQuyenTacVu: [],
            DuyetBaoCaoListDisplay: [],
            DuyetBaoCaoChiTietListDisplay: [],
            DuyetBaoCaoSelected: [],
            isLoading: false,
            TongSo: 0,
            searchString: '',
            PhongBanIds: '',
            TuNgay: '',
            DenNgay: '',
            DuyetId: '0',
            linkUrl: '',
            listCot: [],
            objTuChoi: {},
            objTuChoiChiTiet: {}
        };

        vm.action = {
            getPage: getPage,
            getPageDetail: getPageDetail,
            GetPageByDuyetId: GetPageByDuyetId,
            DongY: DongY,
            TuChoi: TuChoi,
            CheckRow: CheckRow,
            OpenTuChoi: OpenTuChoi,
            OpenTuChoiChiTiet: OpenTuChoiChiTiet,
            DongYChiTiet: DongYChiTiet,
            TuChoiChiTiet: TuChoiChiTiet,
            Close: Close,
            CloseChiTiet: CloseChiTiet,
            XemBaoCao: XemBaoCao
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

            if (config && config.linkUrl) {
                vm.data.linkUrl = config.linkUrl;
            }
            catchTuyChonCotPopupEvent();
        }
        function setEnableButton() {
            if (vm.data.listQuyenTacVu.length > 0) {

                // Co quyen duyet
                if (vm.data.listQuyenTacVu.indexOf("A") > 0) {
                    vm.data.showButtonDuyet = true;
                }

            }
        }
        function eventAutoReload() {
            $scope.$on('sa.qltsmain.DeNghi.DeNghi.reload', function (event) {
                getPage(_tableState);
            });

            $scope.$on('DuyetBaoCaoListCtrl.action.get-filter', function (event, data) {
                vm.data.PhongBanIds = data.boPhanId;
                vm.data.TuNgay = data.startDate;
                vm.data.DenNgay = data.endDate;
                getPage(_tableState);
            });


        }
        function catchTuyChonCotPopupEvent() {
            // nhân sự kiện áp dụng
            $rootScope.$on('TuyChonCotPopup' + '.action.ap-dung', function (event, data) {
                $('#' + 'TuyChonCotPopup').collapse('hide');
                _tableState.pagination.start = 0;
                getPage(_tableState);
            });

            $(document).ready(function () {
                $('#' + 'TuyChonCotPopup').on('show.bs.collapse', function () {
                    $rootScope.$broadcast('TuyChonCotPopup' + '.action.refresh');
                });
            });
        }
        function DongY() {

            var LapBaoCaoId = "";
            for (var i = 0; i < vm.data.DuyetBaoCaoListDisplay.length; i++) {
                var select = vm.data.DuyetBaoCaoListDisplay[i];
                if (select.isSelected) {
                    var LapBaoCaoId = select.LapBaoCaoId;
                }
            }
            if (LapBaoCaoId == "") {
                utility.AlertError('Vui lòng chọn phiếu đề nghị trang cấp để duyệt !');
                return;
            }
            if (!confirm('Bạn đồng ý duyệt các báo cáo đã chọn?')) {
                return;
            }
            var DuyetId = 1;
            var NgayDuyet = moment().format('DD/MM/YYYY');
            var NguoiDuyet = vm.data.userInfo.NhanVienId;
            var NoiDungDuyet = "";
            addloadding($('body'));
            DuyetBaoCaoService.Duyet(LapBaoCaoId, DuyetId, NgayDuyet, NguoiDuyet, NoiDungDuyet).then(function (success) {
                if (success.data.data) {
                    utility.AlertSuccess('Duyệt thành công');
                    $('#bgloadding').remove();
                    getPage();
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
        function OpenTuChoi() {
            var LapBaoCaoId = "";
            for (var i = 0; i < vm.data.DuyetBaoCaoListDisplay.length; i++) {
                var select = vm.data.DuyetBaoCaoListDisplay[i];
                if (select.isSelected) {
                    var LapBaoCaoId = select.LapBaoCaoId;
                }
            }
            if (LapBaoCaoId == "") {
                utility.AlertError('Vui lòng chọn báo cáo để duyệt !');
                return;
            }
            else {
                vm.data.objTuChoi.Ngay = moment().format('DD/MM/YYYY');
                $('#TuChoiPopup').collapse('show');
                $('#txtLyDo').focus();
            }
        }
        function OpenTuChoiChiTiet(item) {
            vm.data.objTuChoiChiTiet.Ngay = moment().format('DD/MM/YYYY');
            vm.data.objTuChoiChiTiet.LapBaoCaoId = item.LapBaoCaoId;
            vm.data.objTuChoiChiTiet.LapBaoCaoChiTietId = item.LapBaoCaoChiTietId;
            $('#TuChoiPopupChiTiet').collapse('show');
            $('#txtLyDoChiTiet').focus();
        }
        function TuChoi() {

            var LapBaoCaoId = "";
            for (var i = 0; i < vm.data.DuyetBaoCaoListDisplay.length; i++) {
                var select = vm.data.DuyetBaoCaoListDisplay[i];
                if (select.isSelected) {
                    var LapBaoCaoId = select.LapBaoCaoId;
                }
            }
            var DuyetId = 2;
            var NgayDuyet = vm.data.objTuChoi.Ngay;
            var NguoiDuyet = vm.data.userInfo.NhanVienId;
            var NoiDungDuyet = vm.data.objTuChoi.LyDo;
            addloadding($('body'));
            DuyetBaoCaoService.Duyet(LapBaoCaoId, DuyetId, NgayDuyet, NguoiDuyet, NoiDungDuyet).then(function (success) {
                if (success.data.data) {
                    utility.AlertSuccess('Duyệt thành công');
                    $('#bgloadding').remove();
                    $('#TuChoiPopup').collapse('hide');
                    vm.data.objTuChoi = {};
                    getPage();
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
        function DongYChiTiet(item) {
            if (!confirm('Bạn đồng ý duyệt báo cáo này?')) {
                return;
            }
            var DuyetId = 1;
            var LapBaoCaoId = item.LapBaoCaoId;
            var LapBaoCaoChiTietId = item.LapBaoCaoChiTietId;
            var NgayDuyet = moment().format('DD/MM/YYYY');
            var NoiDungDuyet = '';
            addloadding($('body'));
            DuyetBaoCaoService.DuyetChiTiet(LapBaoCaoId, LapBaoCaoChiTietId, NgayDuyet, NoiDungDuyet, DuyetId).then(function (success) {
                if (success.data.data) {
                    var DuyetId = success.data.data[0].DuyetId;
                    getPageDetail(item.LapBaoCaoId).then(function (success) {
                        if (DuyetId != 0)
                            $.each(vm.data.DuyetBaoCaoListDisplay, function (index, value) {
                                if (value.LapBaoCaoId == item.LapBaoCaoId) {
                                    vm.data.DuyetBaoCaoListDisplay[index].DuyetId = DuyetId;
                                    vm.data.DuyetBaoCaoListDisplay[index].TrangThai = DuyetId == 1 ? "Đồng ý" : "Từ chối";
                                }
                            });
                    });
                    $('#bgloadding').remove();
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
        function TuChoiChiTiet() {
            var DuyetId = 2;
            var LapBaoCaoId = vm.data.objTuChoiChiTiet.LapBaoCaoId;
            var LapBaoCaoChiTietId = vm.data.objTuChoiChiTiet.LapBaoCaoChiTietId;
            var NgayDuyet = vm.data.objTuChoiChiTiet.Ngay;
            var NoiDungDuyet = vm.data.objTuChoiChiTiet.LyDo;
            addloadding($('body'));
            DuyetBaoCaoService.DuyetChiTiet(LapBaoCaoId, LapBaoCaoChiTietId, NgayDuyet, NoiDungDuyet, DuyetId).then(function (success) {
                if (success.data.data) {
                    var DuyetId = success.data.data[0].DuyetId;
                    getPageDetail(LapBaoCaoId).then(function (success) {
                        if (DuyetId != 0)
                            $.each(vm.data.DuyetBaoCaoListDisplay, function (index, value) {
                                if (value.LapBaoCaoId == item.LapBaoCaoId) {
                                    vm.data.DuyetBaoCaoListDisplay[index].DuyetId = DuyetId;
                                    vm.data.DuyetBaoCaoListDisplay[index].TrangThai = DuyetId == 1 ? "Đồng ý" : "Từ chối";
                                }
                            });
                    });
                    $('#bgloadding').remove();
                    $('#TuChoiPopupChiTiet').collapse('hide');
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
        function CheckRow(check) {
            vm.data.RowChecked = check;
        }
        function Close() {
            vm.data.objTuChoi = {};
            $('#TuChoiPopup').collapse('hide');
        }
        function CloseChiTiet() {
            vm.data.objTuChoiChiTiet = {};
            $('#TuChoiPopupChiTiet').collapse('hide');
        }
        function addloadding(obj) {
            $(obj).append('<div id="bgloadding"><div class="windows8"><div class="wBall" id="wBall_1"><div class="wInnerBall"></div></div><div class="wBall" id="wBall_2"><div class="wInnerBall"></div></div><div class="wBall" id="wBall_3"><div class="wInnerBall"></div></div><div class="wBall" id="wBall_4"><div class="wInnerBall"></div></div><div class="wBall" id="wBall_5"><div class="wInnerBall"></div></div></div></div>');
        }
        function removeloadding(obj) {
            $('#bgloadding').remove();
        }

        function GetPageByDuyetId(DuyetId) {
            vm.data.DuyetId = DuyetId;
            getPage();
        }

        function getPage(tableState) {
            if (vm.data.TuNgay === '') {
                vm.data.TuNgay = $('#tungay').val();
                vm.data.DenNgay = $('#denngay').val();
            }
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
            addloadding($('body'));
            tableState.draw = tableState.draw + 1 || 1;
            var draw = tableState.draw;
            var start = tableState.pagination.start || 0;     // This is NOT the page number, but the index of item in the list that you want to use to display the table.
            var number = tableState.pagination.number || 10;  // Number of entries showed per page.
            var sortName = tableState.sort.predicate || 'LapBaoCaoId';
            var sortDir = tableState.sort.reverse ? 'desc' : 'asc';
            var searchString = vm.data.searchString;
            var CoSoId = vm.data.userInfo.CoSoId;
            var NhanVienId = vm.data.userInfo.NhanVienId;
            var TuNgay = vm.data.TuNgay;
            var DenNgay = vm.data.DenNgay;
            var PhongBanId = vm.data.PhongBanIds;
            var DuyetId = vm.data.DuyetId;
            var SoPhieu = "";

            DuyetBaoCaoService.getPage(draw, start, number, searchString, sortName, sortDir, CoSoId, NhanVienId, TuNgay, DenNgay, PhongBanId, SoPhieu, DuyetId).then(function (success) {
                if (success.data.data) {
                    $('#bgloadding').remove();
                    vm.data.DuyetBaoCaoListDisplay = success.data.data;
                    vm.data.DuyetBaoCaoChiTietListDisplay = [];
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

        function getPageDetail(LapBaoCaoId) {
            var deferred = $q.defer();
            $('tr').removeClass('info');
            $('#row_' + LapBaoCaoId).addClass('info');
            if (LapBaoCaoId && LapBaoCaoId > 0) {
                DuyetBaoCaoService.GetPageDetail(LapBaoCaoId).then(function (success) {
                    if (success.data.data) {
                        $('#bgloadding').remove();
                        vm.data.DuyetBaoCaoChiTietListDisplay = success.data.data;
                        vm.data.TongSo = success.data.data.length;
                    }
                    return deferred.resolve(success);
                    vm.data.isLoading = false;
                }, function (error) {
                    vm.data.isLoading = false;
                    if (error.data.error != null) {
                        alert(error.data.error.message);
                    } else {
                        alert(error.data.Message);
                    }
                    $('#bgloadding').remove();
                    return deferred.reject(error);
                });
            }
            return deferred.promise;
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

        function clearArray(array) {
            while (array.length) { array.pop(); }
        }
        function XemBaoCao(value) {
            var tuNgay = value.TuNgay;
            var denNgay = value.DenNgay;
            var bieumau = value.Report;
            var CoSoId = vm.data.userInfo.CoSoId || 0;
            var NhanVienId = vm.data.userInfo.NhanVienId || 0;

            var data = '|' + tuNgay + '|' + denNgay + '|' + CoSoId + '|' + NhanVienId;

            $('#reportmodal').find('iframe').attr('src', '../../../QLTSMAIN/CrystalReport/ReportPage.aspx?name=' + bieumau + '&data=' + data);
            $('#reportmodal').modal('show');
        }

    }
})();