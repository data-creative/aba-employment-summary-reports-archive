require_relative "models/report"

require "pry"

Report.all.each do |report|
  puts "#{report.year} #{report.url}"
  binding.pry
end
