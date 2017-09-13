require "httparty"
require "domainatrix"
require "active_support/core_ext/hash/keys"
require "fileutils"

class School
  attr_accessor :uuid, :alt_name, :name, :year_founded, :url

  def initialize(options)
    @uuid = options[:uuid].to_i
    @name = options[:name]
    @alt_name = options[:name]
    @year_founded = options[:year_founded].to_i
    @url = options[:url]
  end

  #
  # READ INFO FROM CSV FILE
  #

  SCHOOLS_FILE = File.expand_path("../../../db/schools.csv", __FILE__)

  def self.all
    @all ||= CSV.read(SCHOOLS_FILE, headers: true).map{|row| self.new(row.to_h.symbolize_keys) }
  end

  def self.all_domains
    @all_domains ||= self.all.map{|school| school.domain }
  end

  def self.duplicate_domains
    all_domains.select{|domain| all_domains.count(domain) > 1}.uniq #> ["psu", "widener"]
  end

  def parsed_url
    Domainatrix.parse(url)
  end

  def domain
    parsed_url.domain
  end

  def subdomain
    parsed_url.subdomain
  end

  def host
    parsed_url.host
  end

  def short_name
    self.class.duplicate_domains.include?(domain) ? subdomain : domain
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
