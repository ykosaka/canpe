require 'canpe/reflector'

module Canpe
  class TemplateBindingContainer
    attr_reader :hash

    def initialize(hash)
      @hash = hash
    end

    def [](name)
      if hash.key? name
        hash[name]
      else
        Reflector.new([{method: name, args: []}])
      end
    end
  end
end
