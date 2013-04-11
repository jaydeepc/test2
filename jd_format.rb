require "rspec/core/formatters/base_text_formatter"

class CustomFormatter < RSpec::Core::Formatters::BaseTextFormatter
  def initialize(output)
    super(output)
    @passed_tests = Array.new
    @failed_tests = Array.new
  end
  
  def start(example_count)
    
  end

  def close()
  end
  def example_started(example)
    
  end
  
  def example_passed(example)
    @passed_tests.push example.description
    system("echo '<passed name=\"#{example.description}\"></passed>' >> reports/test_results.xml")
  end
  
  def example_failed(example)
    @failed_tests.push example.description
    system("echo '<failed name=\"#{example.description}\">' >> reports/test_results.xml")
    system("echo '<trace>#{example.exception}</trace></failed>' >> reports/test_results.xml")
  end
  
  def dump_summary(duration, example_count, failure_count, pending_count)
    #system("echo '<suite tests=#{example_count} failed=#{failure_count} time=#{duration}></suite>' >> reports/test_results.xml")
  end
  
  def start_dump()
    
  end
end