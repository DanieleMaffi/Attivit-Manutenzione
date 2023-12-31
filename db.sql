CREATE DATABASE AttivitaManutenzione 
GO
USE [AttivitaManutenzione]
GO
/****** Object:  Table [dbo].[tb_OdL]    Script Date: 9/4/2023 10:05:09 AM ******/
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
	[DescrizioneLavori] [nvarchar](2048) NOT NULL,
	[LavoriEseguiti] [nvarchar](2048) NOT NULL,
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
/****** Object:  Table [dbo].[tb_aziende]    Script Date: 9/4/2023 10:05:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_aziende](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](100) NOT NULL,
	[Indirizzo] [nvarchar](100) NOT NULL,
	[Note] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_tb_aziende] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_reparti]    Script Date: 9/4/2023 10:05:09 AM ******/
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
/****** Object:  Table [dbo].[tb_impianti]    Script Date: 9/4/2023 10:05:09 AM ******/
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
/****** Object:  Table [dbo].[tb_zone]    Script Date: 9/4/2023 10:05:09 AM ******/
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
/****** Object:  Table [dbo].[tb_posizioni]    Script Date: 9/4/2023 10:05:09 AM ******/
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
/****** Object:  Table [dbo].[tb_risorse]    Script Date: 9/4/2023 10:05:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_risorse](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](100) NOT NULL,
	[Cognome] [nvarchar](100) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
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
/****** Object:  View [dbo].[vw_OdL_WinForm]    Script Date: 9/4/2023 10:05:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_OdL_WinForm]
AS
SELECT        dbo.tb_OdL.ID, dbo.tb_OdL.TimestampInserimento, dbo.tb_OdL.TimestampModifica, dbo.tb_OdL.TimestampInizioLavori, dbo.tb_OdL.DescrizioneLavori, dbo.tb_OdL.LavoriEseguiti, dbo.tb_OdL.TimestampFineLavori, 
                         dbo.tb_OdL.Stato, dbo.tb_OdL.Tipo, dbo.tb_posizioni.Nome AS Posizione, dbo.tb_impianti.Nome AS Impianto, dbo.tb_reparti.Nome AS Reparto, dbo.tb_risorse.Cognome AS Richiedente, 
                         dbo.tb_aziende.Nome AS AziendaRichiedente, dbo.tb_zone.Nome AS Zona
FROM            dbo.tb_zone INNER JOIN
                         dbo.tb_OdL INNER JOIN
                         dbo.tb_posizioni ON dbo.tb_OdL.ID_Posizione = dbo.tb_posizioni.ID ON dbo.tb_zone.ID = dbo.tb_posizioni.ID_Zona INNER JOIN
                         dbo.tb_reparti INNER JOIN
                         dbo.tb_impianti ON dbo.tb_reparti.ID = dbo.tb_impianti.ID_Reparto ON dbo.tb_zone.ID_Impianto = dbo.tb_impianti.ID INNER JOIN
                         dbo.tb_risorse ON dbo.tb_OdL.ID_Richiedente = dbo.tb_risorse.ID INNER JOIN
                         dbo.tb_aziende ON dbo.tb_risorse.ID_Azienda = dbo.tb_aziende.ID
GO
/****** Object:  Table [dbo].[tb_stabilimenti]    Script Date: 9/4/2023 10:05:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_stabilimenti](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_tb_stabilimenti] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_OdL_WEB]    Script Date: 9/4/2023 10:05:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_OdL_WEB]
AS
SELECT        dbo.tb_OdL.ID, LEFT(CONVERT(varchar, dbo.tb_OdL.TimestampInserimento, 29), 16) AS Inserimento, LEFT(CONVERT(varchar, dbo.tb_OdL.TimestampModifica, 29), 16) AS Modifica, LEFT(CONVERT(varchar, 
                         dbo.tb_OdL.TimestampInizioLavori, 29), 16) AS InizioLavori, dbo.tb_OdL.DescrizioneLavori, dbo.tb_OdL.LavoriEseguiti, LEFT(CONVERT(varchar, dbo.tb_OdL.TimestampFineLavori, 29), 16) AS FineLavori, dbo.tb_OdL.Stato, 
                         dbo.tb_OdL.Tipo, dbo.tb_posizioni.Nome AS Posizione, dbo.tb_impianti.Nome AS Impianto, dbo.tb_reparti.Nome AS Reparto, dbo.tb_risorse.ID AS Richiedente, dbo.tb_zone.Nome AS Zona, 
                         dbo.tb_stabilimenti.Nome AS Stabilimento
FROM            dbo.tb_zone INNER JOIN
                         dbo.tb_OdL INNER JOIN
                         dbo.tb_posizioni ON dbo.tb_OdL.ID_Posizione = dbo.tb_posizioni.ID ON dbo.tb_zone.ID = dbo.tb_posizioni.ID_Zona INNER JOIN
                         dbo.tb_reparti INNER JOIN
                         dbo.tb_impianti ON dbo.tb_reparti.ID = dbo.tb_impianti.ID_Reparto ON dbo.tb_zone.ID_Impianto = dbo.tb_impianti.ID INNER JOIN
                         dbo.tb_risorse ON dbo.tb_OdL.ID_Richiedente = dbo.tb_risorse.ID INNER JOIN
                         dbo.tb_aziende ON dbo.tb_risorse.ID_Azienda = dbo.tb_aziende.ID INNER JOIN
                         dbo.tb_stabilimenti ON dbo.tb_reparti.ID_Stabilimento = dbo.tb_stabilimenti.ID
GO
/****** Object:  Table [dbo].[tb_scadenze]    Script Date: 9/4/2023 10:05:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_scadenze](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Descrizione] [nvarchar](500) NOT NULL,
	[ID_Posizione] [bigint] NOT NULL,
	[Scadenza] [date] NOT NULL,
	[IndirizziEmail] [nvarchar](500) NOT NULL,
	[GiorniAnticipoNotificaMail] [int] NOT NULL,
	[FlagNotificata] [bit] NOT NULL,
 CONSTRAINT [PK_tb_scadenze] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_notificaScadenze]    Script Date: 9/4/2023 10:05:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_notificaScadenze]
AS
SELECT        dbo.tb_stabilimenti.Nome AS NomeStabilimento, dbo.tb_reparti.Nome AS NomeReparto, dbo.tb_impianti.Nome AS NomeImpianto, dbo.tb_zone.Nome AS NomeZona, dbo.tb_posizioni.Nome AS NomePosizione, 
                         dbo.tb_scadenze.Scadenza, dbo.tb_scadenze.IndirizziEmail, dbo.tb_scadenze.Descrizione, dbo.tb_scadenze.ID
FROM            dbo.tb_scadenze INNER JOIN
                         dbo.tb_posizioni ON dbo.tb_scadenze.ID_Posizione = dbo.tb_posizioni.ID INNER JOIN
                         dbo.tb_zone ON dbo.tb_posizioni.ID_Zona = dbo.tb_zone.ID INNER JOIN
                         dbo.tb_impianti ON dbo.tb_zone.ID_Impianto = dbo.tb_impianti.ID INNER JOIN
                         dbo.tb_reparti ON dbo.tb_impianti.ID_Reparto = dbo.tb_reparti.ID INNER JOIN
                         dbo.tb_stabilimenti ON dbo.tb_reparti.ID_Stabilimento = dbo.tb_stabilimenti.ID
WHERE        (YEAR(dbo.tb_scadenze.Scadenza) <= YEAR(DATEADD(day, dbo.tb_scadenze.GiorniAnticipoNotificaMail, GETDATE()))) AND (DAY(dbo.tb_scadenze.Scadenza) <= DAY(DATEADD(day, dbo.tb_scadenze.GiorniAnticipoNotificaMail, 
                         GETDATE()))) AND (MONTH(dbo.tb_scadenze.Scadenza) <= MONTH(DATEADD(day, dbo.tb_scadenze.GiorniAnticipoNotificaMail, GETDATE()))) AND (dbo.tb_scadenze.FlagNotificata = 0)
GO
/****** Object:  Table [dbo].[tb_OdL_Risorse]    Script Date: 9/4/2023 10:05:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_OdL_Risorse](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ID_Risorsa] [bigint] NOT NULL,
	[Ore] [float] NOT NULL,
	[ID_OdL] [bigint] NOT NULL,
 CONSTRAINT [PK_tb_OdL_Risorse] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_reportRisorse]    Script Date: 9/4/2023 10:05:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_reportRisorse]
AS
SELECT        dbo.tb_OdL.TimestampInizioLavori, dbo.tb_OdL.DescrizioneLavori, dbo.tb_OdL.LavoriEseguiti, dbo.tb_OdL.Stato, dbo.tb_OdL_Risorse.Ore, dbo.tb_OdL_Risorse.ID, dbo.tb_OdL_Risorse.ID_Risorsa, 
                         dbo.tb_OdL.ID AS ID_OdL
FROM            dbo.tb_OdL_Risorse INNER JOIN
                         dbo.tb_OdL ON dbo.tb_OdL_Risorse.ID_OdL = dbo.tb_OdL.ID
GO
/****** Object:  View [dbo].[vw_reportRichiedenti]    Script Date: 9/4/2023 10:05:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_reportRichiedenti]
AS
SELECT        TimestampInizioLavori, DescrizioneLavori, LavoriEseguiti, Stato, ID AS ID_OdL, ID_Richiedente
FROM            dbo.tb_OdL
GO
/****** Object:  Table [dbo].[tb_AllegatiOdL]    Script Date: 9/4/2023 10:05:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_AllegatiOdL](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ID_OdL] [bigint] NOT NULL,
	[NomeFile] [nvarchar](100) NOT NULL,
	[Data] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_tb_AllegatiOdL] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_bufferMail]    Script Date: 9/4/2023 10:05:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_bufferMail](
	[ID_OdL] [bigint] NOT NULL,
	[Email] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_cambioPassword]    Script Date: 9/4/2023 10:05:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_cambioPassword](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ID_Richiedente] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_email_admin]    Script Date: 9/4/2023 10:05:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_email_admin](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_tb_email_admin] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_info_client]    Script Date: 9/4/2023 10:05:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_info_client](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ComputerName] [nvarchar](50) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[InfoOSFullName] [nvarchar](50) NOT NULL,
	[OSPlatform] [nvarchar](50) NOT NULL,
	[OSVersion] [nvarchar](50) NOT NULL,
	[ClientVersion] [nvarchar](50) NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
	[Gruppo] [int] NOT NULL,
	[ForzaRiavvio] [int] NOT NULL,
 CONSTRAINT [PK_tb_version_client] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_log]    Script Date: 9/4/2023 10:05:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_log](
	[Timestamp] [datetime] NOT NULL,
	[Category] [char](30) NOT NULL,
	[Message] [nvarchar](300) NOT NULL,
	[IsError] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_MaterialiOdL]    Script Date: 9/4/2023 10:05:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_MaterialiOdL](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ID_OdL] [bigint] NOT NULL,
	[CodiceSAP] [nvarchar](50) NOT NULL,
	[Descrizione] [nvarchar](100) NOT NULL,
	[Quantità] [float] NOT NULL,
 CONSTRAINT [PK_tb_MaterialiOdL] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_version_client]    Script Date: 9/4/2023 10:05:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_version_client](
	[Versione] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tb_info_client] ADD  CONSTRAINT [DF_tb_info_client_Gruppo]  DEFAULT ((0)) FOR [Gruppo]
GO
ALTER TABLE [dbo].[tb_info_client] ADD  CONSTRAINT [DF_tb_info_client_ForzaRiavvio]  DEFAULT ((0)) FOR [ForzaRiavvio]
GO
ALTER TABLE [dbo].[tb_log] ADD  CONSTRAINT [DF_tb_log_Timestamp]  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[tb_OdL] ADD  CONSTRAINT [DF_tb_OdL_TimestampInserimento]  DEFAULT (getdate()) FOR [TimestampInserimento]
GO
ALTER TABLE [dbo].[tb_OdL] ADD  CONSTRAINT [DF_tb_OdL_TimestampModifica]  DEFAULT (getdate()) FOR [TimestampModifica]
GO
ALTER TABLE [dbo].[tb_OdL] ADD  CONSTRAINT [DF_tb_OdL_TimestampInizioLavori]  DEFAULT (getdate()) FOR [TimestampInizioLavori]
GO
ALTER TABLE [dbo].[tb_OdL] ADD  CONSTRAINT [DF_tb_OdL_TimestampFineLavori]  DEFAULT (getdate()) FOR [TimestampFineLavori]
GO
ALTER TABLE [dbo].[tb_OdL] ADD  CONSTRAINT [DF_tb_OdL_LavoriEseguiti]  DEFAULT (N'ND') FOR [LavoriEseguiti]
GO
ALTER TABLE [dbo].[tb_OdL] ADD  CONSTRAINT [DF_tb_OdL_Stato]  DEFAULT ((10)) FOR [Stato]
GO
ALTER TABLE [dbo].[tb_OdL] ADD  CONSTRAINT [DF_tb_OdL_Priorità]  DEFAULT ((0)) FOR [Tipo]
GO
ALTER TABLE [dbo].[tb_scadenze] ADD  CONSTRAINT [DF_tb_scadenze_FlagNotificata]  DEFAULT ((0)) FOR [FlagNotificata]
GO
ALTER TABLE [dbo].[tb_AllegatiOdL]  WITH CHECK ADD  CONSTRAINT [FK_tb_AllegatiOdL_tb_OdL] FOREIGN KEY([ID_OdL])
REFERENCES [dbo].[tb_OdL] ([ID])
GO
ALTER TABLE [dbo].[tb_AllegatiOdL] CHECK CONSTRAINT [FK_tb_AllegatiOdL_tb_OdL]
GO
ALTER TABLE [dbo].[tb_cambioPassword]  WITH CHECK ADD  CONSTRAINT [FK_tb_cambioPassword_tb_risorse] FOREIGN KEY([ID_Richiedente])
REFERENCES [dbo].[tb_risorse] ([ID])
GO
ALTER TABLE [dbo].[tb_cambioPassword] CHECK CONSTRAINT [FK_tb_cambioPassword_tb_risorse]
GO
ALTER TABLE [dbo].[tb_impianti]  WITH CHECK ADD  CONSTRAINT [FK_tb_impianti_tb_reparti] FOREIGN KEY([ID_Reparto])
REFERENCES [dbo].[tb_reparti] ([ID])
GO
ALTER TABLE [dbo].[tb_impianti] CHECK CONSTRAINT [FK_tb_impianti_tb_reparti]
GO
ALTER TABLE [dbo].[tb_MaterialiOdL]  WITH CHECK ADD  CONSTRAINT [FK_tb_MaterialiOdL_tb_OdL] FOREIGN KEY([ID_OdL])
REFERENCES [dbo].[tb_OdL] ([ID])
GO
ALTER TABLE [dbo].[tb_MaterialiOdL] CHECK CONSTRAINT [FK_tb_MaterialiOdL_tb_OdL]
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
ALTER TABLE [dbo].[tb_OdL_Risorse]  WITH CHECK ADD  CONSTRAINT [FK_tb_OdL_Risorse_tb_OdL] FOREIGN KEY([ID_OdL])
REFERENCES [dbo].[tb_OdL] ([ID])
GO
ALTER TABLE [dbo].[tb_OdL_Risorse] CHECK CONSTRAINT [FK_tb_OdL_Risorse_tb_OdL]
GO
ALTER TABLE [dbo].[tb_OdL_Risorse]  WITH CHECK ADD  CONSTRAINT [FK_tb_OdL_Risorse_tb_OdL_Risorse] FOREIGN KEY([ID])
REFERENCES [dbo].[tb_OdL_Risorse] ([ID])
GO
ALTER TABLE [dbo].[tb_OdL_Risorse] CHECK CONSTRAINT [FK_tb_OdL_Risorse_tb_OdL_Risorse]
GO
ALTER TABLE [dbo].[tb_posizioni]  WITH CHECK ADD  CONSTRAINT [FK_tb_posizioni_tb_zone] FOREIGN KEY([ID_Zona])
REFERENCES [dbo].[tb_zone] ([ID])
GO
ALTER TABLE [dbo].[tb_posizioni] CHECK CONSTRAINT [FK_tb_posizioni_tb_zone]
GO
ALTER TABLE [dbo].[tb_reparti]  WITH CHECK ADD  CONSTRAINT [FK_tb_reparti_tb_stabilimenti] FOREIGN KEY([ID_Stabilimento])
REFERENCES [dbo].[tb_stabilimenti] ([ID])
GO
ALTER TABLE [dbo].[tb_reparti] CHECK CONSTRAINT [FK_tb_reparti_tb_stabilimenti]
GO
ALTER TABLE [dbo].[tb_risorse]  WITH CHECK ADD  CONSTRAINT [FK_tb_risorse_tb_aziende] FOREIGN KEY([ID_Azienda])
REFERENCES [dbo].[tb_aziende] ([ID])
GO
ALTER TABLE [dbo].[tb_risorse] CHECK CONSTRAINT [FK_tb_risorse_tb_aziende]
GO
ALTER TABLE [dbo].[tb_scadenze]  WITH CHECK ADD  CONSTRAINT [FK_tb_scadenze_tb_posizioni] FOREIGN KEY([ID_Posizione])
REFERENCES [dbo].[tb_posizioni] ([ID])
GO
ALTER TABLE [dbo].[tb_scadenze] CHECK CONSTRAINT [FK_tb_scadenze_tb_posizioni]
GO
ALTER TABLE [dbo].[tb_zone]  WITH CHECK ADD  CONSTRAINT [FK_tb_zone_tb_impianti] FOREIGN KEY([ID_Impianto])
REFERENCES [dbo].[tb_impianti] ([ID])
GO
ALTER TABLE [dbo].[tb_zone] CHECK CONSTRAINT [FK_tb_zone_tb_impianti]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[34] 4[18] 2[29] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tb_scadenze"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 266
               Right = 269
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_posizioni"
            Begin Extent = 
               Top = 3
               Left = 337
               Bottom = 131
               Right = 527
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_zone"
            Begin Extent = 
               Top = 6
               Left = 565
               Bottom = 126
               Right = 755
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_impianti"
            Begin Extent = 
               Top = 6
               Left = 793
               Bottom = 126
               Right = 983
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_reparti"
            Begin Extent = 
               Top = 6
               Left = 1021
               Bottom = 121
               Right = 1211
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_stabilimenti"
            Begin Extent = 
               Top = 6
               Left = 1249
               Bottom = 110
               Right = 1439
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column =' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_notificaScadenze'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' 1440
         Alias = 4230
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_notificaScadenze'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_notificaScadenze'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[19] 4[40] 2[22] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tb_zone"
            Begin Extent = 
               Top = 8
               Left = 506
               Bottom = 121
               Right = 696
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_OdL"
            Begin Extent = 
               Top = 6
               Left = 22
               Bottom = 276
               Right = 235
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_posizioni"
            Begin Extent = 
               Top = 5
               Left = 278
               Bottom = 118
               Right = 468
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_reparti"
            Begin Extent = 
               Top = 6
               Left = 1004
               Bottom = 157
               Right = 1194
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_impianti"
            Begin Extent = 
               Top = 5
               Left = 779
               Bottom = 151
               Right = 969
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_risorse"
            Begin Extent = 
               Top = 139
               Left = 286
               Bottom = 269
               Right = 533
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_aziende"
            Begin Extent = 
               Top = 154
               Left = 592
               Bottom = 284
               Right = 782
            End
            Disp' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_OdL_WEB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'layFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_stabilimenti"
            Begin Extent = 
               Top = 12
               Left = 1244
               Bottom = 168
               Right = 1434
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 5805
         Alias = 2325
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_OdL_WEB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_OdL_WEB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[35] 4[31] 2[23] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tb_zone"
            Begin Extent = 
               Top = 139
               Left = 510
               Bottom = 253
               Right = 700
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_OdL"
            Begin Extent = 
               Top = 4
               Left = 0
               Bottom = 297
               Right = 211
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_posizioni"
            Begin Extent = 
               Top = 140
               Left = 295
               Bottom = 261
               Right = 485
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_reparti"
            Begin Extent = 
               Top = 135
               Left = 982
               Bottom = 260
               Right = 1172
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_impianti"
            Begin Extent = 
               Top = 140
               Left = 756
               Bottom = 262
               Right = 946
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_risorse"
            Begin Extent = 
               Top = 262
               Left = 293
               Bottom = 415
               Right = 483
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_aziende"
            Begin Extent = 
               Top = 265
               Left = 504
               Bottom = 395
               Right = 694
            End
          ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_OdL_WinForm'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'  DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3915
         Alias = 2760
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_OdL_WinForm'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_OdL_WinForm'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[24] 2[17] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tb_OdL"
            Begin Extent = 
               Top = 6
               Left = 266
               Bottom = 292
               Right = 479
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_reportRichiedenti'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_reportRichiedenti'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[43] 4[37] 2[5] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tb_OdL_Risorse"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 277
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_OdL"
            Begin Extent = 
               Top = 6
               Left = 266
               Bottom = 294
               Right = 479
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 4350
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_reportRisorse'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_reportRisorse'
GO
INSERT INTO tb_aziende VALUES ('test', '', '');
INSERT INTO tb_risorse VALUES ('test', 'test', 'test', 1, '', 'email@email.com', 'C4CA4238A0B923820DCC509A6F75849B', 1, 1, 1 ,1)
GO
