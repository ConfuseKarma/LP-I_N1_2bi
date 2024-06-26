# Estrutura do Banco de Dados


```sql
CREATE TABLE Usuarios (
    Id INT PRIMARY KEY,
    Nome VARCHAR(MAX),
    CPF VARCHAR(14),
    Telefone VARCHAR(20),
    Email VARCHAR(100),
    Senha VARCHAR(100),
    Endereco VARCHAR(MAX),
    Numero VARCHAR(10),
    Cidade VARCHAR(MAX),
    Estado VARCHAR(2),
    CEP VARCHAR(10),
    isAdmin BIT
);

```

```sql
CREATE TABLE Produtos (
    Id INT PRIMARY KEY,
    Nome NVARCHAR(255) NOT NULL,
    Preco DECIMAL(18, 2) NOT NULL,
    Descricao NVARCHAR(MAX),
    Imagem VARBINARY(MAX) NULL
);
```

```sql
CREATE TABLE Pedidos (
    Id INT PRIMARY KEY,
    UsuarioId INT NOT NULL,
    Data DATETIME NOT NULL,
    CONSTRAINT FK_Pedidos_Usuarios FOREIGN KEY (UsuarioId) REFERENCES Usuarios(Id)
);

```

```sql
CREATE TABLE PedidoItem (
    Id INT PRIMARY KEY,
    PedidoId INT NOT NULL,
    ProdutoId INT NOT NULL,
    Qtde INT NOT NULL,
    CONSTRAINT FK_PedidoItem_Pedido FOREIGN KEY (PedidoId) REFERENCES Pedidos(Id),
    CONSTRAINT FK_PedidoItem_Produto FOREIGN KEY (ProdutoId) REFERENCES Produtos(Id)
);
```

```sql
CREATE TABLE Reviews (
    Id INT PRIMARY KEY,
    ProdutoId INT NOT NULL, 
    UsuarioId INT NOT NULL, 
    Pontuacao INT CHECK (Pontuacao BETWEEN 1 AND 5),
    Descricao NVARCHAR(MAX),   
    DataAvaliacao DATETIME NOT NULL DEFAULT GETDATE(), 
    FOREIGN KEY (ProdutoId) REFERENCES Produtos(Id),
    FOREIGN KEY (UsuarioId) REFERENCES Usuarios(Id) 
);

```

### Stored Procedures de Usuarios

```sql
CREATE PROCEDURE spInsert_Usuarios
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


```

```sql
CREATE PROCEDURE spUpdate_Usuarios
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
```

### Stored Procedures de Produtos

```sql
CREATE PROCEDURE spInsert_Produtos
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
```
```sql
CREATE PROCEDURE spUpdate_Produtos
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
```

```sql
CREATE PROCEDURE spListagem_Produtos
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
```

```sql
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

```


### Stored Procedures de Pedidos

```sql
CREATE PROCEDURE spInsert_Pedidos
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
```

```sql
CREATE PROCEDURE spListarPedidos
AS
BEGIN
    SELECT 
        p.Id AS id,
        p.Data AS DataPedido,
		p.UsuarioId AS UsuarioId,
        u.Nome AS NomeUsuario,
        COUNT(pi.Id) AS QuantidadeProdutos,
        SUM(pr.Preco * pi.Qtde) AS ValorTotal
    FROM 
        Pedidos p
        INNER JOIN Usuarios u ON p.UsuarioId = u.Id
        INNER JOIN PedidoItem pi ON p.Id = pi.PedidoId
        INNER JOIN Produtos pr ON pi.ProdutoId = pr.Id
    GROUP BY 
        p.Id, p.Data, u.Nome, p.UsuarioId
END
```

### Stored Procedures de Pedido item

```sql
CREATE PROCEDURE spInsert_PedidoItem
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
```

## Stored Procedures de Reviews

```sql
CREATE PROCEDURE spInsert_Reviews
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
```

```sql
CREATE PROCEDURE spUpdate_Reviews
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

```

```sql
CREATE PROCEDURE spListarReviewsPorProduto
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
```

```sql
CREATE PROCEDURE spConsultaAvancadaReviews
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
```

## Stored Procedures Genéricas

### sp's Genéricas

```sql
create procedure spDelete
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

create procedure spConsulta
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

create procedure spListagem
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

create procedure spProximoId
(
    @tabela varchar(max)
)
as
begin
    exec('select isnull(max(id) +1, 1) as MAIOR from '
    +@tabela)
end
GO

```
