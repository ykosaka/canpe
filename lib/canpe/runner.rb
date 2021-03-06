require 'thor'
require 'canpe/repository'
require 'canpe/repository_store'
require 'canpe/repository_operation'
require 'canpe/repository_creator'
require 'tilt'
require 'pry'

module Canpe
  class Runner
    class << self
      def generate(repository, options: {})
        operation = RepositoryOperation.new(repository)
        operation.prepare_operation(options)
        repository.file_paths.each { |path| operation.generate_file(path) }
      end

      def create(repository_name)
        repository_creator = RepositoryCreator.new(repository_name)
        repository_creator.execute
      end
    end
  end
end
