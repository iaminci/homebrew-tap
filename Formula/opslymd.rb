class Opslymd < Formula
  desc "Render Markdown in the terminal, like cat but formatted"
  homepage "https://github.com/iaminci/opslymd-cli"
  url "https://github.com/iaminci/opslymd-cli/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "cb1a0d19f0ecb979ed543d2139e4ccb3a76d3b3a2fb405ac8d82953b0bac1d40"
  license "MIT"
  head "https://github.com/iaminci/opslymd-cli.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags:)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/opslymd --version")

    (testpath/"test.md").write <<~MARKDOWN
      # Title

      - [x] done
      - [ ] todo
    MARKDOWN
    output = shell_output("#{bin}/opslymd --no-color #{testpath}/test.md")
    assert_match "Title", output
    assert_match "[x] done", output

    (testpath/"plain.txt").write("# not rendered\n")
    assert_equal "# not rendered\n", shell_output("#{bin}/opslymd #{testpath}/plain.txt")
  end
end
