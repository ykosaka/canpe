require 'active_support'
require 'active_support/core_ext'
require 'canpe/template_binding_container'

module Canpe
  class TemplateBinding
    attr_reader :canpe_hash

    def initialize(canpe_hash = {})
      @canpe_hash = canpe_hash
    end

    def canpe
      @_canpe ||= TemplateBindingContainer.new(canpe_hash)
    end
  end
end
