require 'active_support'
require 'active_support/core_ext'
require 'fileutils'

module PowerGenerate
  class TemplateStore
    attr_reader :root_url, :template_dir

    def initialize(options = {})
      @root_url = options['root_dir_path'] || ENV['HOME']
      @template_dir = options['template_dir_name'] || File.join('.power_generate', 'templates')

      FileUtils.mkdir_p template_dir_url unless Dir.exists?(template_dir_url)
    end

    def template_dir_url
      File.join(root_url, template_dir)
    end

    def template_list
      template_dir_list = []
      dir_list = Dir.glob(File.join(template_dir_url, '*'))
      dir_list.each do |dir_path|
        template_dir_list << File.basename(dir_path) if File.directory? dir_path
      end
      template_dir_list
    end
  end
end
