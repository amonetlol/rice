#!/bin/bash

# Testa se a pasta existe, se não, cria
if [ ! -d ~/Downloads/rice ]; then
	mkdir -p ~/Downloads/rice || { echo "Erro ao acessar ~/Downloads/rice"; exit 1; }
fi

# Muda para o diretório
cd ~/Downloads/rice || { echo "Erro ao acessar ~/Downloads/rice"; exit 1; }

# Instala o Particle Grub Theme
echo "Instalando o Grub Tema"
if ! git clone https://github.com/yeyushengfan258/Particle-grub-theme; then
    echo "Erro ao clonar o repositório Particle-grub-theme"
    exit 1
fi
if [ -f ~/Downloads/rice/Particle-grub-theme/install.sh ]; then
    chmod +x ~/Downloads/rice/Particle-grub-theme/install.sh
    sudo ~/Downloads/rice/Particle-grub-theme/install.sh -t window || { echo "Erro ao executar Particle-grub-theme/install.sh"; exit 1; }
else
    echo "Erro: install.sh não encontrado em Particle-grub-theme"
    exit 1
fi
