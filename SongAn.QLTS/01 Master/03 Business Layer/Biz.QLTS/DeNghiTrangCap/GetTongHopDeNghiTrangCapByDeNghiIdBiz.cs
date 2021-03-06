﻿using SongAn.QLTS.Util.Common.Dto;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;
using SongAn.QLTS.Data.QLTS.DeNghiTrangCap;

namespace SongAn.QLTS.Biz.QLTS.DeNghiTrangCap
{
    public class GetTongHopDeNghiTrangCapByDeNghiIdBiz : GetTongHopDeNghiTrangCapByDeNghiIdDac
    {
        #region public properties

        #endregion

        #region private variable

        #endregion

        #region constructor
        /// <summary>
        /// Ham khoi tao, chi nhan vao bien moi truong va goi lop base
        /// </summary>
        /// <param name="context"></param>
        public GetTongHopDeNghiTrangCapByDeNghiIdBiz(ContextDto context) : base(context)
        {

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
        /// Ham xu ly chinh, chi nhan 1 bien moi truong3
        /// </summary>
        /// <param name="context">Bien moi truong</param>
        /// <returns></returns>
        public override async Task<IEnumerable<dynamic>> Execute()
        {
            Init();
            Validate();

            // to do:
            // biz se thuc hien viec abc o day truoc khi goi dac

            // goi lai ham execute cua tang dac
            var result = await base.Execute();

            // to do:
            // biz se thuc hien viec abc voi result truoc khi return
            return result;
        }

        #endregion
    }
}
