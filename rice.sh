#!/bin/bash

# Testa o gerenciador de pacotes e instala os pacotes necessários
if command -v dnf &> /dev/null; then
    echo "Sistema Fedora detectado. Instalando pacotes..."
    sudo dnf install -y gnome-themes-extra gtk-murrine-engine
elif command -v apt &> /dev/null; then
    echo "Sistema baseado em Debian detectado. Instalando pacotes..."
    sudo apt install -y gnome-themes-extra gtk2-engines-murrine
elif command -v pacman &> /dev/null; then
    echo "Sistema Arch detectado. Instalando pacotes..."
    sudo pacman -S --noconfirm gnome-themes-extra gtk-engine-murrine
else
    echo "Sistema não reconhecido. Não foi possível instalar os pacotes necessários."
    exit 1
fi

# Cria o diretório e navega até ele
mkdir -p ~/Downloads/rice
cd ~/Downloads/rice || { echo "Erro ao acessar ~/Downloads/rice"; exit 1; }

# Instala o Cursor
echo "Instalando o Cursor"
if ! git clone https://github.com/yeyushengfan258/Afterglow-Cursors; then
    echo "Erro ao clonar o repositório Afterglow-Cursors"
    exit 1
fi
if [ -f ~/Downloads/rice/Afterglow-Cursors/install.sh ]; then
    cd ~/Downloads/rice/Afterglow-Cursors
    chmod +x ~/Downloads/rice/Afterglow-Cursors/install.sh
    ~/Downloads/rice/Afterglow-Cursors/install.sh || { echo "Erro ao executar Afterglow-Cursors/install.sh"; exit 1; }
    cd ~/Downloads/rice #fix install
else
    echo "Erro: install.sh não encontrado em Afterglow-Cursors"
    exit 1
fi

# Instala o Tema
echo "Instalando o Tema"
if ! git clone https://github.com/yeyushengfan258/Reversal-gtk-theme; then
    echo "Erro ao clonar o repositório Reversal-gtk-theme"
    exit 1
fi
if [ -f ~/Downloads/rice/Reversal-gtk-theme/install.sh ]; then
    chmod +x ~/Downloads/rice/Reversal-gtk-theme/install.sh
    ~/Downloads/rice/Reversal-gtk-theme/install.sh -l || { echo "Erro ao executar Reversal-gtk-theme/install.sh"; exit 1; }
else
    echo "Erro: install.sh não encontrado em Reversal-gtk-theme"
    exit 1
fi

# Instala os Ícones
echo "Instalando os Icones"
if ! git clone https://github.com/yeyushengfan258/McMuse-icon-theme; then
    echo "Erro ao clonar o repositório McMuse-icon-theme"
    exit 1
fi
if [ -f ~/Downloads/rice/McMuse-icon-theme/install.sh ]; then
    chmod +x ~/Downloads/rice/McMuse-icon-theme/install.sh
    ~/Downloads/rice/McMuse-icon-theme/install.sh -c -blue || { echo "Erro ao executar McMuse-icon-theme/install.sh"; exit 1; }
else
    echo "Erro: install.sh não encontrado em McMuse-icon-theme"
    exit 1
fi

# Setando as configs:
    gsettings set org.gnome.desktop.interface cursor-theme "Afterglow-cursors"
    gsettings set org.gnome.desktop.interface icon-theme "McMuse-blue-dark"
    gsettings set org.gnome.desktop.interface gtk-theme "Reversal"
    gsettings set org.gnome.shell.extensions.user-theme name "Reversal"

# Atualiza o cache de ícones e temas
echo "Atualizando o cache de ícones e temas..."
gtk-update-icon-cache ~/.local/share/icons/McMuse-blue-dark 2>/dev/null
gtk-update-icon-cache /usr/share/icons/McMuse-blue-dark 2>/dev/null

# -------------------------------------------------- Wallpaper -----------------------------------------------------------#
# Define variáveis
WALLPAPER_URL="https://raw.githubusercontent.com/amonetlol/wallpaper-galgadot/main/Gal-Gadot-0058.jpg"
DEST_DIR="$HOME/Imagens/Wallpapers"
DEST_FILE="$DEST_DIR/Gal-Gadot-0058.jpg"

# 1. Verifica e cria a pasta ~/Imagens/Wallpapers, se necessário
echo "Verificando a pasta $DEST_DIR..."
if [ ! -d "$DEST_DIR" ]; then
    mkdir -p "$DEST_DIR" || { echo "Erro ao criar a pasta $DEST_DIR"; exit 1; }
    echo "Pasta $DEST_DIR criada."
else
    echo "Pasta $DEST_DIR já existe."
fi

# 2. Verifica se wget está instalado
if ! command -v wget &> /dev/null; then
    echo "Erro: wget não está instalado. Instale-o com:"
    echo "  Debian/Ubuntu: sudo apt install wget"
    echo "  Fedora: sudo dnf install wget"
    echo "  Arch: sudo pacman -S wget"
    exit 1
fi

# 3. Faz o download do arquivo
echo "Baixando o wallpaper de $WALLPAPER_URL..."
if wget -O "$DEST_FILE" "$WALLPAPER_URL"; then
    echo "Download concluído: $DEST_FILE"
else
    echo "Erro ao baixar o wallpaper."
    exit 1
fi

# 4. Define o papel de paredes
echo "Definindo $DEST_FILE como papel de paredes..."
if gsettings set org.gnome.desktop.background picture-uri "file://$DEST_FILE"; then
    echo "Papel de paredes configurado com sucesso."
else
    echo "Erro ao configurar o papel de paredes."
    exit 1
fi

# 5. Opcional: Define para o modo escuro (se aplicável)
gsettings set org.gnome.desktop.background picture-uri-dark "file://$DEST_FILE" 2>/dev/null

# Notifica o usuário
echo "Configuração concluída! Pode ser necessário reiniciar a sessão para aplicar todas as mudanças."
