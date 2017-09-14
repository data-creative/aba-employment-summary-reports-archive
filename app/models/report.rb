require_relative "school"
require "pry"
require "active_support/core_ext/object/blank"

class Report
  include HasUrl

  attr_accessor :school_uuid, :class_of, :url, :downloaded_on, :parsed_on

  REPORTS_FILE = File.expand_path("../../../db/reports.csv", __FILE__)

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

  def school
    School.all.find{|school| school.uuid == school_uuid}
  end

  # assumes file is PDF
  def local_file
    # should normalize file names but keep their original file format to accommodate PNG, JPEG, PDF, maybe HTML
    # File.join(school.reports_dir, "#{year}-auto.#{file_format}")
    # maybe assumes PDFs for now:
    File.join(school.reports_dir, "#{year}-auto.pdf")
  end

  # only invokes remote_file_path if report has a url
  def downloadable?
    (url && !url.blank? && url != "N/A" && remote_file_path == "pdf") ? true : false
  end

  # assumes url is present
  def download
    if downloadable?
      puts " ... DOWNLOADABLE"

      FileUtils.rm_rf(local_file)

      binding.pry
      File.open(local_file, "wb") do |local_file|
        open(url, "rb") do |remote_file|
          local_file.write(remote_file.read)
        end
      end
    else
      puts " ... NOT DOWNLOADABLE"
    end
  end

  #def parsable?
  #  #code
  #end

  #def standard?
  #  file_format == "PDF"
  #end
#
  #def downloaded?
  #  !downloaded_on.blank?
  #end
#
  #def parsed?
  #  !parsed_on.blank?
  #end
end
