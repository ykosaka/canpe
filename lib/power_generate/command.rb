require 'rubygems'
require 'thor'

class PowerGenerate::Command < Thor
  desc "hello NAME", "say hello to NAME"
  def hello(name, from=nil)
    puts "from: #{from}" if from
    puts "Hello #{name}"
  end
end
