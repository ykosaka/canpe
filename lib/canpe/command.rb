require 'rubygems'
require 'thor'

require 'canpe/runner'
require 'canpe/repository_store'

class Canpe::Command < Thor

  desc "generate repo_name", "Generate files from repository"

  def generate(repository_name)
    repository_list = Canpe::RepositoryStore.repository_list
    repository = repository_list.find { |repository| repository.match? repository_name }

    if repository.blank?
      $stderr.puts "Could not find repository \"#{repository_name}\"."
      exit 1
    end

    Canpe::Runner.new(repository).generate
  end

  desc "create repo_name", "create repository"

  def create(repository_name)
    print 'working directory(canpe_working_dir) ? '
    directory_name = gets || 'canpe_working_dir'

    Canpe::Runner.new(repository_name)
  end

  desc "destroy repo_name", "Delete generated files"

  def destroy(repository_name)
    repository_list = Canpe::RepositoryStore.repository_list
    repository = repository_list.find { |repository| repository.match? repository_name }

    if repository.blank?
      $stderr.puts "Could not find repository \"#{repository_name}\"."
      exit 1
    end

    Canpe::Runner.new(repository).destroy
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
    repository = repository_list.find { |repository| repository.match? repository_name }

    if repository.blank?
      $stderr.puts "Could not find repository \"#{repository_name}\"."
      exit 1
    end

    `open #{repository.repository_url}`
  end
end
