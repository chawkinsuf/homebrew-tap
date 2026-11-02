class Postui < Formula
  desc "A fast, local-first terminal HTTP client"
  homepage "https://github.com/chawkinsuf/postui"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/chawkinsuf/postui/releases/download/v0.3.0/postui-aarch64-apple-darwin.tar.xz"
      sha256 "1597528ac4c6d6d0c106c472a0012664b43f22499bf18955966693cef7cc62b4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chawkinsuf/postui/releases/download/v0.3.0/postui-x86_64-apple-darwin.tar.xz"
      sha256 "29bf85c5b9ead6394e83301a50e859320ecccacde861f0aa792f27e259c002a6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/chawkinsuf/postui/releases/download/v0.3.0/postui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "57b3f4bea2800f5203c14eb231bbc59236507ed827f20643bb62e091b37f7b45"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chawkinsuf/postui/releases/download/v0.3.0/postui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "88a64179e03be813dc4edbabcd4e3c7fc9648ca64255179a94ff8aaf9bc64fc1"
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
