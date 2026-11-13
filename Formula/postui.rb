class Postui < Formula
  desc "A fast, local-first terminal HTTP client"
  homepage "https://github.com/chawkinsuf/postui"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/chawkinsuf/postui/releases/download/v0.4.1/postui-aarch64-apple-darwin.tar.xz"
      sha256 "9f6cad11911ea66ee5e8570c399558bccfb240e9bf7d8cc36aab07264fda42f0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chawkinsuf/postui/releases/download/v0.4.1/postui-x86_64-apple-darwin.tar.xz"
      sha256 "88c3ec06c7c4036463c682ea69dd9815d19772e69bcfdd2fe12c54ba4ca69657"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/chawkinsuf/postui/releases/download/v0.4.1/postui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "86a3456f00b492a55a4b41134ad5e26791156545aa9d1cdaf641c0dbf8c4824a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chawkinsuf/postui/releases/download/v0.4.1/postui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "66445c853739cb239dbf0ccf3ac49d554eb87c762c5a9f56e39b1d994ef42ac5"
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
