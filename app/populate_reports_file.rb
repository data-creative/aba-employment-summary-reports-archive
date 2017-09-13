require_relative "models/school"
require_relative "models/report"

require "date"

#
# READ FROM CSV
#

REPORTS_FILE = File.expand_path("../../db/reports.csv", __FILE__)

reports_table = CSV.read(REPORTS_FILE, headers: true)

puts "READING #{reports_table.count} REPORTS"

#
# POPULATE ROWS AS NECESSARY AND APPLICABLE
#

School.all.each do |school|
  puts school.title_name

  (2009..Date.today.year).to_a.each do |year|
    unless Report.find(school: school, class_of: year)
      reports_table << [school.uuid, year, nil, nil, nil] # needs to be in the same order as existing headers
    end
  end
end

#
# (OVER)WRITE TO CSV
#

puts "WRITING #{reports_table.count} REPORTS"

sorted_rows = reports_table.sort_by{|row| row.values_at(0,1) } # sort by: (school_uuid x year)

CSV.open(REPORTS_FILE, "wb") do |csv|
  csv << reports_table.headers

  sorted_rows.each do |row|
    csv << row.fields
  end
end
