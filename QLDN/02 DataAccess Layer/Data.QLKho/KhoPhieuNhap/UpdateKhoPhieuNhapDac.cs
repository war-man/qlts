﻿/*****************************************************************************
1. Create Date  : 2017.06.20
2. Creator      : NGUYỄN THANH BÌNH
3. Function     : 
4. Description  : UPDATE THÔNG TIN PHIẾU NHẬP
5. History      : 2017.06.20 (NGUYỄN THANH BÌNH) - Tao moi
*****************************************************************************/
using Dapper;
using Dapper.FastCrud;
using SongAn.QLDN.Data.QLKho.KhoPhieuNhap.Dto;
using SongAn.QLDN.Util.Common.Dto;
using SongAn.QLDN.Util.Common.Repository;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace SongAn.QLDN.Data.QLKho.KhoPhieuNhap
{
    public class UpdateKhoPhieuNhapDac : BaseRepositoryAsync
    {
        #region public properties
        public UpdateKhoPhieuNhapDto PhieuNhap { get; set; }
        #endregion

        #region private variable

        ContextDto _context;

        #endregion

        #region constructor
        /// <summary>
        /// Ham khoi tao, chi nhan vao bien moi truong va goi lop base
        /// </summary>
        /// <param name="context"></param>
        public UpdateKhoPhieuNhapDac(ContextDto context) : base(context.dbQLNSConnection)
        {
            OrmConfiguration.DefaultDialect = SqlDialect.MsSql;

            _context = context;
        }
        #endregion

        #region init & validate
        /// <summary>
        /// Ham khoi tao gia tri mac dinh cho cac bien
        /// </summary>
        private void Init() { }

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
                var p = new DynamicParameters(PhieuNhap);

                var objResult = await c.QueryAsync<dynamic>(
                    sql: "sp_KhoPhieuNhap_UpdateKhoPhieuNhap",
                    param: p,
                    commandType: CommandType.StoredProcedure);

                PhieuNhap.MESSAGE = p.Get<string>("MESSAGE");
                PhieuNhap.RESULT = p.Get<string>("RESULT");

                return objResult;
            });
        }

        #endregion

    }
}