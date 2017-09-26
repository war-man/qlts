﻿/*****************************************************************************
1. Create Date : 2017.09.13
2. Creator     : NGUYỄN THANH BÌNH
3. Description : 
4. History     : 2017.09.13 (NGUYỄN THANH BÌNH) - Tao moi
*****************************************************************************/
using SongAn.QLTS.Api.QLTS.Models.ThayDoiThongTin;
using SongAn.QLTS.Util.Common.Api;
using SongAn.QLTS.Util.Common.Dto;
using System.Threading.Tasks;
using System.Web.Http;

namespace SongAn.QLTS.Api.QLTS.Controllers
{
    public class ThayDoiThongTinController : BaseApiController
    {
        // GET: NhomTaiSan
        public ThayDoiThongTinController() : base() { }

        [HttpPost]
        public async Task<IHttpActionResult> GetListThayDoiThongTinByCriteria([FromBody]GetListThayDoiThongTinByCriteriaAction action)
        {
            ActionResultDto result = await action.Execute(context);
            return Content(result.ReturnCode, result.ReturnData);
        }
        [HttpPost]
        public async Task<IHttpActionResult> GetThayDoiThongTinById([FromBody]GetThayDoiThongTinByIdAction action)
        {
            ActionResultDto result = await action.Execute(context);
            return Content(result.ReturnCode, result.ReturnData);
        }
        [HttpPost]
        public async Task<IHttpActionResult> GetThayDoiThongTinDatById([FromBody]GetThayDoiThongTinDatByIdAction action)
        {
            ActionResultDto result = await action.Execute(context);
            return Content(result.ReturnCode, result.ReturnData);
        }
        [HttpPost]
        public async Task<IHttpActionResult> GetThayDoiThongTinNhaById([FromBody]GetThayDoiThongTinNhaByIdAction action)
        {
            ActionResultDto result = await action.Execute(context);
            return Content(result.ReturnCode, result.ReturnData);
        }
        [HttpPost]
        public async Task<IHttpActionResult> GetThayDoiThongTinOtoById([FromBody]GetThayDoiThongTinOtoByIdAction action)
        {
            ActionResultDto result = await action.Execute(context);
            return Content(result.ReturnCode, result.ReturnData);
        }
        [HttpPost]
        public async Task<IHttpActionResult> GetThayDoiThongTin500ById([FromBody]GetThayDoiThongTin500ByIdAction action)
        {
            ActionResultDto result = await action.Execute(context);
            return Content(result.ReturnCode, result.ReturnData);
        }
        [HttpPost]
        public async Task<IHttpActionResult> InsertThayDoiThongTin([FromBody]InsertThayDoiThongTinAction action)
        {
            ActionResultDto result = await action.Execute(context);
            return Content(result.ReturnCode, result.ReturnData);
        }
        [HttpPost]
        public async Task<IHttpActionResult> UpdateThayDoiThongTin([FromBody]UpdateThayDoiThongTinAction action)
        {
            ActionResultDto result = await action.Execute(context);
            return Content(result.ReturnCode, result.ReturnData);
        }
        [HttpPost]
        public async Task<IHttpActionResult> DeleteThayDoiThongTin([FromBody]DeleteThayDoiThongTinAction action)
        {
            ActionResultDto result = await action.Execute(context);
            return Content(result.ReturnCode, result.ReturnData);
        }
    }
}