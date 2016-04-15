# Geocoder.configure(
# Geocoding options
# timeout: 3,                 # geocoding service timeout (secs)
# lookup: :freegeoip,            # name of geocoding service (symbol)
# language: :en,              # ISO-639 language code
# use_https: false,           # use HTTPS for lookup requests? (if supported)
# http_proxy: nil,            # HTTP proxy server (user:pass@host:port)
# https_proxy: nil,           # HTTPS proxy server (user:pass@host:port)
# api_key: "",               # API key for geocoding service
# cache: nil,                 # cache object (must respond to #[], #[]=, and #keys)
# cache_prefix: 'geocoder:',  # prefix (string) to use for all cache keys

# Exceptions that should not be rescued by default
# (if you want to implement custom error handling);
# supports SocketError and Timeout::Error
# always_raise: [],

# Calculation options
# units: :mi,                 # :km for kilometers or :mi for miles
# distances: :linear          # :spherical or :linear
# )
# config/initializers/geocoder.rb

Geocoder.configure(
    ip_lookup:    :ipinfo_io,
    lookup:       :google,
    api_key:      :"AIzaSyCD7sQ_j-UHteSsVV5z9jKUddL2SFOcByA",
    language:     :en,
    units:        :mi,
    :http_proxy => ENV['QUOTAGUARD_URL'],
    use_https:    :true,
    :timeout => 5
)