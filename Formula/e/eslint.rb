class Eslint < Formula
  desc "AST-based pattern checker for JavaScript"
  homepage "https://eslint.org"
  url "https://registry.npmjs.org/eslint/-/eslint-9.12.0.tgz"
  sha256 "ab67c1c95b8202705efb25b9a56005c8fcb2e6c007c0b6be542288c1fe1ee10b"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6ad5da2b53bea1a9d0523ea7a3011562e7fd4abf4bd5b64fa8820fa17d27e8cd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6ad5da2b53bea1a9d0523ea7a3011562e7fd4abf4bd5b64fa8820fa17d27e8cd"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "6ad5da2b53bea1a9d0523ea7a3011562e7fd4abf4bd5b64fa8820fa17d27e8cd"
    sha256 cellar: :any_skip_relocation, sonoma:        "e53b15886e751715e952e46425438f7aec7bbfc9699c924ab391acc776c8df36"
    sha256 cellar: :any_skip_relocation, ventura:       "e53b15886e751715e952e46425438f7aec7bbfc9699c924ab391acc776c8df36"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6ad5da2b53bea1a9d0523ea7a3011562e7fd4abf4bd5b64fa8820fa17d27e8cd"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    # https://eslint.org/docs/latest/use/configure/configuration-files#configuration-file
    (testpath/"eslint.config.js").write("{}") # minimal config
    (testpath/"syntax-error.js").write("{}}")

    # https://eslint.org/docs/user-guide/command-line-interface#exit-codes
    output = shell_output("#{bin}/eslint syntax-error.js", 1)
    assert_match "Unexpected token }", output
  end
end
