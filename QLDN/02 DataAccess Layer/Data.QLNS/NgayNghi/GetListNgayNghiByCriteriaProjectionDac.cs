﻿/*****************************************************************************
1. Create Date  : 2017.04.17
2. Creator      : Nguyen Ngoc Tan
3. Function     : QLDNMAIN/NgayNghi/NgayNghi
4. Description  : Goi sp de lay danh sach phong ban voi dieu kien
5. History      : 2017.04.17(Nguyen Ngoc Tan) - Tao moi
*****************************************************************************/
using Dapper;
using Dapper.FastCrud;
using SongAn.QLDN.Util.Common.Dto;
using SongAn.QLDN.Util.Common.Repository;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace SongAn.QLDN.Data.QLNS.NgayNghi
{
    /// <summary>
    /// DAC Lấy danh sách Phong ban theo điều kiện
    /// </summary>
    public class GetListNgayNghiSelectAllByCriteriaProjectionDac : BaseRepositoryAsync
    {
        #region public properties

        /// <summary>
        /// Danh sách các field cần lấy
        /// </summary>
        public string FieldsField { get; set; }

        /// <summary>
        /// Mệnh đề where
        /// </summary>
        public string WhereClause { get; set; }

        /// <summary>
        /// Mệnh đề order by
        /// </summary>
        public string OrderClause { get; set; }

        /// <summary>
        /// Số dòng skip (để phân trang)
        /// </summary>
        public int? Skip  { get; set; }

        /// <summary>
        /// Số dòng take (để phân trang)
        /// </summary>
        public int? Take { get; set; }

        #endregion

        #region private variable

        ContextDto _context;

        #endregion

        #region constructor
        /// <summary>
        /// Ham khoi tao, chi nhan vao bien moi truong va goi lop base
        /// </summary>
        /// <param name="context"></param>
        public GetListNgayNghiSelectAllByCriteriaProjectionDac(ContextDto context) : base(context.dbQLNSConnection)
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
            FieldsField = FieldsField.Equals("") ? nameof(Entity.MSSQL_QLDN_QLNS.Entity.NghiPhep.NghiPhepId) : FieldsField;

            WhereClause = WhereClause.Equals("") ? "" : WhereClause;

            OrderClause = OrderClause.Equals("") ? nameof(Entity.MSSQL_QLDN_QLNS.Entity.NghiPhep.NghiPhepId) : OrderClause;

            Skip = Skip != null ? Skip.Value : 0;

            Take = Take != null ? Take.Value : 100;
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
                p.Add("FieldsField", FieldsField, DbType.String);
                p.Add("WhereClause", WhereClause, DbType.String);
                p.Add("OrderClause", OrderClause, DbType.String);
                p.Add("Skip", Skip, DbType.Int16);
                p.Add("Take", Take, DbType.Int16);

                var objResult = await c.QueryAsync<dynamic>(
                    sql: "sp_NgayNghi_GetListNgayNghiByCriteria",
                    param: p,
                    commandType: CommandType.StoredProcedure);

                return objResult;
            });
        }

        #endregion

    }
}