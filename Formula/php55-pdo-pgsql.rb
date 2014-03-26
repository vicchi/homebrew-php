require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55PdoPgsql < AbstractPhp55Extension
  init
  homepage 'https://github.com/php/php-src/tree/master/ext/pdo_pgsql'
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on 'postgresql'

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula['postgresql'].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file
  end
end
