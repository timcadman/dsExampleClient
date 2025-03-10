#' @title Returns levels of a factor variable with fun message
#' @description Retrieves the number of columns in a dataset and provides a motivational message
#' @param x a character string providing the name of the input data frame or matrix.
#' @param fun_message a character string with the motivational message
#' @param datasources a list of \code{\link{DSConnection-class}} objects obtained after login.
#' If the \code{datasources} argument is not specified
#' the default set of connections will be used: see \code{\link{datashield.connections_default}}.
#' @return \code{ds.funLevels} returns the levels prefixed by a fun message
#' @author Tim Cadman
#' @importFrom DSI datashield.aggregate
#' @examples
#' @export
ds.funLevels <- function(x=NULL, fun_message=NULL, datasources=NULL) {

  if(is.null(datasources)){
    datasources <- datashield.connections_find()
  }

  .check_args(x, fun_message)
  cally <- call("funLevelsDS", x, fun_message)
  fun_levels <- DSI::datashield.aggregate(datasources, cally)

  return(fun_levels)

}

#' Validate Arguments
#'
#' This function checks whether the provided arguments meet the expected conditions.
#' It ensures that `x` and `fun_message` are not `NULL` and that both are character vectors.
#'
#' @param x A character vector. Must not be `NULL`.
#' @param fun_message A character vector. Must not be `NULL`.
#'
#' @return This function does not return a value. It throws an error if any of the conditions are not met.
#'
#' @importFrom cli cli_abort
#'
#' @examples
#' # Valid input
#' .check_args("example", "This is a message")
#'
#' # Invalid input (NULL x)
#' # .check_args(NULL, "This is a message")
#'
#' # Invalid input (x not character)
#' # .check_args(123, "This is a message")
#'
.check_args <- function(x, fun_message) {

  if(is.null(x))  {
    cli_abort("`x` must not be NULL")
  }

  if(is.null(fun_message)) {
      cli_abort("`fun_message` must not be NULL")
  }

  x_class <- class(x)
  message_class <- class(fun_message)

  if(x_class != "character") {
    cli_abort(
      c(
        "x" = "`x` must be a character vector",
        "i" = "You have provided an input with class {x_class}")
    )
  }

  if(message_class != "character") {
    cli_abort(
      c(
        "x" = "`fun_message` must be a character vector",
        "i" = "You have provided an input with class {message_class}")
    )
  }

}
