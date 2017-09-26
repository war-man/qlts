﻿using SongAn.QLDN.Entity.MSSQL_QLDN_QLNS.Entity;
using SongAn.QLDN.Util.Common.Dto;
using SongAn.QLDN.Util.Common.Helper;
using SongAn.QLDN.Data.Repository.MSSQL_QLDN_QLNS;
using System;
using System.Net;
using System.Threading.Tasks;

namespace SongAn.QLDN.Api.QLKho.Models.KhoKiemKe
{
    public class GetKhoKiemKeByIdAction
    {
        public string KhoKiemKeId { get; set; }
        public string MaKhoKiemKe { get; set; }

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
                
                Data.QLKho.KhoKiemKe.GetListKhoKiemKeByIdDac dac = new Data.QLKho.KhoKiemKe.GetListKhoKiemKeByIdDac(context);
                dac.KiemKeId = KhoKiemKeId;
                var KhoKiemKe = await dac.Execute();
                if (KhoKiemKe == null)
                {
                    return returnActionError(HttpStatusCode.BadRequest, string.Format("Không tìm thấy KhoKiemKeId '{0}'", KhoKiemKeId));
                }

                _result.ReturnCode = HttpStatusCode.OK;
                _result.ReturnData = new
                {
                    data = KhoKiemKe
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

            var _KhoKiemKeId = Protector.Int(KhoKiemKeId);

            if (_error.code == 0 && _KhoKiemKeId < 1)
            {
                _error.code = 1;
                _error.message = "KhoKiemKeId is empty";
            }

            return _error;
        }
    }
}