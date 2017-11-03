/**************************************************
1. Create Date	: 2017.11.03
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: báo cáo công khai tài sản nhà đất
				  biểu 03 Thông tư số 89/2010/TT/BTC
				  ngày 16/6/2010 của Bộ Tài chính
4. Function		: 
5. Example		: 
					EXEC [sp_CongKhai_report_NhaDatBieu03]
						 @Year				=	'2017'
						,@LoaiKeKhai		=	'1|2'
						,@COSO_ID			=	1
						,@NHANVIEN_ID		=	6
6. Precaution	:
7. History		:
				  2017.11.03 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_CongKhai_report_NhaDatBieu03]
	 @Year			NVARCHAR(MAX)	=	NULL
	,@LoaiKeKhai	NVARCHAR(MAX)	=	NULL
	,@COSO_ID		INT				=	NULL
	,@NHANVIEN_ID	INT				=	NULL
AS
BEGIN
SET NOCOUNT ON
--------------------------------------------------
DECLARE
	 @col			varchar(max)	=	''
	,@V_DELIMITER	VARCHAR(1)		=	'|'
	,@V_SQL			nvarchar(max)	=	''


SET @LoaiKeKhai = '1|2'

IF OBJECT_ID('tempdb..#NguonNganSach') IS NOT NULL
	DROP TABLE #NguonNganSach

select *
	,(case when TenNguonNganSach like N'nguồn ngân sách' then 'NguonNganSach'
		when TenNguonNganSach like N'Nguồn bảo hiểm' then 'BaoHiem'
		when TenNguonNganSach like N'Nguồn chi không thường xuyên' then 'ChiKhongThuongXuyen'
		when TenNguonNganSach like N'Nguồn ngân sách viện trợ, tài trợ' then 'TaiTro'
		when TenNguonNganSach like N'nguồn khác' then 'NguonKhac'
		else MaNguonNganSach
	end) MaNguon
into #NguonNganSach
from NguonNganSach

-- lấy danh chuỗi sách cột nguồn nhân sách
select @col = coalesce(@col + ',','') + MaNguon
from #NguonNganSach
if @col <> ''
	set @col = substring(@col,2,len(@col))

print ('@col=' + @col)

set @V_SQL = N'
	select ts.TaiSanId
			,ts.TenTaiSan
			,ts.LoaiKeKhai
			,pv.Nam
			,cs.TenCoSo
			,cstt.TenCoSo DonViChuQuan
			
			,ttkk_dat.DienTich

			,ttkk_nha.TongDienTichSan

			,isnull(pv.NguonNganSach,0)/1000 NguonNganSach
			,isnull((pv.NguyenGia - pv.NguonNganSach),0)/1000 NguonKhac
	from (
		select td.*
			,nns.MaNguon
			,isnull(ng.GiaTri,0) GiaTri
		from (
			select _ts.TaiSanId,_td.Nam
				,sum(SLTon + SLTang - SLGiam) SoLuong
				,sum(_ng.GiaTri) NguyenGia
			from TheoDoi _td
				left join TaiSan _ts on _td.TaiSanId = _ts.TaiSanId
				left join NguyenGia _ng on _td.TaiSanId = _ng.TaiSanId
			where
				Nam = @Year
				and charindex(@V_DELIMITER + cast(_ts.LoaiKeKhai as varchar(10)) + @V_DELIMITER,@V_DELIMITER + @LoaiKeKhai + @V_DELIMITER) > 0
				and _ts.CoSoId = @COSO_ID
			group by _ts.TaiSanId,_td.Nam
			having sum(SLTon + SLTang - SLGiam) > 0
		) td
		right join #NguonNganSach nns on nns.NguonNganSachId = nns.NguonNganSachId
		left join NguyenGia ng on nns.NguonNganSachId = ng.NguonNganSachId and ng.TaiSanId = td.TaiSanId
	) rs
	pivot(
		sum(GiaTri)
		for MaNguon in ('+@col+')
	) pv
	left join TaiSan ts on pv.TaiSanId = ts.TaiSanId
	left join CoSo cs on ts.CoSoId = cs.CoSoId
	left join CoSo cstt on cs.TrucThuoc = cstt.CoSoId
	left join ThongTinKeKhai_Dat ttkk_dat on pv.TaiSanId = ttkk_dat.TaiSanId
	left join ThongTinKeKhai_Nha ttkk_nha on pv.TaiSanId = ttkk_nha.TaiSanId
'

EXECUTE sp_executesql @V_SQL,N'
	 @Year			varchar(4)		=	null
	,@LoaiKeKhai	varchar(max)	=	null
	,@COSO_ID		int				=	null
	,@V_DELIMITER	VARCHAR(10)		=	null
	'
	,@Year			=	@Year
	,@LoaiKeKhai	=	@LoaiKeKhai
	,@COSO_ID		=	@COSO_ID
	,@V_DELIMITER	=	@V_DELIMITER
--------------------------------------------------
SET NOCOUNT OFF
END