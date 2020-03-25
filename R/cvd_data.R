#' Get latest COVID-19 data
#'
#' Data Source: https://github.com/CSSEGISandData/COVID-19
#'
#' @return A tibble
#' @export
#'
#' @examples
cvd_data <- function(){

  suppressMessages({
    confirmed <- readr::read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
    deaths <- readr::read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv")
  })

  long_confirmed <- tidyr::pivot_longer(confirmed, 5:ncol(confirmed), names_to = "date", values_to = "confirmed")
  long_deaths <- tidyr::pivot_longer(deaths, 5:ncol(deaths), names_to = "date", values_to = "deaths")

  invisible(capture.output({
    df <- dplyr::left_join(long_confirmed, long_deaths)
  }))

  df$date <- as.Date.character(df$date, tryFormats = "%m/%d/%y")

  df
}
