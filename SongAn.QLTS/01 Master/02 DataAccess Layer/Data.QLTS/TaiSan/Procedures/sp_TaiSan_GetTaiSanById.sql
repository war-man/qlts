USE [QLTS]
GO

/**************************************************
1. Create Date	: 2017.08.31
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: THÔNG TIN TÀI SẢN
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_TaiSan_GetTaiSanById]
						 @TaiSanId			=	1065

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.08.31 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_TaiSan_GetTaiSanById]
	 @TaiSanId			INT				=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON  
	SELECT	TOP 10 TS.*, ISNULL(NG.NguyenGia,0) NguyenGia
	FROM	TaiSan TS
			LEFT JOIN (	SELECT	TaiSanId, ISNULL(SUM(GiaTri),0) NguyenGia
						FROM	NguyenGia
						GROUP BY  TaiSanId
			) NG ON TS.TaiSanId = NG.TaiSanId
	WHERE	TS.TaiSanId = @TaiSanId
SET NOCOUNT OFF
END
