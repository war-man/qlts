﻿using Dapper;
using Dapper.FastCrud;
using SongAn.QLTS.Util.Common.Dto;
using SongAn.QLTS.Util.Common.Repository;
using System;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace SongAn.QLTS.Data.QLTS.DeNghiTrangCap
{
    public class InsertDeNghiTrangCapDac : BaseRepositoryAsync
    {
        #region public properties

        public DateTime NgayLap { get; set; }
        public string SoPhieu { get; set; }
        public int PhanLoaiId { get; set; }
        public int PhongBanId { get; set; }
        public string NoiDung { get; set; }
        public int CoSoId { get; set; }
        public int NhanVienId { get; set; }
        public int GuiCapTren { get; set; }
        #endregion

        #region private variable

        ContextDto _context;

        #endregion

        #region constructor
        /// <summary>
        /// Ham khoi tao, chi nhan vao bien moi truong va goi lop base
        /// </summary>
        /// <param name="context"></param>
        public InsertDeNghiTrangCapDac(ContextDto context) : base(context.dbQLTSConnection)
        {
            OrmConfiguration.DefaultDialect = SqlDialect.MsSql;

            _context = context;
        }
        #endregion

        #region init & validate
        /// <summary>
        /// Ham khoi tao gia tri mac dinh cho cac bien
        /// </summary>
        private void Init()
        {

        }

        /// <summary>
        /// Ham chuan hoa gia tri cac bien
        /// </summary>
        private void Validate()
        {

        }

        #endregion

        #region execute

        /// <summary>
        /// Ham xu ly chinh, chi nhan 1 bien moi truong
        /// </summary>
        /// <param name="context">Bien moi truong</param>
        /// <returns></returns>
        public virtual async Task<IEnumerable<dynamic>> Execute()
        {
            Init();
            Validate();

            return await WithConnection(async c =>
            {
                var p = new DynamicParameters();
                p.Add("NgayLap", NgayLap, DbType.DateTime);
                p.Add("SoPhieu", SoPhieu, DbType.String);
                p.Add("PhanLoaiId", PhanLoaiId, DbType.Int32);
                p.Add("PhongBanId", PhongBanId, DbType.Int32);
                p.Add("NoiDung", NoiDung, DbType.String);
                p.Add("CoSoId", CoSoId, DbType.Int32);
                p.Add("NhanVienId", NhanVienId, DbType.Int32);
                p.Add("GuiCapTren", GuiCapTren, DbType.Int32);
                var objResult = await c.QueryAsync<dynamic>(
                    sql: "sp_DeNghiTrangCap_InsertDeNghiTrangCap",
                    param: p,
                    commandType: CommandType.StoredProcedure);

                return objResult;
            });
        }

        #endregion
    }
}
