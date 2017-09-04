/*************************************************************  
1. Create Date	: 2017.04.27
2. Creator		: Nguyen Ngoc Tan
3. Description	: Lấy Quyền tác vụ theo MaChucNang và MaVaiTro
4. Function		: QLTSMAIN/NghiPhep/List
5. Example		: 
					exec [dbo].[sp_QuyenTacVu_GetByMaChucNangAndMaVaiTro]
					@MACHUCNANG = 'CN0006'
					,@MAVAITRO = 'Admin'

6. Precaution	:
7. History		:
				  2017.04.27(Nguyen Ngoc Tan) - Tạo mới
*************************************************************/
CREATE PROC [dbo].[sp_PhanQuyen_GetQuyenTacVuByMaChucNangAndMaVaiTro]
( 
	@MACHUCNANG			nvarchar(64)			-- Mã Chức Năng
	, @MAVAITRO			nvarchar(64)			-- Mã Vai trò

)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước

	-- Chuẩn bị biến @MACHUCNANG
	SET @MACHUCNANG = ISNULL(@MACHUCNANG,'')

	-- Chuẩn bị biến @MAVAITRO
	SET @MAVAITRO = ISNULL(@MAVAITRO, '')

   
---- Thực thi câu SQL
	SELECT TOP 1
	VT.VaiTroId
	,[MaVaiTro]
	,MaChucNang
	,QTV.DSQuyenTacVu
	FROM [dbo].[VaiTro] VT WITH(NOLOCK, READUNCOMMITTED)
		inner join [dbo].[QuyenTacVu] QTV on VT.VaiTroId = QTV.VaiTroId
		inner join [dbo].[ChucNang] CN on CN.ChucNangId = QTV.ChucNangId
	WHERE 
	[MaVaiTro] = @MAVAITRO and MaChucNang = @MACHUCNANG
	

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END

