APPLICATION_TITLE = "Tara's Garden"

TEXT_BEFORE_TRANSPLANT = "Before transplant"
TEXT_BEFORE_LAST_FROST = "Before last frost"
TEXT_AFTER_LAST_FROST = "After last frost"

CLIENT_ID = begin IO.read("/var/www/.github_clientid") rescue "" end
CLIENT_SECRET = begin IO.read("/var/www/.github_secret") rescue "" end
OAUTH_STATE = "12345"

DEFAULT_LAST_FROST = "2018-05-13"
