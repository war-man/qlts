﻿using Newtonsoft.Json;
using SongAn.QLTS.Util.Common.Helper;
using SongAn.QLTS.Util.Common.Identity;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace SongAn.QLDN.UI.QLDNMAIN.Controllers
{
    public class UploadController : BaseController
    {
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public string Files()
        {
            dynamic result = new System.Dynamic.ExpandoObject();
            var httpRequest = HttpContext.Request;

            var path = HttpContext.Server.MapPath("~/Content/Upload/");
            var fileName = httpRequest.Form["fileName"];
            var filePath = Path.Combine(path, fileName);

            // TODO kiểm tra thư mục, tạo thư mục nếu chưa có
            if (Directory.Exists(path) == false)
            {
                Directory.CreateDirectory(path);
            }


            if (httpRequest.Files.Count > 0)
            {
                var postedFile = httpRequest.Files[0];
                postedFile.SaveAs(filePath);

                result.data = fileName;
                return JsonConvert.SerializeObject(result);
            }
            else
            {
                return JsonConvert.SerializeObject(ActionHelper.returnActionError(HttpStatusCode.BadRequest, "error"));
            }
        }

    }
}