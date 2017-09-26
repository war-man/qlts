﻿using SongAn.QLDN.Data.Repository.MSSQL_QLDN_QLNS;
using SongAn.QLDN.Util.Common.Dto;
using System.Threading.Tasks;

namespace  SongAn.QLDN.Api.QLKho.Models.KhoNhomHangHoa
{
    public class DeleteKhoNhomHangHoaAction
    {
        public int Id { get; set; }
        public async Task<dynamic> Execute(ContextDto context)
        {
            dynamic result = new System.Dynamic.ExpandoObject();

            var repo = new KhoNhomHangHoaRepository(context);
            await repo.Delete(Id);
            result.data = await repo.Delete(Id); 
            return result;
        }
    }
}