Gem::Specification.new do |s|
  s.name = %q{relayrace}
  s.version = "1.0.2"
  s.date = %q{2010-07-23}
  s.authors = ["Mat Trudel"]
  s.email = %q{mat@geeky.net}
  s.summary = %q{RelayrAce talks to Canakit USB relay boards.}
  s.description = %q{RelayrAce talks to Canakit USB relay boards.}
  s.files = [ "README", "LICENCE", "lib/relayrace.rb"]
  s.add_dependency('ruby-serialport')
  s.add_dependency('SystemTimer')
end