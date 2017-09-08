require_relative "models/school"
require "fileutils"

REPORTS_DIR = File.expand_path("../../school-hosted/reports", __FILE__)

School.all.each do |school|
  dir_path = File.join(REPORTS_DIR, "#{school.uuid}-#{school.short_name}")
  FileUtils.mkdir_p(dir_path)
end
