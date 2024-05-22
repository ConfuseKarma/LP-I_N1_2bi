USE [master]
GO
/****** Object:  Database [Ecommerce]    Script Date: 22/05/2024 11:48:59 ******/
CREATE DATABASE [Ecommerce]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Ecommerce', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Ecommerce.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Ecommerce_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Ecommerce_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Ecommerce] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Ecommerce].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Ecommerce] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Ecommerce] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Ecommerce] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Ecommerce] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Ecommerce] SET ARITHABORT OFF 
GO
ALTER DATABASE [Ecommerce] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Ecommerce] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Ecommerce] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Ecommerce] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Ecommerce] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Ecommerce] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Ecommerce] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Ecommerce] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Ecommerce] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Ecommerce] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Ecommerce] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Ecommerce] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Ecommerce] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Ecommerce] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Ecommerce] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Ecommerce] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Ecommerce] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Ecommerce] SET RECOVERY FULL 
GO
ALTER DATABASE [Ecommerce] SET  MULTI_USER 
GO
ALTER DATABASE [Ecommerce] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Ecommerce] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Ecommerce] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Ecommerce] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Ecommerce] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Ecommerce] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Ecommerce', N'ON'
GO
ALTER DATABASE [Ecommerce] SET QUERY_STORE = ON
GO
ALTER DATABASE [Ecommerce] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Ecommerce]
GO
/****** Object:  Table [dbo].[PedidoItem]    Script Date: 22/05/2024 11:48:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PedidoItem](
	[Id] [int] NOT NULL,
	[PedidoId] [int] NOT NULL,
	[ProdutoId] [int] NOT NULL,
	[Qtde] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pedidos]    Script Date: 22/05/2024 11:48:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedidos](
	[Id] [int] NOT NULL,
	[UsuarioId] [int] NOT NULL,
	[Data] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Produtos]    Script Date: 22/05/2024 11:48:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Produtos](
	[Id] [int] NOT NULL,
	[Nome] [nvarchar](255) NOT NULL,
	[Preco] [decimal](18, 2) NOT NULL,
	[Descricao] [nvarchar](max) NULL,
	[Imagem] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 22/05/2024 11:48:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[Id] [int] NOT NULL,
	[ProdutoId] [int] NOT NULL,
	[UsuarioId] [int] NOT NULL,
	[Pontuacao] [int] NULL,
	[Descricao] [nvarchar](max) NULL,
	[DataAvaliacao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 22/05/2024 11:48:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[Id] [int] NOT NULL,
	[Nome] [varchar](max) NULL,
	[CPF] [varchar](14) NULL,
	[Telefone] [varchar](20) NULL,
	[Email] [varchar](100) NULL,
	[Senha] [varchar](100) NULL,
	[Endereco] [varchar](max) NULL,
	[Numero] [varchar](10) NULL,
	[Cidade] [varchar](max) NULL,
	[Estado] [varchar](2) NULL,
	[CEP] [varchar](10) NULL,
	[isAdmin] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Reviews] ADD  DEFAULT (getdate()) FOR [DataAvaliacao]
GO
ALTER TABLE [dbo].[PedidoItem]  WITH CHECK ADD  CONSTRAINT [FK_PedidoItem_Pedido] FOREIGN KEY([PedidoId])
REFERENCES [dbo].[Pedidos] ([Id])
GO
ALTER TABLE [dbo].[PedidoItem] CHECK CONSTRAINT [FK_PedidoItem_Pedido]
GO
ALTER TABLE [dbo].[PedidoItem]  WITH CHECK ADD  CONSTRAINT [FK_PedidoItem_Produto] FOREIGN KEY([ProdutoId])
REFERENCES [dbo].[Produtos] ([Id])
GO
ALTER TABLE [dbo].[PedidoItem] CHECK CONSTRAINT [FK_PedidoItem_Produto]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [FK_Pedidos_Usuarios] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK_Pedidos_Usuarios]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD FOREIGN KEY([ProdutoId])
REFERENCES [dbo].[Produtos] ([Id])
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD CHECK  (([Pontuacao]>=(1) AND [Pontuacao]<=(5)))
GO
/****** Object:  StoredProcedure [dbo].[spConsulta]    Script Date: 22/05/2024 11:48:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[spConsulta]
(
    @id int ,
    @tabela varchar(max)
)
as
begin
    declare @sql varchar(max);
    set @sql = 'select * from ' + @tabela +
    ' where id = ' + cast(@id as varchar(max))
    exec(@sql)
end
GO
/****** Object:  StoredProcedure [dbo].[spConsultaAvancadaProdutos]    Script Date: 22/05/2024 11:48:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spConsultaAvancadaProdutos]
(
    @nome NVARCHAR(255),
    @analises INT,
    @precoMenor DECIMAL(18, 2),
    @precoMaior DECIMAL(18, 2)
)
AS
BEGIN
    SELECT 
        p.*,
        COUNT(r.Id) AS NumeroAvaliacao,
        COALESCE(ROUND(AVG(CAST(r.Pontuacao AS DECIMAL(10, 2))), 2), 0) AS Avaliacao
    FROM 
        Produtos p
    LEFT JOIN 
        Reviews r ON p.Id = r.ProdutoId
    WHERE 
        p.Nome LIKE '%' + @nome + '%' AND
        p.Preco BETWEEN @precoMenor AND @precoMaior
    GROUP BY 
        p.Id, p.Nome, p.Preco, p.Descricao, p.Imagem
    ORDER BY
        CASE WHEN @analises = 1 THEN COALESCE(ROUND(AVG(CAST(r.Pontuacao AS DECIMAL(10, 2))), 2), 0) END DESC,
        CASE WHEN @analises = 2 THEN COALESCE(ROUND(AVG(CAST(r.Pontuacao AS DECIMAL(10, 2))), 2), 0) END ASC;
END
GO
/****** Object:  StoredProcedure [dbo].[spConsultaAvancadaReviews]    Script Date: 22/05/2024 11:48:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spConsultaAvancadaReviews]
    @produtoId INT = NULL,
    @nomeUsuario NVARCHAR(100) = NULL,
    @pontuacao INT = NULL,
	@periodo INT = NULL
AS
BEGIN
    SELECT 
        r.Id,
        r.ProdutoId,
        p.Nome AS NomeProduto,
        r.UsuarioId,
        u.Nome AS NomeUsuario,
        r.Pontuacao,
        r.Descricao,
        r.DataAvaliacao
    FROM 
        Reviews r
    JOIN 
        Produtos p ON r.ProdutoId = p.Id
    JOIN 
        Usuarios u ON r.UsuarioId = u.Id
    WHERE 
        (@produtoId IS NULL OR r.ProdutoId = @produtoId) AND
        (@nomeUsuario IS NULL OR u.Nome LIKE '%' + @nomeUsuario + '%') AND
        (@pontuacao IS NULL OR r.Pontuacao = @pontuacao)
    ORDER BY 
        CASE 
            WHEN @periodo = 1 THEN r.DataAvaliacao END DESC,
        CASE 
            WHEN @periodo = 2 THEN r.DataAvaliacao END ASC;
END;
GO
/****** Object:  StoredProcedure [dbo].[spDelete]    Script Date: 22/05/2024 11:48:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spDelete]
(
    @id int ,
    @tabela varchar(max)
)
as
begin
    declare @sql varchar(max);
    set @sql = ' delete ' + @tabela +
    ' where id = ' + cast(@id as varchar(max))
    exec(@sql)
end
GO
/****** Object:  StoredProcedure [dbo].[spInsert_PedidoItem]    Script Date: 22/05/2024 11:48:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spInsert_PedidoItem]
(
    @id INT,
    @pedidoId INT,
    @produtoId INT,
    @qtde INT
)
AS
BEGIN
    INSERT INTO PedidoItem (Id, PedidoId, ProdutoId, Qtde)
    VALUES (@id, @pedidoId, @produtoId, @qtde);
END
GO
/****** Object:  StoredProcedure [dbo].[spInsert_Pedidos]    Script Date: 22/05/2024 11:48:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spInsert_Pedidos]
(
    @id INT,
    @usuarioId INT,
    @data DATETIME
)
AS
BEGIN
    INSERT INTO Pedidos (Id, UsuarioId, Data)
    VALUES (@id, @usuarioId, @data);
END
GO
/****** Object:  StoredProcedure [dbo].[spInsert_Produtos]    Script Date: 22/05/2024 11:48:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spInsert_Produtos]
(
    @Id INT,
    @Nome NVARCHAR(255),
    @Preco DECIMAL(18, 2),
    @Descricao NVARCHAR(MAX),
    @Imagem VARBINARY(MAX) NULL
)
AS
BEGIN
    INSERT INTO Produtos
    (Id, Nome, Preco, Descricao, Imagem)
    VALUES
    (@Id, @Nome, @Preco, @Descricao, @Imagem)
END
GO
/****** Object:  StoredProcedure [dbo].[spInsert_Reviews]    Script Date: 22/05/2024 11:48:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spInsert_Reviews]
(
    @Id INT,
    @ProdutoId INT,
    @UsuarioId INT,
    @Pontuacao INT,
    @Descricao NVARCHAR(MAX)
)
AS
BEGIN
    -- Insere a nova review na tabela Reviews
    INSERT INTO Reviews
    (Id, ProdutoId, UsuarioId, Pontuacao, Descricao, DataAvaliacao)
    VALUES
    (@Id, @ProdutoId, @UsuarioId, @Pontuacao, @Descricao, GETDATE());
END
GO
/****** Object:  StoredProcedure [dbo].[spInsert_Usuarios]    Script Date: 22/05/2024 11:48:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spInsert_Usuarios]
(
    @id INT,
    @nome VARCHAR(MAX),
    @cpf VARCHAR(14),
    @telefone VARCHAR(20),
    @email VARCHAR(100),
    @endereco VARCHAR(MAX),
    @numero VARCHAR(10),
    @cidade VARCHAR(MAX),
    @estado VARCHAR(2),
    @cep VARCHAR(10),
    @senha VARCHAR(100),
    @isAdmin BIT
)
AS
BEGIN
    INSERT INTO Usuarios
    (id, nome, cpf, telefone, email, endereco, numero, cidade, estado, cep, senha, isAdmin)
    VALUES
    (@id, @nome, @cpf, @telefone, @email, @endereco, @numero, @cidade, @estado, @cep, @senha, @isAdmin);
END
GO
/****** Object:  StoredProcedure [dbo].[spListagem]    Script Date: 22/05/2024 11:48:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[spListagem]
(
    @tabela varchar(max),
    @ordem varchar(max)
)
as
begin
    exec('select * from ' + @tabela +
    ' order by ' + @ordem)
end
GO
/****** Object:  StoredProcedure [dbo].[spListagem_Produtos]    Script Date: 22/05/2024 11:48:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListagem_Produtos]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.*,
        COUNT(r.Id) AS NumeroAvaliacao,
        COALESCE(ROUND(AVG(CAST(r.Pontuacao AS DECIMAL(10, 2))), 2), 0) AS Avaliacao
    FROM 
        Produtos p
    LEFT JOIN 
        Reviews r ON p.Id = r.ProdutoId
    GROUP BY 
        p.Id, p.Nome, p.Preco, p.Descricao, p.Imagem;
END;
GO
/****** Object:  StoredProcedure [dbo].[spListarReviewsPorProduto]    Script Date: 22/05/2024 11:48:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListarReviewsPorProduto]
    @ProdutoId INT
AS
BEGIN
    SELECT 
        R.*,
        U.Nome AS NomeUsuario,
        P.Nome AS NomeProduto
    FROM 
        Reviews R
    INNER JOIN 
        Usuarios U ON R.UsuarioId = U.Id
    INNER JOIN 
        Produtos P ON R.ProdutoId = P.Id
    WHERE 
        R.ProdutoId = @ProdutoId
    ORDER BY 
        R.DataAvaliacao DESC;  -- Ordena as reviews pela data de avaliação em ordem decrescente
END;
GO
/****** Object:  StoredProcedure [dbo].[spProximoId]    Script Date: 22/05/2024 11:48:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[spProximoId]
(
    @tabela varchar(max)
)
as
begin
    exec('select isnull(max(id) +1, 1) as MAIOR from '
    +@tabela)
end
GO
/****** Object:  StoredProcedure [dbo].[spUpdate_Produtos]    Script Date: 22/05/2024 11:48:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spUpdate_Produtos]
(
    @Id INT,
    @Nome NVARCHAR(255),
    @Preco DECIMAL(18, 2),
    @Descricao NVARCHAR(MAX),
    @Imagem VARBINARY(MAX) NULL
)
AS
BEGIN
    UPDATE Produtos SET
    Nome = @Nome,
    Preco = @Preco,
    Descricao = @Descricao,
    Imagem = @Imagem
    WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdate_Reviews]    Script Date: 22/05/2024 11:48:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spUpdate_Reviews]
(
    @Id INT,
    @ProdutoId INT,
    @UsuarioId INT,
    @Pontuacao INT,
    @Descricao NVARCHAR(MAX)
)
AS
BEGIN
    -- Atualiza os dados da review na tabela Reviews
    UPDATE Reviews
    SET
        ProdutoId = @ProdutoId,
        UsuarioId = @UsuarioId,
        Pontuacao = @Pontuacao,
        Descricao = @Descricao,
        DataAvaliacao = GETDATE()  -- Atualiza a data de avaliação para a data atual
    WHERE Id = @Id;
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdate_Usuarios]    Script Date: 22/05/2024 11:48:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spUpdate_Usuarios]
(
    @id INT,
    @nome VARCHAR(MAX),
    @cpf VARCHAR(14),
    @telefone VARCHAR(20),
    @email VARCHAR(100),
    @endereco VARCHAR(MAX),
    @cidade VARCHAR(MAX),
    @estado VARCHAR(2),
    @cep VARCHAR(10),
    @senha VARCHAR(100),
    @isAdmin BIT
)
AS
BEGIN
    UPDATE Usuarios SET
    nome = @nome,
    cpf = @cpf,
    telefone = @telefone,
    email = @email,
    endereco = @endereco,
    cidade = @cidade,
    estado = @estado,
    cep = @cep,
    senha = @senha,
    isAdmin = @isAdmin 
    WHERE id = @id;
END
GO
INSERT INTO Usuarios (
    Id, Nome, CPF, Telefone, Email, Senha, Endereco, Numero, Cidade, Estado, CEP, isAdmin
) VALUES (
    1, 
    'João da Silva', 
    '123.456.789-00', 
    '(11) 91234-5678', 
    'admin@example.com', 
    '123', 
    'Rua das Flores', 
    '123', 
    'São Paulo', 
    'SP', 
    '01001-000', 
    1
);
GO
USE [master]
GO
ALTER DATABASE [Ecommerce] SET  READ_WRITE 
GO
