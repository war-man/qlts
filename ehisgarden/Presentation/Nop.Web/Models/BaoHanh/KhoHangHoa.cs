//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Nop.Web.Models.BaoHanh
{
    using System;
    using System.Collections.Generic;
    
    public partial class KhoHangHoa
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public KhoHangHoa()
        {
            this.KhoPhieuXuatChiTiets = new HashSet<KhoPhieuXuatChiTiet>();
        }
    
        public int HangHoaId { get; set; }
        public string MaHangHoa { get; set; }
        public string TenHangHoa { get; set; }
        public string TuKhoa { get; set; }
        public string DonViTinh { get; set; }
        public Nullable<decimal> GiaMua { get; set; }
        public Nullable<decimal> GiaBan { get; set; }
        public Nullable<short> ThoiGianBaoHanh { get; set; }
        public string ThueMua { get; set; }
        public string ThueBan { get; set; }
        public string CauHinh { get; set; }
        public string Hinh { get; set; }
        public Nullable<int> NhomHangHoaId { get; set; }
        public Nullable<int> LoaiHangHoaId { get; set; }
        public Nullable<int> NhaCungCapId { get; set; }
        public Nullable<int> HangSanXuatId { get; set; }
        public Nullable<int> NuocSanXuatId { get; set; }
        public string MoTa { get; set; }
        public string GhiChu { get; set; }
        public Nullable<int> NguoiTao { get; set; }
        public Nullable<System.DateTime> NgayTao { get; set; }
        public string XoaYN { get; set; }
        public Nullable<int> CtrVersion { get; set; }
    
        public virtual KhoHangSanXuat KhoHangSanXuat { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<KhoPhieuXuatChiTiet> KhoPhieuXuatChiTiets { get; set; }
    }
}