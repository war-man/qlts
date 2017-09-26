﻿/*****************************************************************************
1. Create Date  : 2017.06.07
2. Creator      : NGUYỄN THANH BÌNH
3. Function     : QLDNKHO/KHOKHOHANG/LIST
4. Description  : THÊM THÔNG TIN KHO HÀNG
5. History      : 2017.06.07 (NGUYỄN THANH BÌNH) - Tao moi
*****************************************************************************/
using SongAn.QLDN.Util.Common.Dto;
using SongAn.QLDN.Data.Repository.MSSQL_QLDN_QLNS;
using System.Threading.Tasks;
using System;
using System.Net;
using SongAn.QLDN.Biz.QLKho.KhoKhoHang;
using SongAn.QLDN.Util.Common.Helper;
using SongAn.QLDN.Util.Common.CustomException;

namespace SongAn.QLDN.Api.QLKho.Models.KhoKhoHang
{
    public class InsertKhoKhoHangAction : Entity.MSSQL_QLDN_QLNS.Entity.KhoKhoHang
    {

        #region PUBLIC
        public string LoginId { get; set; }
        #endregion

        #region private
        private int _LoginId;
        #endregion

        #region init & validate

        /// <summary>
        /// Ham khoi tao gia tri mac dinh cho cac bien
        /// </summary>
        private void init()
        {
            _LoginId = Protector.Int(LoginId, 0);
        }

        /// <summary>
        /// Ham chuan hoa gia tri cac bien
        /// </summary>
        private void validate()
        {
            //throw new FormatException("hello");
        }

        #endregion

        public async Task<ActionResultDto> Execute(ContextDto context)
        {
            try
            {
                init();
                validate();

                var biz = new InsertKhoKhoHangBiz(context);
                biz.LOGIN_ID = _LoginId;
                biz.MA_KHO = MaKho;
                biz.TEN_KHO = TenKho;
                biz.MO_TA = MoTa;
                biz.CHI_NHANH = ChiNhanh;
                biz.DIA_CHI = DiaChi;
                biz.MO_TA = MoTa;

                var result = await biz.Execute();


                dynamic _metaData = new System.Dynamic.ExpandoObject();

                return ActionHelper.returnActionResult(HttpStatusCode.OK, result, _metaData);
            }
            catch (BaseException ex)
            {
                return ActionHelper.returnActionError(HttpStatusCode.BadRequest, ex.Message);
            }
            catch (Exception ex)
            {
                return ActionHelper.returnActionError(HttpStatusCode.InternalServerError, ex.InnerException != null ? ex.InnerException.Message : ex.Message);
            }
        }
    }
}