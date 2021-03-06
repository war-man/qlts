﻿/*****************************************************************************
1. Create Date  : 2017.09.27
2. Creator      : NGUYỄN THANH BÌNH
3. Function     : 
4. Description  : 
5. History      : 2017.09.27 (NGUYỄN THANH BÌNH) - Tao moi
*****************************************************************************/
using Dapper;
using Dapper.FastCrud;
using SongAn.QLTS.Util.Common.Dto;
using SongAn.QLTS.Util.Common.Repository;
using System;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace SongAn.QLTS.Data.QLTS.DanhGia
{
    public class DeleteDanhGiaDac : BaseRepositoryAsync
    {
        #region public properties
        public virtual int DanhGiaId { get; set; }
        public virtual int COSO_ID { get; set; }
        public virtual int NHANVIEN_ID { get; set; }
        public virtual string MESSAGE { get; set; }
        #endregion

        #region private variable
        ContextDto _context;
        private DataTable _NguyenGiaList { get; set; }
        #endregion

        #region constructor
        public DeleteDanhGiaDac(ContextDto context) : base(context.dbQLTSConnection)
        {
            OrmConfiguration.DefaultDialect = SqlDialect.MsSql;

            _context = context;
        }
        #endregion

        #region init & validate
        private void Init() { }
        private void Validate() { }

        #endregion

        #region execute
        public virtual async Task<IEnumerable<dynamic>> Execute()
        {
            Init();
            Validate();

            return await WithConnection(async c =>
            {
                var p = new DynamicParameters(this);
                p.Add("@MESSAGE", dbType: DbType.String, direction: ParameterDirection.Output, size: 4000);

                var objResult = await c.QueryAsync<dynamic>(
                    sql: "sp_DanhGia_DeleteDanhGia",
                    param: p,
                    commandType: CommandType.StoredProcedure);

                MESSAGE = p.Get<string>("MESSAGE");

                return objResult;
            });
        }

        #endregion

    }
}
