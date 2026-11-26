# Canadian provinces and territories with their sales tax rates.
# Rates are decimals: 0.05 means 5%.
# GST = federal tax, PST = provincial tax, HST = combined harmonized tax.
provinces = [
  { name: "Alberta",                   code: "AB", gst: 0.05, pst: 0,     hst: 0 },
  { name: "British Columbia",          code: "BC", gst: 0.05, pst: 0.07,  hst: 0 },
  { name: "Manitoba",                  code: "MB", gst: 0.05, pst: 0.07,  hst: 0 },
  { name: "New Brunswick",             code: "NB", gst: 0,    pst: 0,     hst: 0.15 },
  { name: "Newfoundland and Labrador", code: "NL", gst: 0,    pst: 0,     hst: 0.15 },
  { name: "Northwest Territories",     code: "NT", gst: 0.05, pst: 0,     hst: 0 },
  { name: "Nova Scotia",               code: "NS", gst: 0,    pst: 0,     hst: 0.14 },
  { name: "Nunavut",                   code: "NU", gst: 0.05, pst: 0,     hst: 0 },
  { name: "Ontario",                   code: "ON", gst: 0,    pst: 0,     hst: 0.13 },
  { name: "Prince Edward Island",      code: "PE", gst: 0,    pst: 0,     hst: 0.15 },
  { name: "Quebec",                    code: "QC", gst: 0.05, pst: 0.09975, hst: 0 },
  { name: "Saskatchewan",              code: "SK", gst: 0.05, pst: 0.06,  hst: 0 },
  { name: "Yukon",                     code: "YT", gst: 0.05, pst: 0,     hst: 0 }
]

provinces.each do |attrs|
  province = Province.find_or_initialize_by(code: attrs[:code])
  province.update!(attrs)
end

puts "Provinces in database: #{Province.count}"