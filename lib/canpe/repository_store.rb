require 'active_support'
require 'active_support/core_ext'
require 'fileutils'
require 'pry'

module Canpe
  class RepositoryStore
    class << self
      def root_url
        ENV['HOME']
      end

      def repository_dir
        '.canpe_repos'
      end

      def repositories_root
        File.join(root_url, repository_dir)
      end

      def repository_list
        repository_list = []
        dir_list = Dir.glob(File.join(repositories_root, '*'))
        dir_list.each do |dir_path|
          repository_list << File.basename(dir_path) if File.directory? dir_path
        end
        repository_list
      end
    end
  end
end
