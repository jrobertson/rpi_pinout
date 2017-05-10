Gem::Specification.new do |s|
  s.name = 'rpi_pinout'
  s.version = '0.2.0'
  s.summary = 'Represents a Raspberry Pi GPIO pin. Used by the simple_raspberrypi gem'
  s.authors = ['James Robertson']
  s.files = Dir['lib/rpi_pinout.rb']
  s.add_runtime_dependency('pinx', '~> 0.1', '>=0.1.1')
  s.signing_key = '../privatekeys/rpi_pinout.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/rpi_pinout'
end
