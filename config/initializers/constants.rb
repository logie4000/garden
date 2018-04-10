
TEXT_BEFORE_TRANSPLANT = "Before transplant"
TEXT_BEFORE_LAST_FROST = "Before last frost"
TEXT_AFTER_LAST_FROST = "After last frost"

DEFAULT_LAST_FROST = "2018-05-13"

WUNDERGROUND_API_KEY = "#{begin IO.read("/var/www/.wunderground") rescue "" end}"

UNIT_IMPERIAL = 0
UNIT_METRIC = 1

