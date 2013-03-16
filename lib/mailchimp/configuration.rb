module Mailchimp
  class Configuration
    attr_accessor :client, :base_dir

    def initialize
      self.base_dir = Dir.pwd
    end
  end
end
