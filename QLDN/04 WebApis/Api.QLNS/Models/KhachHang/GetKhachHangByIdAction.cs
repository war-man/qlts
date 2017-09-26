﻿using SongAn.QLDN.Biz.QLNS.KhachHang;
using SongAn.QLDN.Data.Repository.MSSQL_QLDN_QLNS;
using SongAn.QLDN.Util.Common.Dto;
using SongAn.QLDN.Util.Common.Helper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
namespace SongAn.QLDN.Api.QLNS.Models.KhachHang
{
    public class GetKhachHangByIdAction
    {
        public string KhachHangId { get; set; }

        public async Task<ActionResultDto> Execute(ContextDto context)
        {
            var _result = new ActionResultDto();
            try
            {
                /* kiểm tra input */
                var _error = validate();

                if (_error.code > 0)
                {
                    return returnActionError(HttpStatusCode.BadRequest, _error.message);
                }

                /* convert input */
                var _KhachHangId = Protector.Int(KhachHangId);
                GetListKhachHangByCriteriaBiz biz = new GetListKhachHangByCriteriaBiz(context);
                biz.KhachHang = KhachHangId;
                biz.FieldsField = "KhachHangId,A.Ma,A.Ten,A.Loai,A.DienThoai,A.DiDong,A.Email,A.TinhThanhPhoId,B.TenTT,A.QuanHuyenId,C.TenQuanHuyen,A.PhuongXaId,D.TenPhuongXa,A.DiaChi,A.AnyDesk,A.CtrVersion";
                biz.OrderClause = "A.KhachHangId asc";
                var KhachHang = await biz.Execute();

                if (KhachHang == null)
                {
                    return returnActionError(HttpStatusCode.BadRequest, string.Format("Không tìm thấy KhachHangId '{0}'", _KhachHangId));
                }

                _result.ReturnCode = HttpStatusCode.OK;
                _result.ReturnData = new
                {
                    data = KhachHang
                };

                return _result;
            }
            catch (Exception ex)
            {
                return returnActionError(HttpStatusCode.InternalServerError, ex.InnerException != null ? ex.InnerException.Message : ex.Message);
            }
        }

        private ActionResultDto returnActionError(HttpStatusCode code, string message)
        {
            var _error = new ActionResultDto();
            _error.ReturnCode = code;
            _error.ReturnData = new
            {
                error = new
                {
                    code = code,
                    type = code.ToString(),
                    message = message
                }
            };
            return _error;
        }

        private dynamic validate()
        {
            dynamic _error = new System.Dynamic.ExpandoObject();

            _error.code = 0;
            _error.message = string.Empty;

            var _KhachHangId = Protector.Int(KhachHangId);

            if (_error.code == 0 && _KhachHangId < 1)
            {
                _error.code = 1;
                _error.message = "KhachHangId is empty";
            }

            return _error;
        }
    }
}