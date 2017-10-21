require 'active_support'
require 'active_support/core_ext'
require 'yaml'
require 'fileutils'
require 'pry'
require 'canpe/repository_store'

module Canpe
  class Repository
    attr_reader :name, :store

    def initialize(name, store)
      @name = name
      @store = store
    end

    # Directory which is root directory of this repository
    def repository_url
      File.join(store.repositories_root, name)
    end

    # Directory in which templates file exists
    def templates_url
      File.join(store.repositories_root, name, 'templates')
    end

    def binding_option_url
      File.join(repository_url, 'binding.yml')
    end

    def binding_options
      @_binding_options ||= File.exists?(binding_option_url) ? YAML.load_file(binding_option_url) : {}
    end

    def file_paths(absolute_path: false)
      files = Dir.glob(File.join(templates_url, '**', '*'), File::FNM_DOTMATCH)
      files = files.reject { |e| [".", ".."].any? { |s| s== File::basename(e) } }

      if absolute_path
        files.map { |file| Pathname.new(file) }
      else
        base = Pathname.new(templates_url)
        files.map { |file| Pathname.new(file).relative_path_from(base) }
      end
    end

    def to_s
      "#{store.name}::#{name}"
    end

    def match?(query)
      /#{query}/ === to_s
    end
  end
end
