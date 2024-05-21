#!/bin/bash
set -exu
set -o pipefail

if ! command -v zsh &> /dev/null
then
  sudo apt install zsh
fi

if [[ ! -d ~/.oh-my-zsh/ ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

if [[ ! -d ~/.nvm/ ]]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  nvm install --lts
  nvm use --lts
fi

if [[ ! -d "$HOME/packages/" ]]; then
    mkdir -p "$HOME/packages/"
fi

if [[ ! -d "$HOME/tools/" ]]; then
    mkdir -p "$HOME/tools/"
fi

#######################################################################
#                    Anaconda or miniconda install                    #
#######################################################################
CONDA_DIR=$HOME/tools/miniconda
CONDA_NAME=Miniconda.sh
CONDA_LINK="https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-py39_4.10.3-Linux-x86_64.sh"

if [[ ! -d "$CONDA_DIR" ]]; then
    echo "Installing Python in user HOME"

    SYSTEM_PYTHON=false

    echo "Downloading and installing conda"

    if [[ ! -f "$HOME/packages/$CONDA_NAME" ]]; then
        curl -Lo "$HOME/packages/$CONDA_NAME" $CONDA_LINK
    fi

    # Install conda silently
    if [[ -d $CONDA_DIR ]]; then
        rm -rf "$CONDA_DIR"
    fi
    bash "$HOME/packages/$CONDA_NAME" -b -p "$CONDA_DIR"

    # Setting up environment variables
    echo "export PATH=\"$CONDA_DIR/bin:\$PATH\"" >> "$HOME/.zshrc"
else
    echo "Python is already installed. Skip installing it."
fi

#######################################################################
#                                Nvim install                         #
#######################################################################
NVIM_DIR=$HOME/tools/nvim
NVIM_SRC_NAME=$HOME/packages/nvim-linux64.tar.gz
NVIM_CONFIG_DIR=$HOME/.config/nvim
NVIM_LINK="https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz"
if [[ ! -f "$NVIM_DIR/bin/nvim" ]]; then
    echo "Installing Nvim"
    echo "Creating nvim directory under tools directory"

    if [[ ! -d "$NVIM_DIR" ]]; then
        mkdir -p "$NVIM_DIR"
    fi

    if [[ ! -f $NVIM_SRC_NAME ]]; then
        echo "Downloading Nvim"
        wget "$NVIM_LINK" -O "$NVIM_SRC_NAME"
    fi
    echo "Extracting neovim"
    tar zxvf "$NVIM_SRC_NAME" --strip-components 1 -C "$NVIM_DIR"

    echo "export PATH=\"$NVIM_DIR/bin:\$PATH\"" >> "$HOME/.zshrc"

    pip3 install pynvim
else
    echo "Nvim is already installed. Skip installing it."
fi

echo "Setting up config and installing plugins"
if [[ -d "$NVIM_CONFIG_DIR" ]]; then
    rm -rf "$NVIM_CONFIG_DIR.backup"
    mv "$NVIM_CONFIG_DIR" "$NVIM_CONFIG_DIR.backup"
fi

git clone --depth=1 https://github.com/tonyparkerspb/nvim-config-portable.git "$NVIM_CONFIG_DIR"

echo "Installing packer.nvim"
if [[ ! -d ~/.local/share/nvim/site/pack/packer/opt/packer.nvim ]]; then
    git clone --depth=1 https://github.com/tonyparkerspb/packer.nvim \
        ~/.local/share/nvim/site/pack/packer/opt/packer.nvim
fi

echo "Installing nvim plugins, please wait"
"$NVIM_DIR/bin/nvim" -c "autocmd User PackerComplete quitall" -c "PackerSync"

if ! command -v pygmentize &> /dev/null
then
  pip install Pygments 
fi

if ! command -v nnn &> /dev/null
then
  sudo apt install nnn
fi

if ! command -v rg &> /dev/null
then
  sudo apt install ripgrep
fi

if [[ ! -f ~/.config/starship.toml ]]; then
  curl -sS https://starship.rs/install.sh | sh
  ln -s ~/.starship.toml ~/.config/starship.toml
fi

if ! command -v autojump &> /dev/null
then
  sudo apt install autojump
fi

if ! command -v unzip &> /dev/null
then
  sudo apt install zip
  sudo apt install unzip
fi

echo "Finished installation process!"
