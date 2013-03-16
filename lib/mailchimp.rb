require './lib/mailchimp/configuration.rb'
require './lib/mailchimp/template.rb'

module Mailchimp
  @config = Configuration.new
  def self.config; @config; end

  def self.configure(&block)
    block.call(config)
  end
end

