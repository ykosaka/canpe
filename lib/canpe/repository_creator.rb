require 'canpe/file_manipulation'
require 'canpe/repository_store'

module Canpe
  class RepositoryCreator
    include FileManipulation
    attr_reader :repository_name

    def initialize(repository_name)
      @repository_name = repository_name
    end

    def execute
      create_directory(File.join(Dir.pwd, RepositoryStore::DEFAULT_REPOSITORY_DIR, repository_name, 'templates'))
    end
  end
end
