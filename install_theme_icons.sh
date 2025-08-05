#!/bin/sh

# Criar as pastas ~/.icons e ~/.themes se não existirem
mkdir -p ~/.icons
mkdir -p ~/.themes

# Baixar os arquivos ZIP
curl -L https://github.com/amonetlol/rice/raw/refs/heads/main/icons.zip -o /tmp/icons.zip
curl -L https://github.com/amonetlol/rice/raw/refs/heads/main/themes.zip -o /tmp/themes.zip

# Extrair os arquivos para os respectivos diretórios
unzip -o /tmp/icons.zip -d ~/.icons
unzip -o /tmp/themes.zip -d ~/.themes

# Limpeza opcional dos arquivos temporários
rm /tmp/icons.zip /tmp/themes.zip

gsettings set org.gnome.desktop.interface cursor-theme 'Afterglow-cursors'
gsettings set org.gnome.desktop.interface icon-theme 'McMuse-blue-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'Reversal'
gsettings set org.gnome.shell.extensions.user-theme name 'Reversal'

echo "Instalação concluída!"
