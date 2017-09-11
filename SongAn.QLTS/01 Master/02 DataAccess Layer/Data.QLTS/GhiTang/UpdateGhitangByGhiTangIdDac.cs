﻿using Dapper;
using Dapper.FastCrud;
using SongAn.QLTS.Util.Common.Dto;
using SongAn.QLTS.Util.Common.Repository;
using System;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace SongAn.QLTS.Data.QLNS.GhiTang
{
    public class UpdateGhiTangByGhiTangIdDac :BaseRepositoryAsync
    {
        #region public properties

        public int GhiTangId { get; set; }
        public string SoChungTu { get; set; }
        public DateTime NgayChungTu { get; set; }
        public DateTime NgayGhiTang { get; set; }
        public string NoiDung { get; set; }
        public int CoSoId { get; set; }
        public int NhanVienId { get; set; }
        public int CompareLine { get; set; }

        #endregion

        #region private variable

        ContextDto _context;

        #endregion

        #region constructor
        /// <summary>
        /// Ham khoi tao, chi nhan vao bien moi truong va goi lop base
        /// </summary>
        /// <param name="context"></param>
        public UpdateGhiTangByGhiTangIdDac(ContextDto context) : base(context.dbQLTSConnection)
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
                p.Add("GhiTangId", GhiTangId, DbType.Int32);
                p.Add("SoChungTu", SoChungTu, DbType.String);
                p.Add("NgayChungTu", NgayChungTu, DbType.DateTime);
                p.Add("NgayGhiTang", NgayGhiTang, DbType.DateTime);
                p.Add("NoiDung", NoiDung, DbType.String);
                p.Add("CoSoId", CoSoId, DbType.Int32);
                p.Add("NhanVienId", NhanVienId, DbType.Int32);
                p.Add("CompareLine", CompareLine, DbType.Int32);

                var objResult = await c.QueryAsync<dynamic>(
                    sql: "sp_GhiTang_UpdateGhiTang",
                    param: p,
                    commandType: CommandType.StoredProcedure);

                return objResult;
            });
        }

        #endregion
    }
}
