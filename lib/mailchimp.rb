require 'gibbon'
require 'mailchimp/configuration'
require 'mailchimp/template'

module Mailchimp
  @config = Configuration.new
  def self.config; @config; end

  def self.configure(&block)
    block.call(config)
  end
end

