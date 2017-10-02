require 'rubygems'
require 'thor'

require 'canpe/runner'
require 'canpe/repository_store'

class Canpe::Command < Thor

  desc "generate repo_name", "Generate files from repository"

  def generate(repository_name)
    repository_list = Canpe::RepositoryStore.repository_list
    unless repository_list.include? repository_name
      $stderr.puts "Could not find repository \"#{repository_name}\"."
      exit 1
    end

    Canpe::Runner.new(repository_name).generate
  end

  desc "destroy repo_name", "Delete generated files"

  def destroy(repository_name)
    repository_list = Canpe::RepositoryStore.repository_list
    unless repository_list.include? repository_name
      $stderr.puts "Could not find repository \"#{repository_name}\"."
      exit 1
    end

    Canpe::Runner.new(repository_name).destroy
  end

  desc "list", "List up registered repositorys"

  def list
    repository_list = Canpe::RepositoryStore.repository_list
    repository_list.each do |repository_name|
      puts repository_name
    end
  end

  desc "open", "open registered repository"

  def open(repository_name)
    repository_list = Canpe::RepositoryStore.repository_list
    unless repository_list.include? repository_name
      $stderr.puts "Could not find repository \"#{repository_name}\"."
      exit 1
    end

    repo = Canpe::Repository.new(repository_name)
    `open #{repo.repository_url}`
  end
end
