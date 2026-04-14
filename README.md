# 🧠 Second Brain — Vault Template

Template replicável do segundo cérebro para membros do time. Combina Obsidian + Claude Desktop + Claude Code para criar uma base de conhecimento pessoal que raciocina com suas notas.

## Quick Start (2 minutos)

```bash
# 1. Clone este repo
git clone <URL_DESTE_REPO> ~/second-brain

# 2. Execute o setup
cd ~/second-brain && chmod +x setup.sh && ./setup.sh

# 3. Abra no Obsidian
# File → Open folder as vault → ~/second-brain

# 4. Reinicie o Claude Desktop
```

## Pré-requisitos

| Ferramenta | Custo | Obrigatório? |
|-----------|-------|-------------|
| Obsidian | Grátis | Sim |
| Claude Desktop ou Claude Pro | ~$20/mês | Sim |
| Node.js (v18+) | Grátis | Sim (para o MCP server) |
| Git | Grátis | Recomendado |

## Estrutura

```
~/second-brain/           ← Na HOME, fora de qualquer projeto
├── .claude/
│   └── CLAUDE.md         ← Contexto pessoal (personalizar!)
├── 00-Inbox/             ← Braindump, capturas rápidas
├── 01-Projects/          ← Projetos ativos
├── 02-Areas/             ← Responsabilidades contínuas
├── 03-Resources/         ← Material de referência
├── 04-Archive/           ← Completo/inativo
├── Decisions/            ← Registro de decisões
├── Daily/                ← Daily notes
├── Templates/            ← Templates de notas
├── setup.sh              ← Script de setup
└── README.md             ← Este arquivo
```

## Como funciona em cada superfície

| Superfície | Como acessar o cérebro |
|-----------|----------------------|
| **Claude.ai / Cowork** | Skills do time (recall, capture, connect) via conectores Slack/Confluence/RAG |
| **Claude Desktop** | MCP server → lê e escreve direto no vault |
| **Claude Code** | `cd ~/second-brain && claude` |
| **Claude Code + projeto** | `claude --add-dir ~/second-brain` (vault como contexto adicional) |

## Comandos rápidos

No Claude Desktop ou Code, diga:

- `braindump` — Nota rápida no Inbox
- `daily` — Daily note de hoje
- `review` — Revisão semanal
- `decide` — Novo Decision Record
- `capture meeting` — Nota de reunião
- `what do I know about X` — Busca no vault
- `challenge` — Busca contradições com decisões passadas

## Conectando projetos

Para dar ao Claude Code acesso ao seu cérebro de dentro de um projeto:

```bash
# Opção 1: flag --add-dir
cd ~/projects/meu-app && claude --add-dir ~/second-brain

# Opção 2: symlink (aparece no Obsidian também)
ln -s ~/projects/meu-app/docs ~/second-brain/01-Projects/meu-app
```

## Personalização

1. Edite `.claude/CLAUDE.md` com suas informações pessoais
2. Ajuste os templates em `Templates/` conforme seu workflow
3. Adicione tags e áreas relevantes ao seu contexto

## Plugins Obsidian recomendados

- **Templater** — Para usar os templates com variáveis dinâmicas
- **Calendar** — Navegação visual pelas daily notes
- **Dataview** — Queries sobre as notas (listar decisões, action items)
- **Git** — Backup automático via Git

## Backup

```bash
# Configurar Git (uma vez)
cd ~/second-brain
git init
echo ".obsidian/workspace.json" >> .gitignore
git add -A && git commit -m "Initial vault"

# Backup periódico (ou use o plugin Git do Obsidian)
git add -A && git commit -m "vault update $(date +%Y-%m-%d)"
```
