#' @keywords internal
"_PACKAGE"

# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
## usethis namespace: end
NULL

# Register S7 methods
.onLoad <- function(...) {
  S7::methods_register()
}

#' Internal S7 methods
#'
#' @import S7
#' @keywords internal
#' @name era-S7
NULL
