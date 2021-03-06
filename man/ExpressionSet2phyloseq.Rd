% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ExpressionSet2phyloseq.R
\name{ExpressionSet2phyloseq}
\alias{ExpressionSet2phyloseq}
\title{Convert an ExpressionSet object to a phyloseq object}
\usage{
ExpressionSet2phyloseq(eset, simplify = TRUE, relab = TRUE)
}
\arguments{
\item{eset}{An eset object}

\item{simplify}{if TRUE the most detailed clade name is used}

\item{relab}{if FALSE, values are multiplied by read depth to approximate counts, if TRUE
(default) values kept as relative abundances between 0 and 100\%.}
}
\value{
A phyloseq object
}
\description{
Convert an ExpressionSet object to a phyloseq object
}
\examples{
LomanNJ_2013_Mi.metaphlan_bugs_list.stool() \%>\%
ExpressionSet2phyloseq()

}

