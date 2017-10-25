/**************************************************
1. Create Date	: 2017.10.24
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
6. Precaution	:
7. History		:
				  2017.10.24 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE TYPE [dbo].[KhoPhieuXuatChiTietTableType] AS TABLE(
	[KhoPhieuXuatChiTietId] [int] NULL,
	[KhoPhieuXuatId] [int] NULL,
	[TaiSanId] [int] NULL,
	[SoLuong] [numeric](18, 4) NULL,
	[DonGia] [numeric](18, 4) NULL,
	[GiaMua] [numeric](18, 4) NULL,
	[GiaBan] [numeric](18, 4) NULL,
	[NguonNganSachId] [int] NULL,
	[NhaCungCapId] [int] NULL,
	[HanDung] [varchar](10) NULL,
	[LoSanXuat] [varchar](10) NULL
)