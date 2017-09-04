﻿using SongAn.QLTS.Util.Common.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Newtonsoft.Json;
using System.Threading.Tasks;

namespace SongAn.QLTS.UI.QLTSMAIN.Controllers
{
    public class NguoiDungController : BaseController
    {
        // GET: NguoiDung
        public ActionResult Index()
        {
            string __VIEW_NAME = "Index";
            return View(__VIEW_NAME);
        }

        [CustomAuthorize(FunctionCodes = "CN0002")]
        public ActionResult List()
        {
            string userLogin = LoadUserInfo("CN0002");

            ViewBag.userInfo = userLogin;

            return View();
        }
    }
}