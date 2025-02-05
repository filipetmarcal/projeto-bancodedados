# Documentação do Banco de Dados

## Visão Geral

Esse banco de dados foi desenvolvido para gerenciar informações relacionadas a **clientes**, **contas**, **pagamentos** e **entregas**. Ele permite registrar e consultar dados de clientes, associar múltiplas contas a um cliente, registrar diversas formas de pagamento por conta e gerenciar o status das entregas de cada conta.

## Estrutura do Banco de Dados

### 1. Tabela: `Cliente`

A tabela `Cliente` armazena as informações básicas de cada cliente.

#### Atributos:
- **id_cliente** (PK) - Identificador único do cliente (inteiro, autoincrementado).
- **nome** - Nome do cliente (pessoa física ou jurídica).
- **tipo_cliente** - Tipo de cliente, que pode ser `PJ` (Pessoa Jurídica) ou `PF` (Pessoa Física).
- **documento** - Documento do cliente. Para PJ, é o CNPJ, e para PF, é o CPF. Deve ser único.

#### Exemplo de Uso:
```sql
-- Inserir um novo cliente
INSERT INTO Cliente (nome, tipo_cliente, documento)
VALUES ('Empresa X', 'PJ', '12.345.678/0001-99');
```

### 2. Tabela: `Conta`

A tabela `Conta` armazena as informações relacionadas às contas associadas a cada cliente.

#### Atributos:
- **id_conta** (PK) - Identificador único da conta (inteiro, autoincrementado).
- **id_cliente** (FK) - Chave estrangeira, associando a conta a um cliente. Refere-se a `id_cliente` da tabela `Cliente`.

#### Relacionamento:
- **1:N com a tabela `Cliente`**: Um cliente pode ter várias contas.

#### Exemplo de Uso:
```sql
-- Inserir uma nova conta associada ao cliente com id_cliente = 1
INSERT INTO Conta (id_cliente)
VALUES (1);
```

### 3. Tabela: `Pagamento`

A tabela `Pagamento` armazena as informações sobre os pagamentos realizados pelas contas.

#### Atributos:
- **id_pagamento** (PK) - Identificador único do pagamento (inteiro, autoincrementado).
- **id_conta** (FK) - Chave estrangeira, associando o pagamento a uma conta. Refere-se a `id_conta` da tabela `Conta`.
- **metodo** - Forma de pagamento (exemplo: 'Cartão de Crédito', 'Boleto', etc.).
- **valor** - Valor do pagamento.
- **data_vencimento** - Data de vencimento do pagamento.
- **status** - Status do pagamento (exemplo: 'pago', 'pendente', 'em processamento').

#### Relacionamento:
- **1:N com a tabela `Conta`**: Uma conta pode ter vários pagamentos.

#### Exemplo de Uso:
```sql
-- Inserir um novo pagamento para a conta com id_conta = 1
INSERT INTO Pagamento (id_conta, metodo, valor, data_vencimento, status)
VALUES (1, 'Cartão de Crédito', 1500.00, '2025-02-10', 'Pendente');
```

### 4. Tabela: `Entrega`

A tabela `Entrega` armazena as informações sobre as entregas realizadas para as contas.

#### Atributos:
- **id_entrega** (PK) - Identificador único da entrega (inteiro, autoincrementado).
- **id_conta** (FK) - Chave estrangeira, associando a entrega a uma conta. Refere-se a `id_conta` da tabela `Conta`.
- **status** - Status da entrega (exemplo: 'Em processamento', 'Enviado', 'Entregue', 'Cancelado').
- **codigo_rastreio** - Código de rastreio da entrega.

#### Relacionamento:
- **1:N com a tabela `Conta`**: Uma conta pode ter várias entregas.

#### Exemplo de Uso:
```sql
-- Inserir uma nova entrega para a conta com id_conta = 1
INSERT INTO Entrega (id_conta, status, codigo_rastreio)
VALUES (1, 'Enviado', 'XYZ123456');
```

## Relacionamentos entre Tabelas

1. **Cliente -> Conta (1:N)**:  
   - Um cliente pode ter várias contas. Cada conta pertence a um único cliente.  
   - A chave estrangeira `id_cliente` em `Conta` referencia `id_cliente` em `Cliente`.

2. **Conta -> Pagamento (1:N)**:  
   - Uma conta pode ter múltiplos pagamentos. Cada pagamento pertence a uma única conta.  
   - A chave estrangeira `id_conta` em `Pagamento` referencia `id_conta` em `Conta`.

3. **Conta -> Entrega (1:N)**:  
   - Uma conta pode ter várias entregas associadas. Cada entrega pertence a uma única conta.  
   - A chave estrangeira `id_conta` em `Entrega` referencia `id_conta` em `Conta`.

## Restrições e Integridade

- **Integridade Referencial:**  
   - O banco de dados utiliza **chaves estrangeiras** para garantir que a relação entre as tabelas seja mantida corretamente. Se um cliente for deletado, todas as contas associadas a ele também serão deletadas (uso de `ON DELETE CASCADE`).
   - O mesmo acontece para **pagamentos** e **entregas**: se uma conta for deletada, todos os pagamentos e entregas relacionados a ela serão removidos automaticamente.

- **Integridade de Dados:**  
   - **Documento único:** O documento de cliente (CNPJ ou CPF) é único, garantindo que dois clientes não possam ter o mesmo documento.
   - **Status de Pagamento e Entrega:** O campo `status` nas tabelas `Pagamento` e `Entrega` usa o tipo **ENUM**, restringindo os valores possíveis para garantir que apenas os status válidos sejam registrados.

## Consultas Exemplares

### 1. Buscar todas as contas de um cliente:

```sql
SELECT * FROM Conta WHERE id_cliente = 1;
```

### 2. Buscar todos os pagamentos de uma conta:

```sql
SELECT * FROM Pagamento WHERE id_conta = 1;
```

### 3. Buscar todas as entregas de uma conta:

```sql
SELECT * FROM Entrega WHERE id_conta = 1;
```

### 4. Buscar informações detalhadas sobre o cliente e seus pagamentos:

```sql
SELECT Cliente.nome, Cliente.tipo_cliente, Pagamento.metodo, Pagamento.valor, Pagamento.status
FROM Cliente
JOIN Conta ON Cliente.id_cliente = Conta.id_cliente
JOIN Pagamento ON Conta.id_conta = Pagamento.id_conta
WHERE Cliente.id_cliente = 1;
```

### 5. Atualizar o status de uma entrega:

```sql
UPDATE Entrega
SET status = 'Entregue'
WHERE id_entrega = 1;
```

---

## Como Rodar o Banco de Dados

1. **Clone o repositório:**

```bash
git clone https://github.com/seu-usuario/nome-do-repositorio.git
```

2. **Acesse o diretório do projeto:**

```bash
cd nome-do-repositorio
```

3. **Rodar as queries para criar as tabelas no MySQL:**

```bash
mysql -u usuario -p < script_criacao_tabelas.sql
```

4. **Use um cliente MySQL para interagir com o banco de dados** (exemplo: MySQL Workbench, DBeaver, etc.).

---

## Conclusão

Esse repositório contém um banco de dados para gerenciar informações de clientes, contas, pagamentos e entregas. Com a documentação e o modelo de dados fornecido, você pode facilmente configurar e interagir com o banco para registrar e consultar as informações necessárias.
