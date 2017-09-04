﻿using System.Threading.Tasks;
using System;
using System.Net;
using SongAn.QLTS.Util.Common.Dto;
using SongAn.QLTS.Data.Repository.QLTS;
using SongAn.QLTS.Util.Common.Helper;

namespace SongAn.QLTS.Api.QLTS.Models.CoSo
{
    public class UpdateCoSoAction : SongAn.QLTS.Entity.QLTS.Entity.CoSo
    {
        private int _CoSoId;
        private int _CtrVersion;
        public async Task<dynamic> Execute(ContextDto context)
        {
            try
            {
                dynamic result = new System.Dynamic.ExpandoObject();

                var repo = new CoSoRepository(context);
                await repo.UpdatePartial(this,
                    nameof(MaCoSo),
                    nameof(TenCoSo),
                    nameof(LoaiCoSoId),
                    nameof(TrucThuoc),
                    nameof(DienThoai),
                    nameof(DiaChi),
                    nameof(GhiChu)
                     );
                result.data = this;
                return returnActionResult(HttpStatusCode.OK, result.data, null);
            }
            catch (FormatException ex)
            {
                return returnActionError(HttpStatusCode.BadRequest, ex.Message);
            }
            catch (Exception ex)
            {
                return returnActionError(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        private void validate()
        {
            var _id = Protector.Int(CoSoId);

            if (_id < 1)
            {
                throw new FormatException("CoSoId is empty");
            }
        }

        private void init()
        {
            _CoSoId = Protector.Int(CoSoId);
            _CtrVersion = Protector.Int(CtrVersion);
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
    }
}
