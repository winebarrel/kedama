Gem::Specification.new do |spec|
  spec.name              = 'kedama'
  spec.version           = '0.1.0'
  spec.summary           = 'kedama is ruby port of the libketama.'

  spec.description       = <<-EOS
kedama is ruby port of the libketama.
libketama is a consistent hashing library.
see http://bit.ly/dVIeGh
  EOS

  spec.require_paths     = %w(lib)
  spec.files             = Dir.glob('lib/*.rb') + %w(README)
  spec.author            = 'winebarrel'
  spec.email             = 'sgwr_dts@yahoo.co.jp'
  spec.homepage          = 'https://bitbucket.org/winebarrel/kedama'
  spec.has_rdoc          = false
end