USE [AttivitàManutenzione]
GO

/****** Object:  Table [dbo].[tb_posizioni]    Script Date: 13/06/2023 11:00:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_posizioni](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](100) NOT NULL,
	[ID_Zona] [bigint] NOT NULL,
 CONSTRAINT [PK_tb_posizioni] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tb_posizioni]  WITH CHECK ADD  CONSTRAINT [FK_tb_posizioni_tb_zone] FOREIGN KEY([ID_Zona])
REFERENCES [dbo].[tb_zone] ([ID])
GO

ALTER TABLE [dbo].[tb_posizioni] CHECK CONSTRAINT [FK_tb_posizioni_tb_zone]
GO

