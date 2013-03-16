require 'mailchimp'

SOURCE_DIR ||= File.join(Dir.pwd, 'templates')

Mailchimp.configure do |config|
  config.client = Gibbon.new(ENV['MAILCHIMP_KEY'])
end

namespace :mailchimp do
  namespace :templates do
    task :list do
      Mailchimp.config.client.templates.each do |template|
        puts template
      end
    end

    desc "Pull existing templates from your Mailchimp account"
    task :pull do
      templates = Mailchimp.config.client.templates['user'].collect do |template|
        Mailchimp::HamlTemplate.new(template, SOURCE_DIR)
      end

      unless templates.select(&:exists?).empty?
        puts "Local versions of some templates already exist, overwrite? (y/n)"
        while %w(y n).include?(confirm = STDIN.gets[0]) == false; puts "Please enter y or n."; end
      end
      templates = templates.reject(&:exists?) if confirm == 'n'
      templates.each(&:load).each(&:write)
    end

    desc "Push template changes to your Mailchimp account"
    task :push do
      Dir.new(SOURCE_DIR).each do |file|
        if File.file?(File.join(SOURCE_DIR, file))
          template = Mailchimp::HamlTemplate.from_file(file, SOURCE_DIR)
          template.save
        end
      end
    end
  end
end

