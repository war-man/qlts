﻿using SongAn.QLTS.Biz.QLTS.TraCuuTaiSan;
using SongAn.QLTS.Util.Common.Dto;
using SongAn.QLTS.Util.Common.Helper;
using System;
using System.Linq;
using System.Net;
using System.Threading.Tasks;

namespace SongAn.QLTS.Api.QLTS.Models.TraCuuTaiSan
{
    public class LuocSuAction
    {
        public string NhanVienId { get; set; }
        public string PhongBanId { get; set; }
        public string TaiSanId { get; set; }
        public string NHANVIEN_ID { get; set; }
        public string COSO_ID { get; set; }

        #region private
        #endregion

        private void init() { }

        private void validate() { }


        public async Task<ActionResultDto> Execute(ContextDto context)
        {
            try
            {
                init();
                validate();


                var biz = new LuocSuBiz(context);
                biz.NHANVIENID = Protector.Int(NhanVienId, 0);
                biz.TAISANID = Protector.Int(TaiSanId, 0);
                biz.PHONGBANID = Protector.Int(PhongBanId, 0);
                biz.NHANVIEN_ID = Protector.Int(NHANVIEN_ID, 0);
                biz.COSO_ID = Protector.Int(COSO_ID, 0);

                var result = await biz.Execute();

                dynamic _metaData = new System.Dynamic.ExpandoObject();

                return ActionHelper.returnActionResult(HttpStatusCode.OK, result, _metaData);
            }
            catch (FormatException ex)
            {
                return returnActionError(HttpStatusCode.BadRequest, ex.InnerException != null ? ex.InnerException.Message : ex.Message);
            }
            catch (Exception ex)
            {
                return returnActionError(HttpStatusCode.InternalServerError, ex.InnerException != null ? ex.InnerException.Message : ex.Message);
            }
        }
        #region helpers
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

        private ActionResultDto returnActionResult(HttpStatusCode code, object data, object metaData)
        {
            var _result = new ActionResultDto();

            _result.ReturnCode = code;
            _result.ReturnData = new
            {
                data = data,
                metaData = metaData
            };
            return _result;
        }
        #endregion
    }
}