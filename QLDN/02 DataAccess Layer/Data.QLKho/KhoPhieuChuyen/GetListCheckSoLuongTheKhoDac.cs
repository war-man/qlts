﻿/*****************************************************************************
1. Create Date  : 2017.06.17
2. Creator      : NGUYỄN NGỌC TÂN
3. Function     : 
4. Description  : GỌI SP LẤY THÔNG TIN PHIẾU CHUYỂN
5. History      : 2017.06.17 (NGUYỄN NGỌC TÂN) - Tao moi
*****************************************************************************/
using Dapper;
using Dapper.FastCrud;
using SongAn.QLDN.Util.Common.Dto;
using SongAn.QLDN.Util.Common.Repository;
using System;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace SongAn.QLDN.Data.QLKho.KhoPhieuChuyen
{
    /// <summary>
    /// DAC Lấy danh sách Phong ban theo điều kiện
    /// </summary>
    public class GetListCheckSoLuongTheKhoDac : BaseRepositoryAsync
    {
        #region public properties
        public DateTime? NGAY_XUAT { get; set; }
        public int HANGHOAID { get; set; }
        public int KHOHANGID { get; set; }
        public string LO_HANG { get; set; }
        public decimal GIA_NHAP { get; set; }
        public int LOGIN_ID { get; set; }
        #endregion

        #region private variable

        ContextDto _context;

        #endregion

        #region constructor
        /// <summary>
        /// Ham khoi tao, chi nhan vao bien moi truong va goi lop base
        /// </summary>
        /// <param name="context"></param>
        public GetListCheckSoLuongTheKhoDac(ContextDto context) : base(context.dbQLNSConnection)
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
                var p = new DynamicParameters(this);

                var objResult = await c.QueryAsync<dynamic>(
                    sql: "sp_KhoPhieuChuyen_CheckSoLuongTonKho",
                    param: p,
                    commandType: CommandType.StoredProcedure);

                return objResult;
            });
        }

        #endregion

    }
}