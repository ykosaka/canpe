require 'active_support'
require 'active_support/core_ext'
require 'fileutils'
require 'pry'

module Canpe
  class RepositoryStore
    attr_reader :root_url, :repository_dir

    def initialize(options = {})
      @root_url = options['root_dir_path'] || ENV['HOME']
      @repository_dir = options['repository_dir_name'] || File.join('.canpe_repos')

      FileUtils.mkdir_p repositories_root unless Dir.exists?(repositories_root)
    end

    def repositories_root
      File.join(root_url, templates_dir)
    end

    def repository_dir(template_name)
      File.join(root_url, templates_dir, template_name)
    end

    def repository_list
      repository_list = []
      dir_list = Dir.glob(File.join(repositories_root, '*'))
      dir_list.each do |dir_path|
        repository_list << File.basename(dir_path) if File.directory? dir_path
      end
      repository_list
    end

    def absolute_repository_file_paths(repository_name)
      files = Dir.glob(File.join(repositories_root, repository_name, '**', '*'))
      files.map { |file| Pathname.new(file) }
    end

    def relative_repository_file_paths(repository_name)
      files = Dir.glob(File.join(repositories_root, repository_name, '**', '*'))
      base = Pathname.new(repository_dir(repository_name))
      files.map { |file| Pathname.new(file).relative_path_from(base) }
    end
  end
end
