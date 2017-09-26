﻿/*****************************************************************************
1. Create Date  : 2017.05.04
2. Creator      : Tran Quoc Hung
3. Function     : QLDNMAIN/TangCa/
4. Description  : Action api Lấy danh sách Tăng Ca theo điều kiện
5. History      : 2017.05.04(Tran Quoc Hung) - Tao moi
*****************************************************************************/
using SongAn.QLDN.Biz.QLNS.TangCa;
using SongAn.QLDN.Util.Common.Dto;
using SongAn.QLDN.Util.Common.Helper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;

namespace SongAn.QLDN.Api.QLNS.Models.TangCa
{
    /// <summary>
    /// Action api Lấy danh sách Tăng Ca theo điều kiện
    /// </summary>
    public class GetListTangCaByCriteriaAction
    {
        #region public properties
        public string LoginId { get; set; }
        /// <summary>
        /// draw
        /// </summary>
        public string draw { get; set; }

        /// <summary>
        /// start
        /// </summary>
        public string start { get; set; }

        /// <summary>
        /// length
        /// </summary>
        public string length { get; set; }

        /// <summary>
        /// sortName
        /// </summary>
        public string sortName { get; set; }

        /// <summary>
        /// sortDir
        /// </summary>
        public string sortDir { get; set; }

        /// <summary>
        /// Mã Form
        /// </summary>
        public string MA_FORM { get; set; }

        /// <summary>
        /// Danh sách các field cần lấy
        /// </summary>
        public string FIELD { get; set; }

        /// <summary>
        /// Chuỗi QUICK SEARCH
        /// </summary>
        public string SEARCH_STRING { get; set; }

        /// <summary>
        /// Loại
        /// </summary>
        public string LOAI { get; set; }

        /// <summary>
        /// Người duyệt ID
        /// </summary>
        public string NGUOI_DUYET { get; set; }

        /// <summary>
        /// Trạng thái ID
        /// </summary>
        public string TRANG_THAI { get; set; }

        /// <summary>
        /// Ngày bắt đầu.
        /// </summary>
        public string NGAY_BAT_DAU { get; set; }

        /// <summary>
        /// Ngày kết thúc.
        /// </summary>
        public string NGAY_KET_THUC { get; set; }

        #endregion

        #region private variable

        private int _draw;

        private int _start;

        private int _length;

        #endregion

        #region constructor

        /// <summary>
        /// Ham khoi tao
        /// </summary>
        public GetListTangCaByCriteriaAction()
        {

        }
        #endregion

        #region init & validate

        /// <summary>
        /// Ham khoi tao gia tri mac dinh cho cac bien
        /// </summary>
        private void Init()
        {
            _draw = Protector.Int(draw);
            _start = Protector.Int(start);
            _length = Protector.Int(length);

            sortName = string.IsNullOrEmpty(sortName) ? "TC_NGAYTAO" : sortName;
            sortDir = string.IsNullOrEmpty(sortDir) ? "desc" : sortDir;
            _length = _length < 1 ? 10 : _length;
            //FIELD = string.IsNullOrEmpty(FIELD) ? "NghiPhepId,NV.NhanVienId,TuNgay,DenNgay" : FIELD;

            MA_FORM = string.IsNullOrEmpty(MA_FORM) ? "FL0004" : MA_FORM;
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
        public async Task<ActionResultDto> Execute(ContextDto context)
        {
            try
            {
                Init();
                Validate();

                var _quicksearch = SEARCH_STRING;
                var orderClause = sortName + " " + sortDir;
                var total = 0;

                GetListTangCaByCriteriaBiz biz = new GetListTangCaByCriteriaBiz(context);
                biz.LOGIN_ID = LoginId;
                biz.MA_FORM = MA_FORM;
                biz.FIELD = FIELD;
                biz.LOAI = LOAI;
                biz.NGAY_BAT_DAU = NGAY_BAT_DAU;
                biz.NGAY_KET_THUC = NGAY_KET_THUC;
                biz.NGUOI_DUYET = NGUOI_DUYET;
                biz.TRANG_THAI = TRANG_THAI;
                biz.SEARCH_STRING = _quicksearch;
                biz.ORDER_CLAUSE = orderClause;
                biz.SKIP = _start;
                biz.TAKE = _length;

                IEnumerable<dynamic> list = await biz.Execute();
                if (list.Count() > 0)
                {
                    var obj = list.FirstOrDefault();

                    total = Protector.Int(obj.MAXCNT);
                }

                dynamic _metaData = new System.Dynamic.ExpandoObject();
                _metaData.draw = _draw;
                _metaData.total = total;

                return ActionHelper.returnActionResult( HttpStatusCode.OK, list, _metaData);
            }
            catch(FormatException ex)
            {
                return ActionHelper.returnActionError(HttpStatusCode.BadRequest, ex.InnerException != null ? ex.InnerException.Message : ex.Message);
            }
            catch (Exception ex)
            {
                return ActionHelper.returnActionError(HttpStatusCode.InternalServerError, ex.InnerException != null ? ex.InnerException.Message : ex.Message);
            }
        }
        #endregion
    }
}