require 'thor'
require 'canpe/repository'
require 'canpe/repository_store'
require 'canpe/repository_operation'
require 'tilt'
require 'pry'

module Canpe
  class Scaffold
    attr_reader :repository, :operation

    def initialize(repository_name)
      @repository = Repository.new(repository_name)
      @operation = RepositoryOperation.new(@repository)
    end

    def generate
      operation.prepare_operation
      repository.file_paths.each { |path| operation.generate_file(path) }
    end

    def destroy
      repository.file_paths.each { |path| operation.delete_file(path) }
    end
  end
end
