################################################################################
#
#' Lengthen a shortened URL to its full URL format
#'
#' A utility function to lengthen shortened URL created via \code{bit.ly}.
#'
#' @param url Shortened URL to lengthen. Currently tested to work for shortened
#'   URL using bit.ly
#'
#' @return A character value for lengthened URL
#'
#' @examples
#' decode_short_url(url = "bit.ly/30xo3xk")
#'
#' @export
#'
#
################################################################################

decode_short_url <- function(url) {
  x <- try(RCurl::getURL(url,
                         header = TRUE,
                         nobody = TRUE,
                         followlocation = FALSE,
                         cainfo = system.file("CurlSSL",
                                              "cacert.pem",
                                               package = "RCurl")))

  if(inherits(x, 'try-error') | length(grep(".*Location: (\\S+).*", x)) < 1) {
      return(url)
  } else {
    return(gsub(".*Location: (\\S+).*", "\\1", x))
  }
}

