require 'active_support'
require 'active_support/core_ext'
require 'tilt'

require 'canpe/file_manipulation'
require 'canpe/template_binding'
require 'canpe/template_renderer'

module Canpe
  class RepositoryOperation
    include FileManipulation

    attr_reader :repository, :renderer

    def initialize(repository)
      @repository = repository
      @renderer = TemplateRenderer.new
    end

    def prepare_operation
      hash = {}

      puts 'skip variable injection.' and return if repository.binding_options['variables'].blank?

      puts 'you need to set variables to generate codes!'
      repository.binding_options['variables'].each.with_index(1) do |entry, index|
        puts "#{index}: #{entry['name']} (#{entry['type']}) "
      end

      puts ''
      puts 'If you want to stop setting array, let it blank and press enter.'

      repository.binding_options['variables'].each do |entry|
        if entry['type'] == 'string'
          print "#{entry['name']} ?) "
          hash[entry['name']] = STDIN.gets.chomp
        elsif entry['type'] == 'array'
          array = []
          loop do
            print "#{entry['name']}[#{array.size}] ?) "
            input = STDIN.gets.chomp

            if input.present?
              array << input
            else
              break
            end
          end

          hash[entry['name']] = array
        end
      end
      renderer.injected_hash.merge!(hash)

      puts "finished variable settings: #{hash}"
    end

    def generate_file(path)
      if File.directory?(source_file_path(path))
        create_evaluated_directory(path)
      else
        copy_evaluated_file(path)
      end
    end

    def create_evaluated_directory(path)
      path = renderer.render_string(path)
      url = File.join(destination_root, path)
      create_directory(url)
    end

    def copy_evaluated_file(path)
      template_file = renderer.render_file(File.join(repository.templates_url, path))
      copy_file(template_file.path, destination_file_path(path))
    end

    def delete_file(path)
      super destination_file_path(path)
    end

    private

    def source_root
      repository.templates_url
    end

    def destination_root
      Dir.pwd
    end

    def source_file_path(path)
      File.join(source_root, path)
    end

    def destination_file_path(path)
      renderer.render_string(File.join(destination_root, path))
    end
  end
end
