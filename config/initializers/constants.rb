  BASE_URI = 'http://api.indeed.com/ads/apisearch'
  API_KEY = '3990618342905680'
  END_OF_URI = '&sort=&radius=0&v=2&format=json'
  RELEVANT_KEYS = ["jobtitle", "company", "formattedLocation", "date", "source", "snippet", "url", "formattedRelativeTime"]
  LOCS_LIMIT = 9 # 10 locations is the max, so 9 is the max array index
  NO_RESULTS_ERROR_MSG = "Your search did not match any jobs."
  ERROR_MSGS = ["Please type one or more locations, separated by commas.", "too many locations", "invalid query", "loc list nil"]
