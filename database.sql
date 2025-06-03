CREATE DATABASE estoque_faturamento;

CREATE TABLE clientes (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  telefone VARCHAR(20),
  cnpj VARCHAR(18) UNIQUE,
  plano ENUM('FREE', 'GOLD', 'PRIME') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE produtos (
  id SERIAL PRIMARY KEY,
  cliente_id INTEGER REFERENCES clientes(id),
  nome VARCHAR(255) NOT NULL,
  codigo VARCHAR(50) UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE estoque (
  id SERIAL PRIMARY KEY,
  produto_id INTEGER REFERENCES produtos(id),
  quantidade INTEGER NOT NULL,
  status ENUM('ENTRADA', 'SAIDA') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE faturas (
  id SERIAL PRIMARY KEY,
  cliente_id INTEGER REFERENCES clientes(id),
  mes_referencia DATE NOT NULL,
  valor_total DECIMAL(10, 2) NOT NULL,
  pdf_url VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE movimentacoes (
  id SERIAL PRIMARY KEY,
  produto_id INTEGER REFERENCES produtos(id),
  quantidade INTEGER NOT NULL,
  tipo ENUM('ENTRADA', 'SAIDA') NOT NULL,
  servico_adicional JSONB,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE configuracoes_planos (
  id SERIAL PRIMARY KEY,
  plano ENUM('FREE', 'GOLD', 'PRIME') NOT NULL,
  mensalidade DECIMAL(10, 2),
  preparacao_simples DECIMAL(10, 2),
  embalagem_especial DECIMAL(10, 2),
  kit_min DECIMAL(10, 2),
  kit_max DECIMAL(10, 2),
  retrabalho DECIMAL(10, 2),
  devolucao DECIMAL(10, 2),
  endereco_fiscal DECIMAL(10, 2),
  armazenagem DECIMAL(10, 2),
  preparacao_fbm DECIMAL(10, 2),
  prazo_preparacao INTEGER
);

-- Inserir configurações iniciais dos planos
INSERT INTO configuracoes_planos (plano, mensalidade, preparacao_simples, embalagem_especial, kit_min, kit_max, retrabalho, devolucao, endereco_fiscal, armazenagem, preparacao_fbm, prazo_preparacao)
VALUES
  ('FREE', 0.00, 3.00, 0.00, 3.00, 6.00, 2.00, 2.00, 150.00, 1.90, 6.50, 48),
  ('GOLD', 49.90, 2.50, 0.00, 2.00, 5.00, 0.50, 0.50, 50.00, 0.90, 6.00, 36),
  ('PRIME', 120.99, 2.00, 3.00, 3.00, 3.00, 0.00, 0.00, 0.00, 0.60, 4.50, 24);