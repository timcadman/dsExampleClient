library(DSLite)
library(devtools)

setupDSLite <- function() {
  options(datashield.env = environment())
  load_all("~/Library/Mobile Documents/com~apple~CloudDocs/work/dsExample")

  data("iris")
  dslite.server <- newDSLiteServer(
    tables = list(
      iris = iris)
  )

  dslite.server$config(defaultDSConfiguration(include=c("dsBase", "dsExample")))
  dslite.server$aggregateMethod("funLevelsDS", "funLevelsDS")
  dslite.server$aggregateMethod("listDisclosureSettingsDS", "listDisclosureSettingsDS")

  builder <- DSI::newDSLoginBuilder()

  builder$append(
    server = "server_1",
    url = "dslite.server",
    table = "iris",
    driver = "DSLiteDriver"
  )

  logindata <- builder$build()
  conns <- DSI::datashield.login(logins = logindata, assign = FALSE)

  datashield.assign.table(
    conns = conns,
    table = "iris",
    symbol = "iris"
  )
  return(conns)
}

