class Postui < Formula
  desc "A fast, local-first terminal HTTP client"
  homepage "https://github.com/chawkinsuf/postui"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/chawkinsuf/postui/releases/download/v0.2.0/postui-aarch64-apple-darwin.tar.xz"
      sha256 "76e9f4086cf4c1aefa941e983662954ab8d02fbf0aba019ca10347ae2e255c7d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chawkinsuf/postui/releases/download/v0.2.0/postui-x86_64-apple-darwin.tar.xz"
      sha256 "f484082a085e692934622ceee010ebd5feaa95e628949c0ec87c0b5eaaf4e357"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/chawkinsuf/postui/releases/download/v0.2.0/postui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "62e6cc87768963359ec26e0bee551702b872910bfaeb5e1b968ee9d40938ef82"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chawkinsuf/postui/releases/download/v0.2.0/postui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3c5bc225c6c0585b09f5fcec1a267e7e1b9b45374ce7d2b0df821f9a7dfd972f"
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
