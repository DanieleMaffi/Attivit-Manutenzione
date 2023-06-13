USE [AttivitàManutenzione]
GO

/****** Object:  Table [dbo].[tb_impianti]    Script Date: 13/06/2023 11:00:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_impianti](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](100) NOT NULL,
	[ID_Reparto] [bigint] NOT NULL,
 CONSTRAINT [PK_tb_impianti] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tb_impianti]  WITH CHECK ADD  CONSTRAINT [FK_tb_impianti_tb_reparti] FOREIGN KEY([ID_Reparto])
REFERENCES [dbo].[tb_reparti] ([ID])
GO

ALTER TABLE [dbo].[tb_impianti] CHECK CONSTRAINT [FK_tb_impianti_tb_reparti]
GO

