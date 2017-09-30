require 'active_support'
require 'active_support/core_ext'
require 'fileutils'
require 'pry'

module Canpe
  class TemplateStore
    attr_reader :root_url, :templates_dir

    def initialize(options = {})
      @root_url = options['root_dir_path'] || ENV['HOME']
      @templates_dir = options['template_dir_name'] || File.join('.canpe_repos', 'templates')

      FileUtils.mkdir_p templates_root unless Dir.exists?(templates_root)
    end

    def templates_root
      File.join(root_url, templates_dir)
    end

    def template_dir(template_name)
      File.join(root_url, templates_dir, template_name)
    end

    def template_list
      template_dir_list = []
      dir_list = Dir.glob(File.join(templates_root, '*'))
      dir_list.each do |dir_path|
        template_dir_list << File.basename(dir_path) if File.directory? dir_path
      end
      template_dir_list
    end

    def absolute_template_file_paths(template_name)
      files = Dir.glob(File.join(templates_root, template_name, '**', '*'))
      files.map { |file| Pathname.new(file) }
    end

    def relative_template_file_paths(template_name)
      files = Dir.glob(File.join(templates_root, template_name, '**', '*'))
      base = Pathname.new(template_dir(template_name))
      files.map { |file| Pathname.new(file).relative_path_from(base) }
    end
  end
end
