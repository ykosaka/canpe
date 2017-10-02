module Canpe
  class TemplateRenderer
    attr_accessor :injected_hash

    def initialize(hash = {})
      @injected_hash = hash
    end

    def render_string(str)
      template = Tilt::ERBTemplate.new { str.to_s }
      template.render(Canpe::TemplateBinding.new, injected_hash)
    end

    def render_file(path)
      Tempfile.new.tap do |file|
        template = Tilt::ERBTemplate.new(path)
        file.write(template.render(Canpe::TemplateBinding.new, injected_hash))
        file.rewind
      end
    end
  end
end
