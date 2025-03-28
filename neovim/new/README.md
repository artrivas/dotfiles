When installing neovim, the apt repository usually have not the latest version
```bash
sudo apt install neovim
```
In order to install neovim at its latest version is:

```bash
chmod u+x nvim.appimage && ./nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
```
Then follow cited instructions to install [NvChad](https://nvchad.com/docs/quickstart/install/)
## Installing a NerdFont
First we download a [NerdFont](https://www.nerdfonts.com/font-downloads), we've chosen **JetBrainsMono Nerd Font**.
Then we run the next commands:
```bash
unzip JetBrainsMono.zip
mkdir /usr/local/share/fonts # In case you don't have that folder
sudo mv *.ttf /usr/local/share/fonts/ #Or .otf in case you have those files
```
## Install Node.js
In order to install lsp servers, we've to install [Node.js](https://nodejs.org/en/download).
# Tips

If clangd does not recognize your c++ headers (iostream, vector, etc)

Run this

```bash
sudo apt install g++-12
```
## Problems
### GCC compiler
Sometimes I've this error: "AddressSanitizer:DEADLYSIGNAL" and in this [discussion](https://github.com/actions/runner-images/issues/9491) they say one of the solutions is to upgrade LLVM. I'm not pretty sure if that would work, because from what I understood LLVM is related to clang and not to GCC.
To upgrade LLVM use the next commands:
```bash
sudo apt install -y wget gnupg lsb-release software-properties-common
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh <version> #Could be either 16, 17 or above
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-17 100
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-17 100
```
Update: It didn't work, so we try to upgrade gcc compiler by doing this:
```bash
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt update
sudo apt install gcc-13 g++-13
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 100
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-13 100

```
### Copy-Paste on main clipboard
To copy and paste on the main clipboard, run these commands:
```bash
sudo apt install xclip
sudo apt install xsel
```
# To be finished
- vim colors
