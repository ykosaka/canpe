require 'rubygems'
require 'thor'

require 'canpe/scaffold'
require 'canpe/repository_store'

class Canpe::Command < Thor

  desc "generate repo_name", "Generate files from repository"
  def generate(repository_name)
    repository_list = Canpe::RepositoryStore.new.repository_list
    unless repository_list.include? repository_name
      $stderr.puts "Could not find repository \"#{repository_name}\"."
      exit 1
    end

    Canpe::Scaffold.new(repository_name).generate
  end

  desc "destroy repo_name", "Delete generated files"
  def destroy(repository_name)
    repository_list = Canpe::RepositoryStore.new.repository_list
    unless repository_list.include? repository_name
      $stderr.puts "Could not find repository \"#{repository_name}\"."
      exit 1
    end

    Canpe::Scaffold.new(repository_name).destroy
  end

  desc "list", "List up registered repositorys"
  def list
    repository_list = Canpe::RepositoryStore.new.repository_list
    repository_list.each do |repository_name|
      puts repository_name
    end
  end
end
