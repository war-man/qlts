//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace VTSolution.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class KhachHang
    {
        public int KhachHangId { get; set; }
        public string Ma { get; set; }
        public string Ten { get; set; }
        public short Loai { get; set; }
        public string DienThoai { get; set; }
        public string DiDong { get; set; }
        public string Email { get; set; }
        public string DiaChi { get; set; }
        public Nullable<int> TinhThanhPhoId { get; set; }
        public Nullable<int> QuanHuyenId { get; set; }
        public Nullable<int> PhuongXaId { get; set; }
        public Nullable<System.DateTime> NgayTao { get; set; }
        public string AnyDesk { get; set; }
        public Nullable<int> NguoiTao { get; set; }
        public string XoaYN { get; set; }
        public decimal CtrVersion { get; set; }
    }
}
