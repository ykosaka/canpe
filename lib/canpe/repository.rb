require 'active_support'
require 'active_support/core_ext'
require 'fileutils'
require 'pry'
require 'canpe/repository_store'

module Canpe
  class Repository
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def repository_url
      File.join(RepositoryStore.repositories_root, name)
    end

    def templates_url
      File.join(RepositoryStore.repositories_root, name, 'templates')
    end

    def file_paths(absolute_path: false)
      files = Dir.glob(File.join(templates_url, '**', '*'))
      if absolute_path
        files.map { |file| Pathname.new(file) }
      else
        base = Pathname.new(templates_url)
        files.map { |file| Pathname.new(file).relative_path_from(base) }
      end
    end
  end
end
