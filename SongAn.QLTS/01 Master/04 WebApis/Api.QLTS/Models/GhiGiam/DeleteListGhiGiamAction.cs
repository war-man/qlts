﻿using SongAn.QLTS.Biz.QLTS.GhiGiam;
using SongAn.QLTS.Biz.QLTS.GhiGiamChiTiet;
using SongAn.QLTS.Data.Repository.QLTS;
using SongAn.QLTS.Util.Common.Dto;
using SongAn.QLTS.Util.Common.Helper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace SongAn.QLTS.Api.QLTS.Models.GhiGiam
{
    public class DeleteListGhiGiamAction
    {
        public string ids { get; set; }
        #region private
        private List<int> _listId;
        #endregion

        public async Task<ActionResultDto> Execute(ContextDto context)
        {
            try
            {
                init();
                validate();
                var count = 1;
                var repo = new GhiGiamRepository(context);
                var biz = new DeleteGhiGiamByIdBiz(context);
                for (int i = 0; i < _listId.Count; i++)
                {
                    GetGhiGiamChiTietByGhiGiamIdBiz bizct = new GetGhiGiamChiTietByGhiGiamIdBiz(context);
                    bizct.GhiGiamId = _listId[i].ToString();
                    IEnumerable<dynamic> GhiGiamChiTiet = await bizct.Execute();
                    foreach (var item in GhiGiamChiTiet)
                    {
                        Biz.QLTS.GhiGiamChiTiet.DeleteGhiGiamChiTietBiz dbizct = new Biz.QLTS.GhiGiamChiTiet.DeleteGhiGiamChiTietBiz(context);
                        dbizct.GhiGiamChiTietId = item.GhiGiamChiTietId;
                        dbizct.TaiSanId = item.TaiSanId;
                        dbizct.PhongBanId = item.PhongBanId;
                        dbizct.NhanVienId = item.NhanVienId;
                        dbizct.SoLuong = item.SoLuong;
                        await dbizct.Execute();
                    }
                    biz.GhiGiamId = _listId[i].ToString();
                    var GhiGiam = await biz.Execute();
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
            _listId = new List<int>();

            for (int i = 0; i < _ids.Length; i++)
            {
                _listId.Add(Protector.Int(_ids[i]));
            }
        }

        private void validate()
        {
            for (int i = 0; i < _listId.Count; i++)
            {
                if (_listId[i] < 1)
                {
                    throw new FormatException("GhiGiamId không hợp lệ");
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