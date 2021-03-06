% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sample_dots.R
\name{sample_dots}
\alias{sample_dots}
\title{Sample dots from spatial polygons}
\usage{
sample_dots(shp, vars = NULL, convert2density = FALSE, nrow = NA,
  ncol = NA, N = 250000, npop = NA, n = 10000, w = NA,
  shp.id = NULL, var.name = "class", var.labels = vars,
  target = "metric", randomize = TRUE, output = c("points", "grid"),
  orig = NULL, to = NULL, ...)
}
\arguments{
\item{shp}{A shape object, more specifically, a \code{\link[sp:SpatialPolygonsDataFrame]{SpatialPolygonsDataFrame}} or an \code{sf} object that can be coerced as such.}

\item{vars}{Names of one or more variables that are contained in \code{shp}. If \code{vars} is not provided, the dots are sampled uniformly. If \code{vars} consists of one variable name, the dots are sampled according to the distribution of the corresponding variable. If \code{vars} consist of more than one variable names, then the dots are sampled according to the distributions of those variables. A categorical variable is added that contains the distrubtion classes (see \code{var.name}).}

\item{convert2density}{Should the variables be converted to density values? Density values are used for the sampling algorithm, so use \code{TRUE} when the values are absolute counts.}

\item{nrow}{Number of grid rows}

\item{ncol}{Number of grid colums}

\item{N}{Number of grid points}

\item{npop}{Population total. If \code{NA}, it is recontructed from the data. If density values are specified, the population total is approximated using the polygon areas (see also \code{target}, \code{orig} and \code{to}).}

\item{n}{Number of sampled dots}

\item{w}{Number of population units per dot. It is the population total divided by \code{n}. If specified, \code{n} is calculated accordingly.}

\item{shp.id}{Name of the variable of \code{shp} that contains the polygon identifying numbers or names.}

\item{var.name}{Name of the variable that will be created to store the classes. The classes are defined by \code{vars}, and the labels can be configured with \code{var.labels}.}

\item{var.labels}{Labels of the classes (see \code{var.name}).}

\item{target}{target unit, see \code{\link{approx_areas}}}

\item{randomize}{should the order of sampled dots be randomized? The dots are sampled class-wise (specified by \code{vars}). If this order is not randomized (so if \code{randomize=FALSE}), then the dots from the last class will be drawn on top, which may introduce a perception bias. By default \code{randomize=TRUE}, so the sampled dots are randomized to prevent this bias.}

\item{output}{format of the output: use \code{"points"} for spatial points, and \code{"grid"} for a spatial grid.}

\item{orig}{not used anymore as of version 2.0}

\item{to}{not used anymore as of version 2.0}

\item{...}{other arguments passed on to \code{\link{calc_densities}} and \code{\link{approx_areas}}}
}
\description{
Sample dots from spatial polygons according to a spatial distribution of a population. The population may consist of classes. The output, a SpatialPointsDataFrame, can be used to create a dot map (see \code{\link[tmap:tm_dots]{tm_dots}}), where the dots are colored according to the classes.
}
\examples{
\dontrun{
if (require(tmap)) {
    data(World)
    World_dots <- sample_dots(World, vars="pop_est_dens", nrow=200, ncol=400, w=1e6)

    tm_shape(World_dots) + tm_dots(size = .02, jitter=.1) +
    	tm_layout("One dot represents one million people", title.position = c("right", "bottom"))
}
}
}
