﻿using SongAn.QLKD.Util.Common.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Newtonsoft.Json;
using System.Threading.Tasks;

namespace SongAn.QLKD.UI.QLKDMAIN.Controllers
{
    public class KeHoachController : BaseController
    {
        // GET: KeHoach
        public ActionResult Index()
        {
            return View();
        }

        [CustomAuthorize(FunctionCodes = "KD0009")]
        public ActionResult showView(string viewName, string type)
        {
            type = string.IsNullOrEmpty(type) ? "Html" : type;
            ViewData[type] = true;
            string userLogin = LoadUserInfo("KD0009");
            ViewBag.userInfo = userLogin;
            return PartialView(viewName);
        }
    }
}