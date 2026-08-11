# 💰 Sistema de Folha de Pagamento em Java

Um sistema simples de simulação de folha de pagamento em Java, focado na aplicação prática de **Programação Orientada a Objetos (POO)**, incluindo **Herança**, **Polimorfismo**, e **Abstração**.

Este projeto foi desenvolvido para reforçar conceitos de orientação a objetos, criando uma estrutura de funcionários com diferentes tipos de contratos (CLT, Estágio, Freelancer, Gerência) e demonstrando como uma única interface ou classe abstrata pode simplificar o cálculo do pagamento.

## 🚀 Funcionalidades

O sistema calcula o pagamento mensal de diferentes categorias de colaboradores, incluindo:
- **Funcionário CLT:** Possui salário base e bônus fixo.
- **Gerente:** Herda de CLT, mas possui também um benefício adicional.
- **Estagiário:** Recebe um valor fixo de bolsa-auxílio.
- **Freelancer:** Recebe o pagamento não por mês fixo, mas baseado nas horas efetivamente trabalhadas e no valor da sua hora.

## 🛠️ Tecnologias e Conceitos Utilizados

- **Java**
- **Orientação a Objetos (POO)**
  - **Abstração:** Criação da classe base `Funcionario` focada na generalização (ex: nome, cpf, método `calcularPagamento()`).
  - **Herança:** Criação de classes derivadas (`FuncionarioCLT`, `Estagiario`, `Freelancer`) que herdam características de `Funcionario`. `Gerente` herda ainda de `FuncionarioCLT`.
  - **Polimorfismo:** Na execução do sistema (`Main.java`), uma mesma lista trata todos os funcionários generalizados. Ao invocar o método `calcularPagamento()` numa iteração, a JVM decide em tempo de execução o cálculo específico a qual cada objeto obedece, eliminando código estrutural de (ifs/switchs) para cada tipo.
- **Estruturas de Dados:** `ArrayList` para agrupamento da folha de pagamento.

## 📂 Estrutura do Projeto

- `Main.java` - A classe principal onde todos os funcionários são instanciados, adicionados a uma lista polimórfica e o pagamento da empresa consolidado e exibido.
- `Funcionario.java` - Classe abstrata base.
- `FuncionarioCLT.java` - Funciona sob o regime de Consolidação das Leis do Trabalho.
- `Estagiario.java` - Implementa o modelo de contrato estágio.
- `Freelancer.java` - Lida com pagamento por hora, contém o método `lancarHoras()`.
- `Gerente.java` - Classe que estende diretamente o comportamento CLT, somando outros benefícios.
- Arquivos de Banco de Dados:
  - `dataBase.sql`
  - `SCRIPTS.sql` 
  - (Esses scripts criam a modelagem das tabelas do sistema relacional que possa ser integrado futuramente).
