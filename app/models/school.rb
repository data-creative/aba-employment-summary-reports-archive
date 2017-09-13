require "active_support/core_ext/hash/keys"
require "csv"
require "fileutils"
require "httparty"

require_relative "has_url"

class School
  include HasUrl

  attr_accessor :uuid, :alt_name, :name, :year_founded, :url

  SCHOOLS_FILE = File.expand_path("../../../db/schools.csv", __FILE__)

  def initialize(options)
    @uuid = options[:uuid].to_i
    @name = options[:name]
    @alt_name = options[:alt_name]
    @year_founded = options[:year_founded].to_i
    @url = options[:url]
  end

  def self.all
    @all ||= CSV.read(SCHOOLS_FILE, headers: true).map{|row| self.new(row.to_h.symbolize_keys) }
  end

  def self.all_domains
    @all_domains ||= self.all.map{|school| school.domain }
  end

  def self.duplicate_domains
    all_domains.select{|domain| all_domains.count(domain) > 1}.uniq #> ["psu", "widener"]
  end

  def short_name
    self.class.duplicate_domains.include?(domain) ? subdomain : domain
  end

  def title_name
    "#{name.upcase} (#{short_name.upcase})"
  end

  #
  # MANAGE FILESYSTEM
  #

  REPORTS_DIR = File.expand_path("../../../school-hosted/reports", __FILE__)

  def reports_dir
    File.join(REPORTS_DIR, "#{uuid}-#{short_name}")
  end

  def gitkeep
    File.join(reports_dir, ".gitkeep")
  end

  def make_reports_directory
    FileUtils.mkdir_p(reports_dir)
    File.open(gitkeep, "w"){|f| f.write("") }
  end
end
