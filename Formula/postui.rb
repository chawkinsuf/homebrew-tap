class Postui < Formula
  desc "A fast, local-first terminal HTTP client"
  homepage "https://github.com/chawkinsuf/postui"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/chawkinsuf/postui/releases/download/v0.4.0/postui-aarch64-apple-darwin.tar.xz"
      sha256 "5fb28586ad3a0443df3332eb484c8a2223f7141960de09dcc05f66ad1f80e572"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chawkinsuf/postui/releases/download/v0.4.0/postui-x86_64-apple-darwin.tar.xz"
      sha256 "082764aadfd3a2bd9e6a273e30992a44f1d0730cf1af5bf3ba4123c340da0416"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/chawkinsuf/postui/releases/download/v0.4.0/postui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "09b7635b75d94ced93fd2d4dc4e2ed88266134bd1734532c389c5104e2bdf83e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chawkinsuf/postui/releases/download/v0.4.0/postui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3cc9faed3be08f980fe3288529cbe8be96dd30aeb58bcf82377d8601d86321ce"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "postui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "postui"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "postui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "postui"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
