USE [AttivitàManutenzione]
GO

/****** Object:  Table [dbo].[tb_zone]    Script Date: 13/06/2023 11:01:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_zone](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](100) NOT NULL,
	[ID_Impianto] [bigint] NOT NULL,
 CONSTRAINT [PK_tb_zone] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tb_zone]  WITH CHECK ADD  CONSTRAINT [FK_tb_zone_tb_impianti] FOREIGN KEY([ID_Impianto])
REFERENCES [dbo].[tb_impianti] ([ID])
GO

ALTER TABLE [dbo].[tb_zone] CHECK CONSTRAINT [FK_tb_zone_tb_impianti]
GO

