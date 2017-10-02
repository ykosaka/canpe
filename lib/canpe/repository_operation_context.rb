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

    def prepare
      print "working directory (#{Dir.pwd}) ? "
      path = STDIN.gets.chomp

      if path.blank?
        path = Dir.pwd
      elsif !File.directory?(path)
        raise FileManipulation::NotDirectoryError, "#{path} is not a directory."
      end

      @root_directory = path
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
