# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mailchimp_templates/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["benastan"]
  gem.email         = ["bennyjbergstein@gmail.com"]
  gem.description   = "Push and pull Mailchimp templates locally."
  gem.summary       = "Templates and stuff"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mailchimp_templates"
  gem.require_paths = ["lib"]
  gem.version       = MailchimpTemplates::VERSION

  gem.add_dependency 'rake'
  gem.add_dependency 'gibbon'
  gem.add_dependency 'foreman'
  gem.add_dependency 'html2haml'
end
