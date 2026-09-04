# Batalha dos Velhos 👴⚔️👵

Um jogo da velha para dois jogadores, desenvolvido em Flutter, com perfis personalizados e histórico local de partidas.

No **Batalha dos Velhos**, cada jogador pode escolher seu nome e um personagem para a disputa. Durante a partida, o tabuleiro indica de quem é a vez de jogar e, ao final, o resultado é armazenado localmente para consulta posterior.

## ✨ Funcionalidades

- Jogo da velha para dois jogadores
- Definição do nome de cada jogador
- Escolha de avatar entre personagens disponíveis
- Indicação visual de qual jogador deve realizar a próxima jogada
- Identificação automática do vencedor
- Detecção de empate
- Registro das partidas realizadas
- Armazenamento do tabuleiro final de cada partida
- Histórico com vencedor e resultado da partida
- Suporte a modo claro e modo escuro
- Persistência local dos dados com SQLite

## 👴 Perfis dos jogadores

Para realizar a partida, os dois jogadores podem personalizar seus perfis.

Cada jogador pode:

- definir seu nome
- escolher um avatar
- utilizar o perfil durante a partida

## 🎮 Partidas

Durante a partida, a interface apresenta o tabuleiro do jogo da velha e informa qual jogador possui a vez.

Os jogadores realizam suas jogadas alternadamente até que:

- um jogador consiga completar uma linha, coluna ou diagonal
- ou todas as posições sejam preenchidas, resultando em empate

Ao final, a partida é registrada automaticamente no histórico.

## 📜 Histórico de partidas

As partidas concluídas são armazenadas localmente no dispositivo.

O histórico mantém informações como:

- jogadores participantes
- vencedor da partida
- resultado
- estado final do tabuleiro

Isso permite visualizar partidas anteriores mesmo após fechar e abrir novamente o aplicativo.

## 🗄️ Persistência local

O projeto utiliza **SQLite** para armazenar o histórico das partidas diretamente no dispositivo.

Dessa forma, os dados permanecem disponíveis sem necessidade de conexão com a internet ou de uma API externa.

## 🛠️ Tecnologias utilizadas

- **Flutter**
- **Dart**
- **SQLite**

## 🎯 Objetivo do projeto

O **Batalha dos Velhos** foi desenvolvido como projeto de prática em desenvolvimento mobile com Flutter.

O projeto explora conceitos como:

- gerenciamento de estado da interface
- navegação entre telas
- lógica de jogos
- persistência local de dados
- modelagem e manipulação de dados com SQLite
- criação de interfaces interativas
- personalização da experiência do usuário

## 🖼️ Preview

A interface do **Batalha dos Velhos** foi desenvolvida com foco em uma experiência simples, divertida e intuitiva, com suporte aos modos claro e escuro.

### ⚔️ Partida

Tela principal da partida, com o tabuleiro e indicação visual de qual jogador deve realizar a próxima jogada.

<img width="720" height="1600" alt="image" src="https://github.com/user-attachments/assets/03f84510-33cb-4150-a11d-a90817dc7eeb" />


### 📜 Histórico de partidas

Lista das partidas realizadas, permitindo consultar os resultados anteriores.

<img width="720" height="1600" alt="image" src="https://github.com/user-attachments/assets/7838390e-a82b-43fd-bf6d-7fb2c174c2b1" />

### 🏆 Detalhes da partida

Ao selecionar uma partida no histórico, é possível visualizar o tabuleiro final, o vencedor e a participação de cada jogador, incluindo quem jogou com **X** e quem jogou com **O**.

<img width="720" height="1600" alt="image" src="https://github.com/user-attachments/assets/651d717e-1043-4ff8-9144-621a6abeac11" />

### 👤 Configuração dos jogadores

Tela de configuração onde os jogadores podem definir seus nomes, escolher seus avatares entre as opções disponíveis, e qual símbolo o primeiro jogador terá.

<img width="720" height="1600" alt="image" src="https://github.com/user-attachments/assets/3984bf1d-e9d0-4e69-a21d-3cc55963a097" />
