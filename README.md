# Projeto de Esquema de Banco de Dados
## Contexto
O objetivo do projeto é desenvolver um banco de dados para gerenciar informações de clientes e transações de uma plataforma de e-commerce, levando em consideração as necessidades de clientes Pessoa Jurídica (PJ) e Pessoa Física (PF), opções múltiplas de formas de pagamento, e o gerenciamento do status de entregas e códigos de rastreio.
## Esquema
O modelo foi elaborado atendendo aos seguintes requisitos:
### Cliente
- Cada conta pode ser Pessoa Jurídica ou Pessoa Física, mas não ambos os tipos.
- A tabela de clientes contém um campo para identificar como PF ou PJ, e os dados são armazenados de forma separada.

### Pagamento
- Cada cliente pode ter várias formas de pagamento cadastradas.
- A tabela de pagamentos armazena as informações necessárias para processar essas transações, incluindo o tipo de pagamento e os detalhes específicos de cada forma.
### Entrega
- As entregas possuem um status (como "Pendente", "Enviado", "Em Trânsito", "Entregue").
- Cada entrega também é associada a um código de rastreio, que pode ser utilizado para acompanhar o processo da entrega.

## Modelo Conceitual
O modelo conceitual está estruturado da seguinte forma:

- **Clientes**: Tabela que armazena as informações pessoais ou da empresa, dependendo do tipo de cliente.
- **Pagamentos**: Tabela que armazena as informações sobre as formas de pagamento associadas a cada cliente.
- **Entregas**: Tabela que armazena o status e o código de rastreio para cada pedido de entrega.

### Relacionamentos
- Um cliente pode ter vários pagamentos, mas cada pagamento está vinculado a apenas um cliente.
- Um cliente pode ter várias entregas, mas cada entrega está associada a um único cliente.

## Desafios Enfrentados
- Implementação da restrição de cliente PJ ou PF, garantindo que cada cliente tenha apenas um tipo de documento.
- Modelagem de um sistema flexível que permita associar múltiplas formas de pagamento a um único cliente.
- Manutenção de registros de status e rastreabilidade das entregas.

## Aprendizados
- Modelagem de dados complexos com restrições e relacionamentos entre diferentes tipos de entidades.
- A importância de um design de banco de dados bem estruturado para garantir eficiência e escalabilidade.

