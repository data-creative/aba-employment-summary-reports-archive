require "httparty"
require "domainatrix"
require "active_support/core_ext/hash/keys"

class School
  attr_accessor :uuid, :alt_name, :name, :year_founded, :url

  def initialize(options)
    @uuid = options[:uuid]
    @name = options[:name]
    @alt_name = options[:name]
    @year_founded = options[:year_founded]
    @url = options[:url]
  end

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
end
