USE [CVLyzer]
GO
/****** Object:  Table [dbo].[Extract_CVInfo]    Script Date: 21/05/2022 09:07:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Extract_CVInfo](
	[CV_ID] [int] IDENTITY(10,1) NOT NULL,
	[fk_UserID] [int] NOT NULL,
	[CV_URL] [nvarchar](max) NULL,
	[Name] [nvarchar](50) NULL,
	[Phone] [bigint] NULL,
	[Address] [nvarchar](50) NULL,
	[Education] [nvarchar](50) NULL,
	[Skills] [nvarchar](max) NULL,
	[Email] [nvarchar](50) NULL,
	[Experience] [int] NULL,
 CONSTRAINT [PK_Extract_CVInfo] PRIMARY KEY CLUSTERED 
(
	[CV_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USER]    Script Date: 21/05/2022 09:07:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USER](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[UserEmail] [nvarchar](50) NOT NULL,
	[UserPhone] [bigint] NOT NULL,
	[UserPassword] [nvarchar](50) NOT NULL,
	[UserType] [nchar](10) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreationDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_USER] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sp_auth]    Script Date: 21/05/2022 09:07:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_auth]
@Email nvarchar(50),
@Pin nchar(10)
as
begin
select userID, username from [dbo].[USER]
where UserEmail=@Email and UserPassword=@Pin
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Get_CV_Information]    Script Date: 21/05/2022 09:07:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_Get_CV_Information]
as
begin
select * from [dbo].[Extract_CVInfo]
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Get_User_Information]    Script Date: 21/05/2022 09:07:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_Get_User_Information]
as
begin
select * from [dbo].[USER]
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Insert_CVInfo]    Script Date: 21/05/2022 09:07:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_Insert_CVInfo]
@CV_ID int, 
@fk_UserID int, 
@CV_URL nvarchar(50), 
@Name nvarchar(50), @Phone bigint, @Address nvarchar(50), @Education nvarchar(50), @Skills nvarchar(MAX), @Email nvarchar(50), @Experience int

as

begin
insert into [dbo].[Extract_CVInfo] (CV_ID, fk_UserID, CV_URL, Name, Phone, Address, Education, Skills, Experience, Email)
values (@CV_ID, @fk_UserID, @CV_URL, @Name, @Phone, @Address, @Education, @Skills, @Email, @Experience)
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Insert_USER_info]    Script Date: 21/05/2022 09:07:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_Insert_USER_info]
@UserID int, @UserName nvarchar(50), @UserEmail nvarchar(50), @UserPhone bigint, @UserPassword nvarchar(50),@UserType nchar(10), @IsActive bit, @CreationDateTime datetime

as

begin
insert into [dbo].[USER]( UserName, UserEmail, UserPhone, UserPassword, UserType, IsActive, CreationDateTime)
values ( @UserName, @UserEmail, @UserPhone, @UserPassword, @UserType, @IsActive, GETDATE())
end
GO
