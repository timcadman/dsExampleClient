library(DSLite)
library(devtools)

setupDSLite <- function() {
  options(datashield.env = environment())
  dslite.server <- DSLite::newDSLiteServer()
  load_all("~/Library/Mobile Documents/com~apple~CloudDocs/work/dsExample")
  dslite.server$config(defaultDSConfiguration(include=c("dsBase", "dsExample")))
  dslite.server$aggregateMethod("funLevelsDS", "funLevelsDS")
  dslite.server$aggregateMethod("listDisclosureSettingsDS", "listDisclosureSettingsDS")

  builder <- DSI::newDSLoginBuilder()

  builder$append(
    server = "server_1",
    url = "dslite.server",
    driver = "DSLiteDriver"
  )

  logindata <- builder$build()
  conns <- DSI::datashield.login(logins = logindata, assign = FALSE)
  return(conns)
}

