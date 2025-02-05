CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    tipo_cliente ENUM('PJ', 'PF') NOT NULL,
    documento VARCHAR(20) NOT NULL, 
    UNIQUE (documento)
);

CREATE TABLE Conta (
    id_conta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente) 
    ON DELETE CASCADE 
);

CREATE TABLE Pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_conta INT NOT NULL,
    metodo VARCHAR(50) NOT NULL,  
    valor DECIMAL(10,2) NOT NULL,
    data_vencimento DATE NOT NULL,
    status ENUM('pago', 'pendente', 'em processamento') NOT NULL,
    FOREIGN KEY (id_conta) REFERENCES Conta(id_conta) 
    ON DELETE CASCADE
);

CREATE TABLE Entrega (
    id_entrega INT AUTO_INCREMENT PRIMARY KEY,
    id_conta INT NOT NULL,
    status ENUM('Em processamento', 'Enviado', 'Entregue', 'Cancelado') NOT NULL,
    codigo_rastreio VARCHAR(100),
    FOREIGN KEY (id_conta) REFERENCES Conta(id_conta)
    ON DELETE CASCADE
);
