require 'canpe/template_binding'

module Canpe
  class TemplateRenderer
    attr_accessor :repository_operation, :injected_hash

    def initialize(repository_operation, hash = {}.with_indifferent_access)
      @repository_operation = repository_operation
      @injected_hash = hash
    end

    def repository
      repository_operation.repository
    end

    def prepare
      hash = {}

      if repository.binding_options['variables'].blank?
        return puts 'skip variable injection.'
      end

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
      injected_hash.merge!(hash)

      puts "finished variable settings: #{hash}"
    end

    def render_string(str)
      template = Tilt::ERBTemplate.new { str.to_s }
      template.render(Canpe::TemplateBinding.new(injected_hash))
    end

    def render_file(path)
      Tempfile.new.tap do |file|
        template = Tilt::ERBTemplate.new(path)
        file.write(template.render(Canpe::TemplateBinding.new(injected_hash)))
        file.rewind
      end
    end
  end
end
