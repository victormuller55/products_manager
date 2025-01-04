# Sistema de Gerenciamento de Produtos

Este projeto é um sistema de gerenciamento de produtos desenvolvido com Dart e Flutter, utilizando o Android Studio como ambiente de desenvolvimento. Ele oferece uma série de funcionalidades relacionadas ao gerenciamento de produtos e implementa a arquitetura BLoC para gerenciamento de estado.

## Funcionalidades

- **Cadastrar Produtos:** Permite o registro de novos produtos.
- **Listar Produtos:** Exibe todos os produtos cadastrados.
- **Editar Produtos:** Realiza a edição das informações de um produto específico.
- **Verificar Média de Valores:** Calcula e exibe a média dos valores dos produtos cadastrados.
- **Verificar Produto Mais Caro:** Identifica e exibe o produto com o maior valor.
- **Verificar Informações do Produto:** Mostra os detalhes completos de um produto.
- **Apagar Produto:** Remove um produto do sistema.

## Estrutura do Projeto

O projeto está organizado nas seguintes pastas:

- **telas (pages):** Contém os widgets de interface do usuário.
- **models:** Define as estruturas de dados e modelos usados no sistema.
- **configurações (settings):** Inclui as configurações gerais do aplicativo.
- **service:** Responsável pela lógica de negócio e operações relacionadas a dados.
- **bloc:** Implementa a lógica de estado usando a arquitetura BLoC.
  - **state:** Define os estados possíveis do sistema.
  - **event:** Define os eventos que acionam mudanças de estado.

## Dependências

O projeto utiliza a biblioteca personalizada **muller_package**, desenvolvida por mim (Victor Muller), que contém componentes genéricos prontos para uso.

## Pré-requisitos

- Dart SDK e Flutter instalados.
- Android Studio configurado.
- Dispositivo ou emulador Android configurado.

## Como Rodar o Projeto

1. **Clone o repositório:**
   ```bash
   git clone https://github.com/victormuller55/products_manager
   ```

2. **Clone as dependências:**
   ```bash
   git clone https://github.com/victormuller55/muller_package
   ```

4. **Execute o aplicativo:**
   ```bash
   flutter run -d chrome
   ```

## Observações

- Certifique-se de que a biblioteca **muller_package** está corretamente importada no projeto.

---

Para dúvidas ou sugestões, entre em contato com Victor Muller.
