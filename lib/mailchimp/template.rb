require 'html2haml'

module Mailchimp
  class Template
    @extension = '.html'

    attr_accessor :html, :name, :id, :destination_dir, :remote_version

    def initialize(attrs, destination_dir = Dir.pwd)
      @destination_dir = destination_dir
      @id = attrs['id']
      @name = attrs['name']
    end

    def load
      @remote_version = Mailchimp.config.client.templateInfo({'tid' => id}) unless id.nil?
      @html = @remote_version['source'] unless remote_version.nil?
    end

    def self.from_file(name, destination_dir = Dir.pwd)
      template = new({'name' => File.basename(name, @extension).gsub('_', ' ')}, destination_dir)
      template.read
      persisted_template = Mailchimp.config.client.templates['user'].select do |t|
        t['name'] == template.name
      end[0]
      template.id = persisted_template['id'] unless persisted_template.nil?
      template
    end

    def read
      @html = File.new(destination).read
    end

    def filename
      @name.gsub(' ', '_')
    end

    def extension
      self.class.instance_variable_get(:@extension)
    end

    def destination
      "#{File.join(destination_dir, filename)}#{extension}"
    end

    def payload
      if id
        { 'id' => id, 'values' => { 'html' => remote_content, 'name' => name } }
      else
        {'html' => remote_content, 'name' => name}
      end
    end

    def exists?
      File.exists?(destination)
    end

    def dir_exists?
      File.exists?(destination_dir)
    end

    def write
      FileUtils.mkdir_p(destination_dir) unless dir_exists?
      puts "Writing template #{filename}#{extension}"
      file = File.new(destination, 'w+')
      file.write(local_content)
    end

    def save
      if id
        Mailchimp.config.client.templateUpdate(payload)
      else
        Mailchimp.config.client.templateAdd(payload)
      end
    end

    def local_content; html; end
    def remote_content; html; end
  end

  class HamlTemplate < Template
    @extension = '.html.haml'

    def initialize(attrs, destination_dir = Dir.pwd)
      super(attrs, destination_dir)
    end

    def load
      super
      @html = Haml::HTML.new(@html).render
    end

    def remote_content
      Haml::Engine.new(super || '').render
    end
  end
end
