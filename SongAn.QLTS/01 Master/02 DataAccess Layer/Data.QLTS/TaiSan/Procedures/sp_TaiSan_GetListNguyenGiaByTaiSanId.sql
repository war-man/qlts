/**************************************************
1. Create Date	: 2017.09.01
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_TaiSan_GetListNguyenGiaByTaiSanId]
						 @TaiSanId			=	32

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.01 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_TaiSan_GetListNguyenGiaByTaiSanId]
	 @TaiSanId			INT				=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON  
	SELECT	NG.*,NNS.TenNguonNganSach
	FROM	NguyenGia NG
			LEFT JOIN NguonNganSach NNS ON NG.NguonNganSachId = NNS.NguonNganSachId
	WHERE	TaiSanId = @TaiSanId
SET NOCOUNT OFF
END

