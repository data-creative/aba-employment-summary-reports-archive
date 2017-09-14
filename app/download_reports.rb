require_relative "models/report"

Report.all.each do |report|
  puts "#{report.year} #{report.url}"

  report.download #unless File.exist?(report.local_file) # maybe override this condition check using job settings/options

  #if report.url
  #  # download whatever they are putting up, be it html or pdf or jpg. for the archive. that's the premise of this repo.
  #  # ehh not sure.
  #  # maybe only interested in PDFs for now
  #  binding.pry
  #  if report.remote_file_format == "pdf"
  #    report.download unless File.exist?(report.local_file) # maybe override this condition check using job settings/options
  #  end
  #end

  #results = {status:nil, errors:[]}
#
  #if report.pdf?
  #  results[:file_type] = "PDF"
#
  #  if report.standard_format?
  #    results[:status] = "STANDARD"
  #    report.download unless File.exist?(report.local_file)
  #  else
  #    results[:status] = "NON-STANDARD"
  #  end
  #else
  #  results[:file_type] = "NON-PDF"
  #end
end
