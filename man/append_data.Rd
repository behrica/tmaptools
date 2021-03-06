% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/append_data.R
\name{append_data}
\alias{append_data}
\alias{under_coverage}
\alias{over_coverage}
\title{Append data to a shape object}
\usage{
append_data(shp, data, key.shp = NULL, key.data = NULL,
  ignore.duplicates = FALSE, ignore.na = FALSE,
  fixed.order = is.null(key.data) && is.null(key.shp))

under_coverage()

over_coverage()
}
\arguments{
\item{shp}{shape object, which is one of
\enumerate{
 \item{\code{\link[sp:SpatialPolygonsDataFrame]{SpatialPolygons(DataFrame)}}}
 \item{\code{\link[sp:SpatialPointsDataFrame]{SpatialPoints(DataFrame)}}}
 \item{\code{\link[sp:SpatialLinesDataFrame]{SpatialLines(DataFrame)}}}
 \item{\code{\link[sp:SpatialGridDataFrame]{SpatialGrid(DataFrame)}}}
 \item{\code{\link[sp:SpatialPixelsDataFrame]{SpatialPixels(DataFrame)}}}
 \item{\code{sf} object that can be coerced as one above}
}}

\item{data}{data.frame}

\item{key.shp}{variable name of \code{shp} map data to be matched with \code{key.data}. If not specified, and \code{fixed.order} is \code{FALSE}, the ID's of the polygons/lines/points are taken.}

\item{key.data}{variable name of \code{data} to be matched with \code{key.shp}. If not specified, and \code{fixed.order} is \code{FALSE}, the row names of \code{data} are taken.}

\item{ignore.duplicates}{should duplicated keys in \code{data} be ignored? (\code{FALSE} by default)}

\item{ignore.na}{should NA values in \code{key.data} and \code{key.shp} be ignored? (\code{FALSE} by default)}

\item{fixed.order}{should the data be append in the same order as the shapes in \code{shp}?}
}
\value{
Shape object with appended data. Tip: run \code{append_data} without assigning the result to check the coverage.
}
\description{
Data, in the format of a data.frame, is appended to a shape object. This is either done by a left join where keys are specified for both shape and data, or by fixed order. Under coverage (shape items that do not correspond to data records), over coverage (data records that do not correspond to shape items respectively) as well as the existence of duplicated key values are automatically checked and reported via console messages. With \code{under_coverage} and \code{over_coverage} the under and over coverage key values from the last \code{append_data} call can be retrieved. Tip: run \code{append_data} without assigning the result to check the coverage.
}
\examples{
\dontrun{
if (require(tmap)) {
    data(Europe)

    f <- tempfile()
    download.file("http://kejser.org/wp-content/uploads/2014/06/Country.csv", destfile = f)
    domain_codes <- read.table(f, header=TRUE, sep="|")
    unlink(f)

    domain_codes <- subset(domain_codes, select = c("Alpha3Code", "TopLevelDomain"))
    domain_codes$Alpha3Code <- toupper(domain_codes$Alpha3Code)

    Europe <- append_data(Europe, domain_codes, key.shp = "iso_a3", key.data = "Alpha3Code",
    					  ignore.na = TRUE)

    # codes in the data, but not in Europe:
    oc <- over_coverage()
    oc$value

    # European countries without appended data:
    uc <- under_coverage()
    qtm(Europe[uc$id,], text="name")

    # plot the result
    qtm(Europe, text="TopLevelDomain")
}
}
}
