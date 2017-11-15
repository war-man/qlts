﻿using Newtonsoft.Json;
using SongAn.QLKD.Biz.QLKD.NhomKhachHang;
using SongAn.QLKD.Util.Common.Dto;
using SongAn.QLKD.Util.Common.Helper;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace SongAn.QLKD.Api.QLKD.Models.NhomKhachHang
{
    public class UpdateNhomKhachHangByIdAction
    {
        #region public
        public string nhomKhachHang { get; set; }
        public string userId { get; set; }
        #endregion

        #region private
        private Entity.QLKD.Entity.KDNhomKhachHang _nhomKhachHang;
        #endregion

        public async Task<ActionResultDto> Execute(ContextDto context)
        {
            try
            {
                init();
                validate();

                if (_nhomKhachHang.NhomKhachHangId < 1)
                {
                    return returnActionError(HttpStatusCode.BadRequest, "Không tìm thấy NhomKhachHangId");
                }

                var bizKhachHang = new UpdateNhomKhachHangByIdBiz(context);

                bizKhachHang.NhomKhachHangId = Protector.Int(_nhomKhachHang.NhomKhachHangId);
                bizKhachHang.MaNhom = Protector.String(_nhomKhachHang.MaNhom);
                bizKhachHang.TenNhom = Protector.String(_nhomKhachHang.TenNhom);
                bizKhachHang.NguoiTao = Protector.Int(_nhomKhachHang.NguoiTao);
                bizKhachHang.UserId = Protector.String(userId);


                IEnumerable<dynamic> NhomKhachHangIdINum = await bizKhachHang.Execute();


                return returnActionResult(HttpStatusCode.OK, NhomKhachHangIdINum, null);
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

        private void init()
        {
            var __nhomKhachHang = JsonConvert.DeserializeObject<dynamic>(nhomKhachHang);
            __nhomKhachHang.NgayTao = DateTime.ParseExact(__nhomKhachHang.NgayTao.ToString(), "dd/MM/yyyy", CultureInfo.GetCultureInfo("fr-FR")).ToString("yyyy-MM-dd");
            nhomKhachHang = JsonConvert.SerializeObject(__nhomKhachHang);
            _nhomKhachHang = JsonConvert.DeserializeObject<Entity.QLKD.Entity.KDNhomKhachHang>(nhomKhachHang);
        }

        private void validate()
        {
            var _id = Protector.Int(_nhomKhachHang.NhomKhachHangId);

            if (_id < 1)
            {
                throw new FormatException("NhomKhachHangId is empty");
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
