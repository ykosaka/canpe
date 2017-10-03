module Canpe
  class TemplateBindingReflector
    attr_reader :call_list

    def initialize(call_list = [])
      @call_list = call_list
    end

    def method_missing(method, *args)
      Reflector.new(call_list + [{ method: method, args: args }])
    end

    def to_s
      method_chain = call_list.map do |hash|
        method_call = "#{hash[:method].to_s}"
        method_call += "(#{hash[:args].join(', ')})" if hash[:args].size > 0
        method_call
      end.join '.'
      "Error: #{method_chain}"
    end
  end
end
