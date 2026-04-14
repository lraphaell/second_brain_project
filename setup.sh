#!/bin/bash
# ============================================================
# Second Brain — Setup Script
# Execute este script para configurar o segundo cérebro
# no seu computador em ~2 minutos.
# ============================================================

set -e

VAULT_PATH="$HOME/second-brain"
CLAUDE_CONFIG_MAC="$HOME/Library/Application Support/Claude/claude_desktop_config.json"
CLAUDE_CONFIG_LINUX="$HOME/.config/claude/claude_desktop_config.json"

echo "🧠 Configurando seu Segundo Cérebro..."
echo ""

# --- Passo 1: Verificar se o vault já existe ---
if [ -d "$VAULT_PATH" ]; then
    echo "⚠️  Vault já existe em $VAULT_PATH"
    echo "   Pulando criação. Se quiser recomeçar, remova a pasta e rode novamente."
else
    echo "📁 Clonando vault template..."
    # Se vier de um repo git, descomente a linha abaixo e comente o cp:
    # git clone <URL_DO_REPO> "$VAULT_PATH"
    echo "   Vault criado em: $VAULT_PATH"
fi

# --- Passo 2: Personalizar CLAUDE.md ---
echo ""
echo "👤 Vamos personalizar seu contexto."
echo ""
read -p "   Seu nome: " USER_NAME
read -p "   Seu cargo/papel: " USER_ROLE
read -p "   Nome do time: " USER_TEAM
read -p "   Áreas de foco (separadas por vírgula): " USER_AREAS
read -p "   Projetos ativos (separados por vírgula): " USER_PROJECTS

CLAUDE_MD="$VAULT_PATH/.claude/CLAUDE.md"
if [ -f "$CLAUDE_MD" ]; then
    sed -i.bak "s/\[SEU NOME\]/$USER_NAME/g" "$CLAUDE_MD"
    sed -i.bak "s/\[SEU CARGO\/PAPEL NO TIME\]/$USER_ROLE/g" "$CLAUDE_MD"
    sed -i.bak "s/\[NOME DO TIME\]/$USER_TEAM/g" "$CLAUDE_MD"
    sed -i.bak "s/\[LISTA DE ÁREAS\]/$USER_AREAS/g" "$CLAUDE_MD"
    sed -i.bak "s/\[LISTA DE PROJETOS\]/$USER_PROJECTS/g" "$CLAUDE_MD"
    rm -f "${CLAUDE_MD}.bak"
    echo "   ✅ CLAUDE.md personalizado!"
fi

# --- Passo 3: Criar daily note de hoje ---
TODAY=$(date +%Y-%m-%d)
DAILY_FILE="$VAULT_PATH/Daily/$TODAY.md"
if [ ! -f "$DAILY_FILE" ]; then
    cat > "$DAILY_FILE" << EOF
---
date: $TODAY
tags: [daily]
type: daily
status: captured
---

# $TODAY

## Foco do dia
- [ ] Configurar o segundo cérebro ✅

## Notas
Hoje configurei meu segundo cérebro com Obsidian + Claude.
Este é o primeiro dia do vault!

## Aprendizados
- O vault fica em ~/second-brain, acima de qualquer projeto
- Claude Desktop conecta via MCP server (MCPVault)
- Claude Code acessa com: cd ~/second-brain && claude
EOF
    echo "   ✅ Daily note de hoje criada!"
fi

# --- Passo 4: Configurar Claude Desktop MCP ---
echo ""
echo "🔗 Configurando Claude Desktop..."

# Detectar OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    CONFIG_FILE="$CLAUDE_CONFIG_MAC"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    CONFIG_FILE="$CLAUDE_CONFIG_LINUX"
else
    CONFIG_FILE="$CLAUDE_CONFIG_LINUX"
fi

CONFIG_DIR=$(dirname "$CONFIG_FILE")
mkdir -p "$CONFIG_DIR"

# Verificar se já existe config
if [ -f "$CONFIG_FILE" ]; then
    echo "   ⚠️  Config do Claude Desktop já existe."
    echo "   Adicione manualmente ao seu claude_desktop_config.json:"
    echo ""
    echo '   "obsidian": {'
    echo '     "command": "npx",'
    echo "     \"args\": [\"-y\", \"@bitbonsai/mcpvault\", \"$VAULT_PATH\"]"
    echo '   }'
else
    cat > "$CONFIG_FILE" << EOF
{
  "mcpServers": {
    "obsidian": {
      "command": "npx",
      "args": ["-y", "@bitbonsai/mcpvault", "$VAULT_PATH"]
    }
  }
}
EOF
    echo "   ✅ Claude Desktop configurado!"
fi

# --- Passo 5: Instruções finais ---
echo ""
echo "============================================================"
echo "🎉 Segundo Cérebro configurado!"
echo "============================================================"
echo ""
echo "📋 Próximos passos:"
echo ""
echo "   1. Abra Obsidian → File → Open folder as vault"
echo "      Selecione: $VAULT_PATH"
echo ""
echo "   2. Reinicie o Claude Desktop"
echo "      (Quit completamente e abra novamente)"
echo ""
echo "   3. No Claude Desktop, teste com:"
echo "      'Quais arquivos tem no meu vault Obsidian?'"
echo ""
echo "   4. No terminal, para usar com Claude Code:"
echo "      cd ~/second-brain && claude"
echo ""
echo "   5. Para acessar o vault de dentro de um projeto:"
echo "      claude --add-dir ~/second-brain"
echo ""
echo "============================================================"
echo "📖 Leia o guia completo no Confluence do time"
echo "============================================================"
