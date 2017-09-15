require "domainatrix"

module HasUrl
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

  def remote_file_path
    parsed_url.path.split(".").last
  end
end
