require 'canpe/template_binding_reflector'

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
        TemplateBindingReflector.new([{method: name, args: []}])
      end
    end
  end
end
