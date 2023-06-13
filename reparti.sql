USE [AttivitàManutenzione]
GO

/****** Object:  Table [dbo].[tb_reparti]    Script Date: 13/06/2023 11:01:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_reparti](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](100) NOT NULL,
	[ID_Stabilimento] [bigint] NOT NULL,
 CONSTRAINT [PK_tb_reparti] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tb_reparti]  WITH CHECK ADD  CONSTRAINT [FK_tb_reparti_tb_stabilimenti] FOREIGN KEY([ID_Stabilimento])
REFERENCES [dbo].[tb_stabilimenti] ([ID])
GO

ALTER TABLE [dbo].[tb_reparti] CHECK CONSTRAINT [FK_tb_reparti_tb_stabilimenti]
GO

