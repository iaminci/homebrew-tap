class Opslymd < Formula
  desc "Render Markdown in the terminal, like cat but formatted"
  homepage "https://github.com/iaminci/opslymd-cli"
  url "https://github.com/iaminci/opslymd-cli/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "7e898720c53b25d9b7fed8c84aed2d3d7899a8a9bcd8408b0dc5179e2038dad6"
  license "MIT"
  head "https://github.com/iaminci/opslymd-cli.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/opslymd"
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
