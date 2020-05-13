class Gitstatus < Formula
  desc "Git status for Bash/Zsh prompt"
  homepage "https://github.com/romkatv/gitstatus"
  url "https://github.com/romkatv/gitstatus/archive/v1.1.0.tar.gz"
  sha256 "f1e6f48cdf39550dd42128a229d9acc681cf92d71130d7920d999295abca8909"

  depends_on "bash" => :test
  depends_on "zsh"  => [:build, :test]

  def install
    system 'zsh', '-fc', 'GITSTATUS_CACHE_DIR="$PWD"/usrbin ./install -f'
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
