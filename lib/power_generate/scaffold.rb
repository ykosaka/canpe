require 'thor'
require 'power_generate/template_store'
require 'tilt'
require 'pry'

module PowerGenerate
  class Scaffold
    attr_reader :template_name
    attr_reader :template_dir
    attr_reader :template_file_paths

    def initialize(template_name, options = {})
      @template_name = template_name
      @template_dir = TemplateStore.new.template_dir(template_name)
      @template_file_paths = TemplateStore.new.relative_template_file_paths(template_name)
    end

    def source_root
      template_dir
    end

    def destination_root
      Dir.pwd
    end

    def generate
      template_file_paths.each do |path|
        if Tilt[File.extname(path)].present?
          copy_template_file(path)
        else
          copy_file(path)
        end
      end
    end

    def destroy
      template_file_paths.each do |path|
        delete_file(path)
      end
    end

    def copy_file(path)
      File.copy(source_path(path), destination_root)
    end

    def copy_template_file(path)
      template = Tilt.new(File.join(template_dir, path))
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
      new_path = trim_file_ext(path)
      File.join(destination_root, new_path)
    end

    def trim_file_ext(path)
      File.basename(path, File.extname(path.to_s))
    end
  end
end
