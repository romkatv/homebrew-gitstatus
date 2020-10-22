class Gitstatus < Formula
  desc "Git status for Bash/Zsh prompt"
  homepage "https://github.com/romkatv/gitstatus"
  url "https://github.com/romkatv/gitstatus/archive/v1.3.1.tar.gz"
  sha256 "cdfd30c2f08a3a8519110c5f8ea242dae9af25e7b67bffc6d4f2bd2f1f7f48f9"

  depends_on "bash" => :test
  depends_on "zsh"  => [:build, :test]

  def install
    system 'zsh', '-fc', 'unset -m "GITSTATUS_*"; GITSTATUS_CACHE_DIR="$PWD"/usrbin ./install -f'
    system 'zsh', '-fc', 'emulate zsh -o no_aliases; for f in *.zsh install; do zcompile -R -- $f.zwc $f || exit; done'
    prefix.install Dir["*"]
  end

  def caveats
    <<~EOS
      To activate gitstatus in Bash, add the following line to .bashrc:

        source #{opt_prefix}/gitstatus.prompt.sh

      To activate gitstatus in Zsh, add the following line to .zshrc:

        source #{opt_prefix}/gitstatus.prompt.zsh
    EOS
  end

  test do
    assert_match "SUCCESS",
      shell_output("bash --norc -ic '. #{opt_prefix}/gitstatus.prompt.zsh && gitstatus_start MY && echo SUCCESS'")
    assert_match "SUCCESS",
      shell_output("zsh -fic '. #{opt_prefix}/gitstatus.prompt.zsh && gitstatus_start MY && echo SUCCESS'")
  end
end
