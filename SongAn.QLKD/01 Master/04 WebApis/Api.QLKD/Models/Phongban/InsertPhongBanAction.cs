﻿using SongAn.QLKD.Entity.QLKD.Entity;
using SongAn.QLKD.Util.Common.Dto;
using SongAn.QLKD.Data.Repository.MSSQL_QLKD;
using System.Threading.Tasks;
using System;
using System.Net;

namespace  SongAn.QLKD.Api.QLKD.Models.Phongban
{
    public class InsertPhongBanAction : SongAn.QLKD.Entity.QLKD.Entity.PhongBan
    {

        #region public
        /*public string MaPhongBan { get; set; }
        public string TenPhongBan { get; set; }
        public string GhiChu { get; set; } */
        #endregion

        public async Task<ActionResultDto> Execute(ContextDto context)
        {
            try
            {
                validate();

                var phongban = new Entity.QLKD.Entity.PhongBan();
                phongban.MaPhongBan = MaPhongBan;
                phongban.TenPhongBan = TenPhongBan;
                phongban.GhiChu = GhiChu;


                PhongBanRepository repo = new PhongBanRepository(context);
                await repo.Insert(phongban);

                return returnActionResult(HttpStatusCode.OK, phongban, null);
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

        private void init() { }

        private void validate()
        {
            if (string.IsNullOrEmpty(MaPhongBan))
            {
                throw new FormatException("MaPhongBan không hợp lệ");
            }
            if (string.IsNullOrEmpty(TenPhongBan))
            {
                throw new FormatException("MaPhongBan không hợp lệ");
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
