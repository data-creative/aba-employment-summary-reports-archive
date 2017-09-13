require "date"

require_relative "models/school"

require "pry"

#
# READ FROM CSV
#

REPORTS_FILE = File.expand_path("../../db/reports.csv", __FILE__)

reports_table = CSV.read(REPORTS_FILE, headers: true) #.reject{|row| row.field_row? }

#
# POPULATE ROWS AS NECESSARY AND APPLICABLE
#

School.all.first(10).each do |school|
  puts school.title_name

  (2009..Date.today.year).to_a.each do |year|

    puts " + #{year}"

    #report = Report.find(school: school, class_of: year)
    #reports << __________ unless report
  end
end

#
# (OVER)WRITE TO CSV
#

OTHER_FILE = File.expand_path("../../db/reports_1.csv", __FILE__)

CSV.open(OTHER_FILE, "wb") do |csv|
  csv << reports_table.headers

  reports_table.each do |row|
    csv << row
  end
end
