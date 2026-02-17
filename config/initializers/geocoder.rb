Geocoder.configure(
  timeout: 5,
  lookup: :nominatim,
  http_headers: { "User-agent"=> "first_project (rohitv@shriffle.com)" },
  units: :km
  )
