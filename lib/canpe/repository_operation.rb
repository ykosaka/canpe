require 'active_support'
require 'active_support/core_ext'
require 'tilt'

require 'canpe/file_manipulation'
require 'canpe/template_renderer'
require 'canpe/repository_operation_context'

module Canpe
  class RepositoryOperation
    include FileManipulation

    attr_reader :repository, :renderer, :context

    def initialize(repository)
      @repository = repository
      @renderer = TemplateRenderer.new(self)
      @context = RepositoryOperationContext.new(self)
    end

    def prepare_operation(options = {})
      context.prepare(options)
      renderer.prepare(options)
    end

    def generate_file(path)
      if File.directory?(context.source_file_path(path))
        create_evaluated_directory(path)
      else
        copy_evaluated_file(path)
      end
    end

    def create_evaluated_directory(path)
      path = renderer.render_string(path)
      url = File.join(context.destination_root, path)
      create_directory(url)
    end

    def copy_evaluated_file(path)
      template_file = renderer.render_file(context.source_file_path(path))
      copy_file(template_file.path, context.destination_file_path(path))
    end

    def delete_file(path)
      super context.destination_file_path(path)
    end
  end
end
