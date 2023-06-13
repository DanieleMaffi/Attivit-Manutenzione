USE [AttivitàManutenzione]
GO

/****** Object:  Table [dbo].[tb_risorse]    Script Date: 13/06/2023 11:01:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_risorse](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](100) NOT NULL,
	[Cognome] [nvarchar](100) NOT NULL,
	[ID_Azienda] [bigint] NOT NULL,
	[Note] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[ConsentiAccessoProgramma] [bit] NOT NULL,
	[ConsentiAccessoImpostazioni] [bit] NOT NULL,
	[ConsentiAccessoScadenze] [bit] NOT NULL,
	[ConsentiAccessoReport] [bit] NOT NULL,
 CONSTRAINT [PK_tb_risorse] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tb_risorse]  WITH CHECK ADD  CONSTRAINT [FK_tb_risorse_tb_aziende] FOREIGN KEY([ID_Azienda])
REFERENCES [dbo].[tb_aziende] ([ID])
GO

ALTER TABLE [dbo].[tb_risorse] CHECK CONSTRAINT [FK_tb_risorse_tb_aziende]
GO

