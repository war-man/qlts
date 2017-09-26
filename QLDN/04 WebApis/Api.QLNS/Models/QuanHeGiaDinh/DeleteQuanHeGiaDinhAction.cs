﻿using SongAn.QLDN.Biz.QLNS.QuanHeGiaDinh;
using SongAn.QLDN.Util.Common.CustomException;
using SongAn.QLDN.Util.Common.Dto;
using SongAn.QLDN.Util.Common.Helper;
using System;
using System.Net;
using System.Threading.Tasks;

namespace SongAn.QLDN.Api.QLNS.Models.QuanHeGiaDinh
{
    public class DeleteQuanHeGiaDinhAction
    {
        #region PUBLIC
        public string QuanHeGiaDinhId { get; set; }
        public string CtrVersion { get; set; }
        public string loginId { get; set; }
        #endregion

        #region private
        private int _QuanHeGiaDinhId;
        private int _CtrVersion;
        private int _loginId;
        #endregion

        #region init & validate

        /// <summary>
        /// Ham khoi tao gia tri mac dinh cho cac bien
        /// </summary>
        private void init()
        {
            _QuanHeGiaDinhId = Protector.Int(QuanHeGiaDinhId, 0);
            _CtrVersion = Protector.Int(CtrVersion, 0);
            _loginId = Protector.Int(loginId, 0);
        }

        /// <summary>
        /// Ham chuan hoa gia tri cac bien
        /// </summary>
        private void validate() { }

        #endregion

        public async Task<ActionResultDto> Execute(ContextDto context)
        {
            try
            {
                init();
                validate();

                var biz = new DeleteQuanHeGiaDinhBiz(context);
                biz.QuanHeGiaDinhId = _QuanHeGiaDinhId;
                biz.CtrVersion = _CtrVersion;
                biz.LOGIN_ID = _loginId;

                var result = await biz.Execute();

                if (string.IsNullOrEmpty(biz.MESSAGE) == false)
                {
                    throw new BaseException(biz.MESSAGE.Split('|')[2]);
                }

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