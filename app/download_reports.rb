require_relative "models/report"

Report.all.each do |report|
  puts "#{report.year} #{report.url}"
end
