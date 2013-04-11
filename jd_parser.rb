require 'nokogiri'

File.open('reports/junit_result.xml', 'w') {|file| file.truncate(0) }

src = File.open("reports/test_results.xml")
dest = File.open("reports/test_results_modified.xml", "w")
dest.puts "<testsuite>"
IO.copy_stream(src, dest)
dest.puts "</testsuite>"
dest.close

File.open('reports/test_results.xml', 'w') {|file| file.truncate(0) }

dest = File.open("reports/test_results_modified.xml")
doc = Nokogiri::XML(dest)
dest.close

File.open('reports/test_results_modified.xml', 'w') {|file| file.truncate(0) }

passed_list = doc.xpath("//passed")
failed_list = doc.xpath("//failed")
total_tests = passed_list.length+failed_list.length

print total_tests

junit_file = File.open("reports/junit_result.xml", "w")

junit_file.puts "<testsuite tests=\"#{total_tests}\" failures=\"#{failed_list.length}\" errors=\"0\" skipped=\"0\" time=\"#{ARGV[0]}\">"

for p_test in passed_list
  junit_file.puts "<testcase name=\""+p_test.attributes["name"]+"\" result=\"PASSED\"></testcase>"
end

for p_test in failed_list
  junit_file.puts "<testcase name=\""+p_test.attributes["name"]+"\" result=\"FAILED\">"
  junit_file.puts "<failure>" + p_test.content + "</failure>"
  junit_file.puts "</testcase>"
end

junit_file.puts "</testsuite>"