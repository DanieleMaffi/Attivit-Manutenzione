USE [AttivitàManutenzione]
GO

/****** Object:  Table [dbo].[tb_OdL]    Script Date: 13/06/2023 11:00:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_OdL](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[TimestampInserimento] [datetime] NOT NULL,
	[TimestampModifica] [datetime] NOT NULL,
	[TimestampInizioLavori] [datetime] NOT NULL,
	[TimestampFineLavori] [datetime] NOT NULL,
	[DescrizioneLavori] [nvarchar](500) NOT NULL,
	[LavoriEseguiti] [nvarchar](500) NOT NULL,
	[Stato] [int] NOT NULL,
	[ID_Posizione] [bigint] NOT NULL,
	[Tipo] [int] NOT NULL,
	[ID_Richiedente] [bigint] NOT NULL,
	[ID_Preposto] [bigint] NULL,
	[ID_UtenteApprovazione] [bigint] NULL,
 CONSTRAINT [PK_tb_OdL] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tb_OdL] ADD  CONSTRAINT [DF_tb_OdL_TimestampInserimento]  DEFAULT (getdate()) FOR [TimestampInserimento]
GO

ALTER TABLE [dbo].[tb_OdL] ADD  CONSTRAINT [DF_tb_OdL_TimestampModifica]  DEFAULT (getdate()) FOR [TimestampModifica]
GO

ALTER TABLE [dbo].[tb_OdL] ADD  CONSTRAINT [DF_tb_OdL_TimestampInizioLavori]  DEFAULT (getdate()) FOR [TimestampInizioLavori]
GO

ALTER TABLE [dbo].[tb_OdL] ADD  CONSTRAINT [DF_tb_OdL_TimestampFineLavori]  DEFAULT (getdate()) FOR [TimestampFineLavori]
GO

ALTER TABLE [dbo].[tb_OdL] ADD  CONSTRAINT [DF_tb_OdL_LavoriEseguiti]  DEFAULT ((0)) FOR [LavoriEseguiti]
GO

ALTER TABLE [dbo].[tb_OdL] ADD  CONSTRAINT [DF_tb_OdL_Stato]  DEFAULT ((10)) FOR [Stato]
GO

ALTER TABLE [dbo].[tb_OdL] ADD  CONSTRAINT [DF_tb_OdL_Priorità]  DEFAULT ((0)) FOR [Tipo]
GO

ALTER TABLE [dbo].[tb_OdL]  WITH CHECK ADD  CONSTRAINT [FK_tb_OdL_tb_posizioni] FOREIGN KEY([ID_Posizione])
REFERENCES [dbo].[tb_posizioni] ([ID])
GO

ALTER TABLE [dbo].[tb_OdL] CHECK CONSTRAINT [FK_tb_OdL_tb_posizioni]
GO

ALTER TABLE [dbo].[tb_OdL]  WITH CHECK ADD  CONSTRAINT [FK_tb_OdL_tb_risorse_ID_Approvazione] FOREIGN KEY([ID_UtenteApprovazione])
REFERENCES [dbo].[tb_risorse] ([ID])
GO

ALTER TABLE [dbo].[tb_OdL] CHECK CONSTRAINT [FK_tb_OdL_tb_risorse_ID_Approvazione]
GO

ALTER TABLE [dbo].[tb_OdL]  WITH CHECK ADD  CONSTRAINT [FK_tb_OdL_tb_risorse_preposto] FOREIGN KEY([ID_Preposto])
REFERENCES [dbo].[tb_risorse] ([ID])
GO

ALTER TABLE [dbo].[tb_OdL] CHECK CONSTRAINT [FK_tb_OdL_tb_risorse_preposto]
GO

ALTER TABLE [dbo].[tb_OdL]  WITH CHECK ADD  CONSTRAINT [FK_tb_OdL_tb_risorse_richiedente] FOREIGN KEY([ID_Richiedente])
REFERENCES [dbo].[tb_risorse] ([ID])
GO

ALTER TABLE [dbo].[tb_OdL] CHECK CONSTRAINT [FK_tb_OdL_tb_risorse_richiedente]
GO

