require 'active_support'
require 'active_support/core_ext'
require 'fileutils'
require 'pry'

require 'canpe/repository'

module Canpe
  class RepositoryStore
    attr_reader :path

    LOAD_PATHS = [Dir.pwd, ENV['HOME']]
    DEFAULT_REPOSITORY_DIR = '.canpe_repos'

    class << self
      def repository_stores
        stores = []
        LOAD_PATHS.each do |path|
          repository_store_path = File.join(path, DEFAULT_REPOSITORY_DIR)
          stores << new(path) if File.directory?(repository_store_path)
        end
        stores
      end

      def repository_list
        @_repository_list ||= repository_stores.map { |store| store.repository_list }.flatten
      end
    end

    def initialize(path)
      @path = path
    end

    def root_url
      path
    end

    def repository_dir
      DEFAULT_REPOSITORY_DIR
    end

    def repositories_root
      File.join(root_url, repository_dir)
    end

    def repository_list
      repository_list = []
      dir_list = Dir.glob(File.join(repositories_root, '*'))
      dir_list.each do |dir_path|
        repository_list << Repository.new(File.basename(dir_path), self) if File.directory? dir_path
      end
      repository_list
    end

    def name
      if path == ENV['HOME']
        'HOME'
      else
        Pathname.new(path).relative_path_from(Pathname.new(ENV['HOME']))
      end
    end
  end
end
