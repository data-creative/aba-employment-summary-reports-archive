require "date"

require_relative "models/school"

require "pry"

REPORTS_FILE = File.expand_path("../../db/reports.csv", __FILE__)

reports = CSV.read(REPORTS_FILE, headers: true)

School.all.first(10).each do |school|
  puts school.title_name

  (2009..Date.today.year).to_a.each do |year|

    puts " + #{year}"

    #report = Report.find(school: school, class_of: year)
    #reports << __________ unless report
  end
end

#CSV.open("data.csv", "wb") do |csv|
#  # write headers
#
#  reports.each do |report|
#    csv << report
#  end
#end
