require_relative "models/school"
require_relative "models/report"

#require "date"

#School.all.first(10).each do |school|
School.all.each do |school|
  puts "#{school.uuid} #{school.short_name} #{school.host}"
  school.make_reports_directory

  (2009..Date.today.year).to_a.each do |year|

    report = Report.find(school: school, class_of: year)

    if report
      puts " + #{report.class_of} #{report.url}"
    else
      puts " + #{year} N/A"
    end
  end
end
