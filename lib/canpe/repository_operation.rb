require 'active_support'
require 'active_support/core_ext'
require 'tilt'

require 'canpe/template_binding'

module Canpe
  class RepositoryOperation
    attr_reader :repository
    attr_accessor :injected_hash

    def initialize(repository)
      @repository = repository
      @injected_hash = {}
    end

    def prepare_operation
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
          injected_hash[entry['name']] = STDIN.gets.chomp
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

          injected_hash[entry['name']] = array
        end
      end

      puts "finished variable settings: #{injected_hash}"
    end

    def generate_file(path)
      if File.directory?(source_file_path(path))
        create_directory(path)
      else
        copy_template_file(path)
      end
    end

    def eval_file_name(path)
      template = Tilt::ERBTemplate.new { path.to_s }
      template.render(Canpe::TemplateBinding.new, injected_hash)
    end

    def create_directory(path)
      path = eval_file_name(path)
      url = File.join(destination_root, path)
      puts "create directory: #{url}"
      FileUtils.mkdir_p(url)
    end

    def copy_template_file(path)
      puts "create: #{destination_file_path(path)} (template)"
      template = Tilt::ERBTemplate.new(File.join(repository.templates_url, path))
      File.write(destination_file_path(path), template.render(Canpe::TemplateBinding.new, injected_hash))
    end

    def delete_file(path)
      puts "delete: #{destination_file_path(path)}"
      FileUtils.rm(destination_file_path(path))
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
      eval_file_name(File.join(destination_root, path))
    end
  end
end
