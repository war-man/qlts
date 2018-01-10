﻿using SongAn.QLKD.Util.Common.Dto;
using SongAn.QLKD.Util.Common.Helper;
using System;
using System.Collections.Generic;
using System.Net;
using System.Threading.Tasks;
using System.Linq;
using SongAn.QLKD.Biz.QLKD.NhomHangHoa;

namespace SongAn.QLKD.Api.QLKD.Models.NhomHangHoa
{
    public class GetListcbxNhomHangHoaByIdAction
    {
        public string Search { get; set; }
        public string UserId { get; set; }
        public string NhanVienId { get; set; }
        public string NhomHangHoaId { get; set; }
        public string MaNhomHangHoa { get; set; }
        public string FunctionCode { get; set; }
        public async Task<ActionResultDto> Execute(ContextDto context)
        {
            GetListcbxNhomHangHoaByIdBiz biz = new GetListcbxNhomHangHoaByIdBiz(context);
            var result = new ActionResultDto();
            try
            {
                biz.Search = Search;
                biz.FunctionCode = FunctionCode;
                biz.NhanVienId = Protector.String(NhanVienId);
                biz.NhomHangHoaId = Protector.Int(NhomHangHoaId);
                biz.MaNhomHangHoa = Protector.String(MaNhomHangHoa);
                biz.UserId = Protector.String(UserId);

                IEnumerable<dynamic> listNhomHangHoa = await biz.Execute();
                dynamic _metaData = new System.Dynamic.ExpandoObject();
                return ActionHelper.returnActionResult(HttpStatusCode.OK, listNhomHangHoa, _metaData);
            }
            catch (Exception ex)
            {
                result.ReturnCode = HttpStatusCode.InternalServerError;
                result.ReturnData = new
                {
                    error = new
                    {
                        code = HttpStatusCode.InternalServerError,
                        type = HttpStatusCode.InternalServerError.ToString(),
                        message = ex.InnerException != null ? ex.InnerException.Message : ex.Message
                    }
                };
                return result;
            }

        }
    }
}
