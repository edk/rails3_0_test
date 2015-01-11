
require "rspec/core/formatters/base_text_formatter"

class ComponentFormatter < RSpec::Core::Formatters::BaseTextFormatter
  def initialize(output)
    super(output)
  end

  def example_started(proxy)
    output << "XXX --- XXX --- XXX example: " << proxy.description << "\n\n"
  end
end
