
require "rspec/core/formatters/base_text_formatter"


require 'json'
if true
  puts "stubbing out example_pending..."
  class BaseFormatter
    def example_pending(example)
    end
  end
end

class ComponentFormatter < RSpec::Core::Formatters::BaseFormatter

  attr_reader :output_hash

  DEFAULT_OUTPUT_FILENAME = 'tmp/component_failures.json'

  def initialize(output)
    default_file = File.open(DEFAULT_OUTPUT_FILENAME,'w+')
    super(default_file)
    @output_hash = {}
  end

  def message(message)
    (@output_hash[:messages] ||= []) << message
  end

  def dump_summary(duration, example_count, failure_count, pending_count)
    #super(duration, example_count, failure_count, pending_count)
    # @output_hash[:summary] = {
    #   :duration => duration,
    #   :example_count => example_count,
    #   :failure_count => failure_count,
    #   :pending_count => pending_count
    # }
    #@output_hash[:summary_line] = summary_line(example_count, failure_count, pending_count)
  end

  #def summary_line(example_count, failure_count, pending_count)
  #  summary = pluralize(example_count, "example")
  #  summary << ", " << pluralize(failure_count, "failure")
  #  summary << ", #{pending_count} pending" if pending_count > 0
  #  summary
  #end

  def stop
    super
    @output_hash[:examples] = examples.select do |example|
      example.execution_result[:status] == "failed"
    end.map do |example|
      addl_standard_keys = Array(ENV["RSPEC_META_KEYS"].to_s.split(",")).compact
      standard_metadata_keys = [:example_group, :example_group_block,
                                :type, :description_args, :caller,
                                :execution_result, :description] +
                                addl_standard_keys
      tags = example.metadata.keys - standard_metadata_keys
      {
        :tags => tags,
        :description => example.description,
        :full_description => example.full_description,
        :status => example.execution_result[:status],
        # :example_group,
        # :execution_result,
        :file_path => example.metadata[:file_path],
        :line_number  => example.metadata[:line_number],
      }.tap do |hash|
          if e=example.exception
            hash[:exception] =  {
              :class => e.class.name,
              :message => e.message,
              :backtrace => e.backtrace,
            }
          end
        end
    end
  end

  def close
    output.write @output_hash.to_json
    output.close if IO === output && output != $stdout
  end

end

# class ComponentFormatter < RSpec::Core::Formatters::BaseTextFormatter
#   DEFAULT_OUTPUT_FILENAME = 'tmp/component_failures.json'
# 
#   def initialize(output)
#     default_file = File.open(DEFAULT_OUTPUT_FILENAME,'w+')
#     super(default_file)
#   end
# 
#   # do nothing for all these
#   def dump_pending *args
#   end
#   def dump_backtrace *args
#   end
#   def dump_pending_fixed *args
#   end
#   def dump_shared_failure_info *args
#   end
# 
#   # dump_failure(example, index) ?
#   # dump_failure_info(example) ?
#   # dump_summary(duration, example_count, failure_count, pending_count) ?
#   # dump_commands_to_rerun_failed_examples
#   # dump_profile
# 
#   def dump_failures
#     return if failed_examples.empty?
#     output.puts
#     output.puts "My special Failures:"
#     failed_examples.each_with_index do |example, index|
#       output.puts
#       output.puts index.inspect
#       print_metadata(example)
#       #pending_fixed?(example) ? dump_pending_fixed(example, index) : dump_failure(example, index)
#       #dump_backtrace(example)
#     end
#   end
# 
#   #def example_started(example)
#   def print_metadata(example_group)
#     #output << "XXX --- XXX --- XXX example: #{example_group.description}\n\n"
#     %w[full_description type component execution_result location].each { |k| output.puts "#{k.to_sym.inspect} => '#{example_group.metadata[k.to_sym]}'" }
#     #p example_group.metadata[:execution_result].keys
#     # =>[:started_at, :exception, :status, :finished_at, :run_time]
#     #output << example_group.metadata[:component]
#     #=> nil | [:invoicing, :core]
#     #output << example_group.metadata[:type]
#     # => :model
#     # .metadata[:description_args]
#     # =>["should pass"]
#     #output << example_group.metadata[:execution_result]
#     # =>{}
#     # (rdb:1) a.metadata[:file_path]
#     # "./spec/models/user_spec.rb"
#     # (rdb:1) a.metadata[:line_number]
#     # 8
#     #output << example_group.metadata[:location]
#     #output << example_group.metadata[:full_description]
#     # "./spec/models/user_spec.rb:8"
#     #puts "--#{output}"
#     #debugger
#     #output
#   end
# end
