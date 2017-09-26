﻿/*****************************************************************************
1. Create Date : 2017.03.30
2. Creator     : Tran Quoc Hung
3. Description : Cai dat IPrincipal tuy bien phuc vu login & phan quyen
4. History     : 2017.03.30(Tran Quoc Hung) - Tao moi
*****************************************************************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;

namespace SongAn.QLDN.Util.Common.Identity
{
        public class CustomPrincipal : IPrincipal
        {
            public IIdentity Identity { get; private set; }
            public bool IsInRole(string role)
            {
                if (Roles.Any(r => role.Contains(r)))
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }

        public bool IsInFunction(string function)
        {
            if (FunctionCodes.Any(r => function.Contains(r)))
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public CustomPrincipal(string Email)
            {
                this.Identity = new GenericIdentity(Email);
            }

            public int UserId { get; set; }
            public string Name { get; set; }
            public string NhanVienId { get; set; }
            public string[] FunctionCodes { get; set; }
            public string[] Roles { get; set; }
            public string Email { get; set; }
            public string ApiToken { get; set; }
    }
}