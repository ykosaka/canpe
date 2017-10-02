require 'fileutils'

module Canpe
  module FileManipulation

    class NotDirectoryError < StandardError; end

    def create_directory(url)
      puts "create directory: #{url}"
      FileUtils.mkdir_p(url)
    end

    def copy_file(source_url, destination_url)
      puts "copy: #{destination_url}"

      directory = File.dirname(destination_url)

      if File.exists?(directory)
        if File.directory?(directory)
          FileUtils.cp(source_url, destination_url)
        else
          raise NotDirectoryError, "Failed to copy #{destination_url}, because #{directory} is not a directory."
        end
      else
        create_directory(directory)
        FileUtils.cp(source_url, destination_url)
      end
    end

    def remove_file(url)
      puts "delete: #{url}"
      FileUtils.rm(url)
    end
  end
end
