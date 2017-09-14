require_relative "school"
require "pry"
require "active_support/core_ext/object/blank"
require "open-uri"

class Report
  include HasUrl

  attr_accessor :school_uuid, :class_of, :url, :downloaded_on, :parsed_on

  REPORTS_FILE = File.expand_path("../../../db/reports.csv", __FILE__)
  CSV_HEADERS = ["school_uuid", "class_of", "url", "downloaded_on", "parsed_on"]

  def initialize(options)
    @school_uuid = options[:school_uuid].to_i
    @class_of = options[:class_of].to_i
    @url = options[:url]
    @downloaded_on = options[:downloaded_on]
    @parsed_on = options[:parsed_on]
  end

  def self.all
    @all ||= CSV.read(REPORTS_FILE, headers: true).map{|row| self.new(row.to_h.symbolize_keys) }
  end

  def self.find(school:, class_of:)
    all.find{|report| report.school_uuid == school.uuid && report.class_of == class_of}
  end

  def year
    class_of
  end

  def csv_values
    CSV_HEADERS.map{|header| self.send(header) }
  end

  def school
    School.all.find{|school| school.uuid == school_uuid}
  end

  # assumes file is PDF
  def local_file
    File.join(school.reports_dir, "#{year}.pdf")
  end

  # only invokes #remote_file_path if report has a url
  def downloadable?
    (url && !url.blank? && url != "N/A" && remote_file_path == "pdf") ? true : false
  end

  # assumes url is present and remote file is downloadable
  def download
    FileUtils.rm_rf(local_file)

    File.open(local_file, "wb") do |local_file|
      open(url, "rb") do |remote_file|
        local_file.write(remote_file.read)
      end
    end
  end
end
