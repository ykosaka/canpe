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
      repository_list = Canpe::RepositoryStore.repository_list
      repository = repository_list.find { |repository| repository.match? 'default_repository' }

      if repository.blank?
        $stderr.puts "Could not find repository \"#{repository_name}\"."
        exit 1
      end

      Canpe::Runner.generate repository, options: { variables: { repository_name: repository_name }, working_directory: Dir.pwd }
    end
  end
end
