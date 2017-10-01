require 'thor'
require 'canpe/repository'
require 'canpe/repository_store'
require 'tilt'
require 'pry'

module Canpe
  class Scaffold
    attr_reader :repository

    def initialize(repository_name)
      @repository = Repository.new(repository_name)
    end

    def source_root
      repository.templates_url
    end

    def destination_root
      Dir.pwd
    end

    def generate
      repository.file_paths.each do |path|
        if File.directory?(source_path(path))
          create_directory(path)
        else
          if Tilt[File.extname(path)].present?
            copy_template_file(path)
          else
            copy_file(path)
          end
        end
      end
    end

    def destroy
      template_file_paths.each do |path|
        delete_file(path)
      end
    end

    def create_directory(path)
      FileUtils.mkdir_p(File.join(destination_root, path))
    end

    def copy_file(path)
      FileUtils.cp(source_path(path), destination_path(path))
    end

    def copy_template_file(path)
      template = Tilt.new(File.join(repository.templates_url, path))
      File.write(destination_path(path), template.render)
    end

    def delete_file(path)
      FileUtils.rm(destination_path(path))
    end

    private

    def source_path(path)
      File.join(source_root, path)
    end

    def destination_path(path)
      File.join(destination_root, path)
    end

    def trim_file_ext(path)
      File.basename(path, File.extname(path.to_s))
    end
  end
end
