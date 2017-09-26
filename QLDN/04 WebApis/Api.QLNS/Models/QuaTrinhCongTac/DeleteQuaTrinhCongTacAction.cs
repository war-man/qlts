﻿/*****************************************************************************
1. Create Date : 2017.05.17
2. Creator     : Nguyen Thanh Binh
3. Description : action lấy danh sách quá trình công tác của nhân viên
4. History     : 2017.05.17(Nguyen Thanh Binh) - tạo mới
*****************************************************************************/
using SongAn.QLDN.Biz.QLNS.PhieuCongTac;
using SongAn.QLDN.Biz.QLNS.QuaTrinhCongTac;
using SongAn.QLDN.Util.Common.CustomException;
using SongAn.QLDN.Util.Common.Dto;
using SongAn.QLDN.Util.Common.Helper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace SongAn.QLDN.Api.QLNS.Models.PhieuCongTac
{
    public class DeleteQuaTrinhCongTacAction
    {
        #region public
        public string QuaTrinhCongTacId { get; set; }
        public string NhanVienId { get; set; }
        public string CtrVersion { get; set; }
        #endregion

        #region private
        private int _QuaTrinhCongTacId;
        private int _NhanVienId;
        private int _CtrVersion;
        #endregion

        #region init & validate

        /// <summary>
        /// Ham khoi tao gia tri mac dinh cho cac bien
        /// </summary>
        private void init()
        {
            _QuaTrinhCongTacId = Protector.Int(QuaTrinhCongTacId, 0);
            _NhanVienId = Protector.Int(NhanVienId, 0);
            _CtrVersion = Protector.Int(CtrVersion, -1);
        }

        /// <summary>
        /// Ham chuan hoa gia tri cac bien
        /// </summary>
        private void validate()
        {
            if (_QuaTrinhCongTacId == 0)
            {
                throw new BaseException("Không tìm thấy thông tin quá trình công tác.");
            }
        }

        #endregion

        public async Task<ActionResultDto> Execute(ContextDto context)
        {
            try
            {
                init();
                validate();

                var biz = new DeleteQuaTrinhCongTacBiz(context);
                biz.QuaTrinhCongTacId = _QuaTrinhCongTacId;
                biz.NhanVienId = _NhanVienId; // phải có nhân viên id để kiểm tra trạng thái xóa
                biz.CtrVersion = _CtrVersion;

                var result = (await biz.Execute());

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