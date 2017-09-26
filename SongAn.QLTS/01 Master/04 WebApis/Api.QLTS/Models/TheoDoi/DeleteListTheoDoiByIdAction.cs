﻿using SongAn.QLTS.Util.Common.Dto;
using SongAn.QLTS.Util.Common.Helper;
using System;
using System.Collections.Generic;
using System.Net;
using System.Threading.Tasks;
using System.Linq;
using SongAn.QLTS.Biz.QLTS.TheoDoi;
using SongAn.QLTS.Data.Repository.QLTS;
using System.Globalization;
using Newtonsoft.Json;

namespace SongAn.QLTS.Api.QLTS.Models.TheoDoi
{
    public class DeleteListTheoDoiByIdAction
    {
        public string ids { get; set; }
        #region private
        private List<string> _listId;
        #endregion

        public async Task<ActionResultDto> Execute(ContextDto context)
        {
            try
            {
                init();
                validate();
                var count = 0;  // 0: xoa thanh cong, !=0 số phiếu ko xóa dc

                var biz = new DeleteListTheoDoiByIdBiz(context);
                for (int i = 0; i < _listId.Count; i++)
                {
                    //0: tai san 1: phong ban 2: nhan vien

                    biz.TaiSanId = Protector.Int(_listId[i].Split('_')[0]);
                    biz.PhongBanId = Protector.Int(_listId[i].Split('_')[1]);
                    biz.NhanVienId = Protector.Int(_listId[i].Split('_')[2]);

                    IEnumerable<dynamic> result = await biz.Execute();
                    if (result.Count() > 0)
                    {
                        var obj = result.FirstOrDefault();
                        if (Protector.Int(obj.ID) < 0) // -1: âm, -2: not exists
                        {
                            count = count + 1;
                        }
                    }

                }
                return returnActionResult(HttpStatusCode.OK, count, null);
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
            var _ids = ids.Split(',');
            _listId = new List<string>();

            for (int i = 0; i < _ids.Length; i++)
            {
                _listId.Add(Protector.String(_ids[i]));
            }
        }

        private void validate()
        {
            for (int i = 0; i < _listId.Count; i++)
            {
                if (Protector.Int(_listId[i].Split('_')[0]) < 1 || 
                    Protector.Int(_listId[i].Split('_')[1]) < 1 ||
                    Protector.Int(_listId[i].Split('_')[2]) < 1)
                {
                    throw new FormatException("ID không hợp lệ");
                }
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