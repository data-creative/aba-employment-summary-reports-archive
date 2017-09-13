#require "pry"

class Report
  attr_accessor :school_uuid, :class_of, :url, :downloaded_on

  def initialize(options)
    @school_uuid = options[:school_uuid].to_i
    @class_of = options[:class_of].to_i
    @url = options[:url_source]
    @downloaded_on = options[:downloaded_on]
  end

  #
  # READ INFO FROM CSV FILE
  #

  REPORTS_FILE = File.expand_path("../../../db/reports.csv", __FILE__)

  def self.all
    @all ||= CSV.read(REPORTS_FILE, headers: true).map{|row| self.new(row.to_h.symbolize_keys) }
  end

  def self.find(school:, class_of:)
    all.find{|report| report.school_uuid == school.uuid && report.class_of == class_of}
  end

  def year
    class_of
  end
end
