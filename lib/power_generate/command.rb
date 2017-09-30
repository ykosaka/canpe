require 'rubygems'
require 'thor'

require 'power_generate/template_store'

class PowerGenerate::Command < Thor
  desc "list", "list up registered templates"

  def list
    template_list = PowerGenerate::TemplateStore.new.template_list
    template_list.each do |template_name|
      puts template_name
    end
  end
end
