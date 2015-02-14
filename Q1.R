question1 <- function() {
  library(httr)
  library(httpuv)
  library(jsonlite)
  
  # 1. Find OAuth settings for github:
  #    http://developer.github.com/v3/oauth/
  oauth_endpoints("github")
  
  # 2. Register an application at https://github.com/settings/applications;
  #    Use any URL you would like for the homepage URL (http://github.com is fine)
  #    and http://localhost:1410 as the callback url
  #
  #    Insert your client ID and secret below - if secret is omitted, it will
  #    look it up in the GITHUB_CONSUMER_SECRET environmental variable.
  myapp <- oauth_app("github", key="3c17cd24cdc0b197c05d", secret="f29e17b086ebce2aa2fa4df883485fb04d9e8b1b")
  
  # 3. Get OAuth credentials
  github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
  
  # 4. Use API
  gtoken <- config(token = github_token)
  req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
  stop_for_status(req)
  res <- content(req)
  json <- jsonlite::fromJSON(toJSON(res))
  json[c("created_at","url")]
}