# 🏆 eSports Championship Manager

## 📌 Sobre o projeto

O eSports Championship Manager é um projeto de banco de dados desenvolvido para a disciplina de Linguagem SQL.

O sistema realiza o gerenciamento de campeonatos de eSports, organizando as informações de campeonatos, equipes, jogadores, partidas, resultados, classificação, patrocínios, árbitros e premiações.

O projeto foi desenvolvido em SQL com PostgreSQL 18, usando a ferramenta DBeaver, e versionado no GitHub com a colaboração de todos os integrantes da equipe.

---

## 🎯 Objetivo

Desenvolver um banco de dados relacional capaz de organizar e gerenciar as principais informações de campeonatos de eSports, aplicando modelagem de dados, relacionamentos, integridade, consultas SQL e programação no banco (views, functions, procedures e triggers).

---

## 🧠 Escopo

O sistema contempla:

- Cadastro de jogadores, com histórico de transferências entre equipes
- Cadastro de equipes
- Cadastro de campeonatos, organizações, modalidades/jogos e fases
- Inscrição de equipes nos campeonatos, com controle de vagas
- Organização de partidas, com árbitro responsável
- Registro de resultados e de estatísticas dos jogadores
- Classificação automática dos campeonatos
- Patrocínios dos campeonatos
- Premiação e histórico de auditoria dos campeões
- Consultas e relatórios

> O escopo poderá ser atualizado e expandido durante o desenvolvimento do projeto.

---

## 🛠️ Tecnologias

- PostgreSQL 18
- DBeaver
- SQL e PL/pgSQL
- GitHub

---

## 🗂️ Modelo de dados

O banco possui **16 tabelas**:

| Tabela | Descrição |
|---|---|
| `modalidade` | Jogos/modalidades disputadas |
| `organizacao` | Organizações responsáveis pelos campeonatos |
| `patrocinador` | Empresas patrocinadoras |
| `equipe` | Equipes participantes |
| `arbitro` | Árbitros das partidas |
| `campeonato` | Campeonatos (status: Planejado, Em andamento, Finalizado ou Cancelado) |
| `jogador` | Jogadores |
| `jogador_equipe` | Histórico de vínculos entre jogadores e equipes |
| `fase` | Fases de cada campeonato |
| `equipe_campeonato` | Inscrição das equipes nos campeonatos |
| `partida` | Partidas entre duas equipes, com fase e árbitro |
| `resultado` | Resultado de cada partida |
| `estatistica` | Estatísticas dos jogadores (uma métrica por linha) |
| `classificacao_campeonato` | Pontos, vitórias e derrotas por equipe em cada campeonato |
| `campeonato_patrocinador` | Patrocínios: liga campeonatos e patrocinadores, com o valor |
| `auditoria_campeoes` | Histórico da liberação de premiação das equipes campeãs |

Principais relacionamentos:

- Um campeonato pertence a uma modalidade e a uma organização.
- Equipes e campeonatos se relacionam por `equipe_campeonato` (N:N).
- Jogadores e equipes se relacionam por `jogador_equipe`, que guarda as datas de entrada e de saída.
- Campeonatos e patrocinadores se relacionam por `campeonato_patrocinador` (N:N), que guarda o valor de cada patrocínio.
- Cada partida pertence a um campeonato e a uma fase, tem duas equipes e pode ter um árbitro.
- A duração da partida fica em `resultado`, porque só é conhecida quando a partida termina.

---

## ⚙️ Programação SQL

### Views

| Nome | O que faz |
|---|---|
| `vw_tabela_classificacao_campeonato` | Tabela de classificação com posição, pontos, vitórias, derrotas e saldo de rounds |
| `vw_estatisticas_gerais_jogadores` | Média de kills, mortes, assistências e KDA por jogador |
| `vw_resumo_desempenho_equipes` | Win rate, títulos e premiação total por equipe |
| `vw_calendario_partidas_pendentes` | Partidas ainda sem resultado |
| `vw_relatorio_premiacao_torneios` | Campeonatos finalizados: total arrecadado, premiação e valor do 1º ao 3º lugar |

### Functions

| Nome | O que faz |
|---|---|
| `fc_calcular_kda_jogador` | Calcula o KDA de um jogador |
| `fc_taxa_vitoria_equipe` | Percentual de vitórias de uma equipe em um campeonato |
| `fc_ranking_atual_equipe` | Posição de uma equipe em um campeonato |
| `fc_verificar_elegibilidade_jogador` | Informa se o jogador pode ser inscrito (idade, vínculo ativo e sem suspensão) |
| `fc_pontuacao_acumulada_equipe` | Pontos de uma equipe na classificação de um campeonato |

### Procedures

| Nome | O que faz |
|---|---|
| `sp_inscrever_equipe_campeonato` | Inscreve uma equipe, validando status, elenco e vagas |
| `sp_registrar_resultado_partida` | Registra o resultado de uma partida |
| `sp_transferir_jogador_equipe` | Encerra o vínculo atual do jogador e cria o novo |
| `sp_finalizar_campeonato_premiacao` | Define a colocação final e finaliza o campeonato |
| `sp_atualizar_estatisticas_jogador_partida` | Lança as estatísticas de um jogador em uma partida |

### Triggers

| Nome | O que faz |
|---|---|
| `tg_impedir_inscricao_equipe_limite_excedido` | Impede inscrição quando as vagas do campeonato acabaram |
| `tg_validar_elenco_minimo_partida` | Impede partida com equipe sem o mínimo de jogadores ativos |
| `tg_atualizar_classificacao_pos_partida` | Atualiza a classificação quando um resultado é registrado |
| `tg_bloquear_transferencia_jogador_em_campeonato` | Impede transferência enquanto a equipe disputa uma fase ativa |
| `tg_auditoria_distribuicao_premiacao` | Registra a premiação da equipe campeã ao finalizar o campeonato |

### Consultas

O projeto reúne **20 consultas analíticas** (classificação, KDA, premiações, jogadores por nacionalidade, entre outras).

---

## 📂 Estrutura do projeto

```text
database/
├── modelo/        entidades e atributos
├── ddl/           criação das tabelas
├── inserts/       carga de dados
└── consultas/     consultas analíticas

programacao-sql/
├── views/
├── functions/
├── procedures/
└── triggers/
```

---

## ▶️ Como executar

1. No PostgreSQL, crie um banco novo e vazio.
2. No DBeaver, abra cada script e execute-o inteiro (Alt+X), nesta ordem:
   1. Tabelas (`ddl`)
   2. Dados (`inserts`)
   3. Views
   4. Functions
   5. Procedures
   6. Triggers
   7. Consultas
3. Os triggers são criados depois dos dados de propósito: assim a carga inicial não dispara as regras e a classificação não é contada duas vezes.

---

## 👥 Equipe

| Integrante | Função |
|---|---|
| João Paulo de Oliveira Carneiro | Líder |
| Agson Asafe Junqueira Pereira | Integrante |
| Vitor Hugo da Silva Oliveira | Integrante |
| Davi Mercês da Silva | Integrante |
| Matheus Barbosa dos Santos Carvalho | Integrante |
| Andrei de Almeida Santos | Integrante |

---

## 📚 Disciplina

- **Disciplina:** Linguagem SQL
- **Instituição:** Centro Universitário de Excelência - UNEX
- **Professor:** Jefte Goes
- **Semestre:** 2026.2
