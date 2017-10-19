﻿using SongAn.QLTS.Util.Common.Dto;
using SongAn.QLTS.Util.Common.Helper;
using System;
using System.Collections.Generic;
using System.Net;
using System.Threading.Tasks;
using System.Linq;
using SongAn.QLTS.Biz.QLTS.DuyetBaoCao;
using SongAn.QLTS.Data.Repository.QLTS;
using System.Globalization;

namespace SongAn.QLTS.Api.QLTS.Models.DuyetBaoCao
{
    public class GetListDuyetBaoCaoByProjectionAction
    {
        public string draw { get; set; }
        public string start { get; set; }
        public string length { get; set; }
        public string search { get; set; }
        public string sortName { get; set; }
        public string sortDir { get; set; }
        public string CoSoId { get; set; }
        public string SoPhieu { get; set; }
        public string TuNgay { get; set; }
        public string DenNgay { get; set; }
        public string PhongBanId { get; set; }
        public string NhanVienId { get; set; }
        public string DuyetId { get; set; }
        public async Task<ActionResultDto> Execute(ContextDto context)
        {
            GetListDuyetBaoCaoByCriteriaBiz biz = new GetListDuyetBaoCaoByCriteriaBiz(context);
            var result = new ActionResultDto();
            try
            {
                var _draw = Protector.Int(draw);
                var _start = Protector.Int(start);
                var _length = Protector.Int(length);

                /* =========================
                 * fixed input
                 * ========================= */
                sortName = string.IsNullOrEmpty(sortName) ? "DeNghiId" : sortName;
                sortDir = string.IsNullOrEmpty(sortDir) ? "asc" : sortDir;
                _length = _length < 1 ? 10 : _length;
                var orderClause = sortName + " " + sortDir;
                var total = 0;
                biz.Search = search;
                biz.OrderClause = orderClause;
                biz.Skip = _start;
                biz.Take = _length;
                biz.CoSoId = Protector.Int(CoSoId);
                biz.SoPhieu = Protector.String(SoPhieu);
                biz.TuNgay = DateTime.ParseExact(TuNgay, "dd/MM/yyyy", CultureInfo.GetCultureInfo("fr-FR"));
                biz.DenNgay = DateTime.ParseExact(DenNgay, "dd/MM/yyyy", CultureInfo.GetCultureInfo("fr-FR"));
                biz.PhongBanId = Protector.String(PhongBanId);
                biz.LoginId = Protector.Int(NhanVienId);
                biz.DuyetId = DuyetId;
                IEnumerable<dynamic> listDeNghi = await biz.Execute();
                if (listDeNghi.Count() > 0)
                {
                    var obj = listDeNghi.FirstOrDefault();

                    total = Protector.Int(obj.MAXCNT);
                }

                dynamic _metaData = new System.Dynamic.ExpandoObject();
                _metaData.draw = _draw;
                _metaData.total = total;

                return ActionHelper.returnActionResult(HttpStatusCode.OK, listDeNghi, _metaData);
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