﻿using Dapper;
using Dapper.FastCrud;
using SongAn.QLTS.Util.Common.Dto;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;
using SongAn.QLTS.Util.Common.Repository;

namespace SongAn.QLTS.Data.Main.ThongBao
{
    public class GetListThongBaoByCoSoIdDac : BaseRepositoryAsync
    {
        #region public properties
        public int CoSoId { get; set; }
        public int UserId { get; set; }

        #endregion

        #region private variable
        private ContextDto _context;
        #endregion

        #region constructor
        /// <summary>
        /// Ham khoi tao, chi nhan vao bien moi truong va goi lop base
        /// </summary>
        /// <param name="context"></param>
        public GetListThongBaoByCoSoIdDac(ContextDto context) : base(context.dbQLTSConnection)
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
                p.Add("CoSoId", CoSoId, DbType.String);
                p.Add("UserId", UserId, DbType.String);
                var objResult = await c.QueryAsync<dynamic>(
                    sql: "sp_ThongBao_ThongBaoByCoSoId",
                    param: p,
                    commandType: CommandType.StoredProcedure);

                return objResult;
            });
        }

        #endregion
    }
}
