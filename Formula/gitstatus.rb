class Gitstatus < Formula
  desc "Git status for Bash/Zsh prompt"
  homepage "https://github.com/romkatv/gitstatus"
  url "https://github.com/romkatv/gitstatus/archive/v1.4.2.tar.gz"
  sha256 "dcdac28d0838f651c3c86de8e77de3b01d2775f1f7d75674676554967c2522e2"

  depends_on "bash" => :test
  depends_on "zsh"  => :test

  def install
    system 'make', 'pkg'
    prefix.install Dir["*"]
  end

  def caveats
    <<~EOS
      To activate gitstatus in Bash, add the following line to .bashrc:

        source #{opt_prefix}/gitstatus.prompt.sh

      To activate gitstatus in Zsh, add the following line to .zshrc:

        source #{opt_prefix}/gitstatus.prompt.zsh

      If your .zshrc sets ZSH_THEME, remove that line.
    EOS
  end

  test do
    assert_match "SUCCESS",
      shell_output("bash --norc -ic '. #{opt_prefix}/gitstatus.prompt.zsh && gitstatus_start MY && echo SUCCESS'")
    assert_match "SUCCESS",
      shell_output("zsh -fic '. #{opt_prefix}/gitstatus.prompt.zsh && gitstatus_start MY && echo SUCCESS'")
  end
end
