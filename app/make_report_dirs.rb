require_relative "models/school"

School.all.each do |school|
  puts "#{school.title_name}"
  school.make_reports_directory
end
