require 'rubygems'
require 'thor'

require 'power_generate/scaffold'
require 'power_generate/template_store'

class PowerGenerate::Command < Thor

  desc "generate TEMPLATE_NAME", "scaffold current directory by template"
  def generate(template_name)
    template_list = PowerGenerate::TemplateStore.new.template_list
    unless template_list.include? template_name
      $stderr.puts "Could not find template \"#{template_name}\"."
      exit 1
    end

    PowerGenerate::Scaffold.new(template_name).generate
  end

  desc "destroy TEMPLATE_NAME", "delete scaffolded files"
  def destroy(template_name)
    template_list = PowerGenerate::TemplateStore.new.template_list
    unless template_list.include? template_name
      $stderr.puts "Could not find template \"#{template_name}\"."
      exit 1
    end

    PowerGenerate::Scaffold.new(template_name).destroy
  end

  desc "list", "list up registered templates"
  def list
    template_list = PowerGenerate::TemplateStore.new.template_list
    template_list.each do |template_name|
      puts template_name
    end
  end
end
