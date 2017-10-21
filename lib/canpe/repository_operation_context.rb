module Canpe
  class RepositoryOperationContext
    attr_accessor :repository_operation, :root_directory

    def initialize(repository_operation, root_directory = nil)
      @repository_operation = repository_operation
      @root_directory = root_directory
    end

    def repository
      repository_operation.repository
    end

    def prepare(options)
      working_directory = options[:working_directory]

      if working_directory.nil?
        print "working directory (#{Dir.pwd}) ? "
        working_directory = STDIN.gets.chomp
      end

      if working_directory.blank?
        working_directory = Dir.pwd
      elsif !File.directory?(working_directory)
        raise FileManipulation::NotDirectoryError, "#{working_directory} is not a directory."
      end

      @root_directory = working_directory
    end

    def source_root
      repository.templates_url
    end

    def destination_root
      root_directory
    end

    def source_file_path(path)
      File.join(source_root, path)
    end

    def destination_file_path(path)
      repository_operation.renderer.render_string(File.join(destination_root, path))
    end
  end
end
