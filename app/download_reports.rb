require_relative "models/report"

#
# DOWNLOAD RELEVANT PDF FILES
#

reports = Report.all

reports.each do |report|
  puts "#{report.school.short_name.upcase} #{report.year} #{report.url}"

  if report.downloadable?
    if File.exist?(report.local_file)
      puts " ... ALREADY DOWNLOADED"
    else
      begin
        report.download  # maybe override this condition check using job settings/options
        report.downloaded_on = Date.today.to_s
        puts " ... DOWNLOADED"
      #rescue OpenURI::HTTPError => e # 404 Not Found
      #rescue OpenSSL::SSL::SSLError => e # SSL_connect returned=1 errno=0 state=error: certificate verify failed
      rescue => e
        binding.pry
        report.downloaded_on = "N/A - DOWNLOAD ERROR(S)"
      end
    end
  else
    report.downloaded_on = "N/A - NOT DOWNLOADABLE"
    puts " ... NOT DOWNLOADABLE"
  end
end

#
# WRITE METADATA TO CSV
#

puts "---------------------------------"
puts "WRITING #{reports.count} REPORTS"

CSV.open(Report::REPORTS_FILE, "wb") do |csv|
  csv << Report::CSV_HEADERS

  reports.each do |report|
    csv << report.csv_values
  end
end
