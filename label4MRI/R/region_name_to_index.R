#' @title
#' Map a brain region name to the corresponding region index in AAL/BA system
#' @description
#' Input a brain region name, output the brain region index.
#' @param region_name A character vector which indeicates
#'   the brain region names of interest.
#' @param template One character value which indicates the templates to use
#' @return
#' Return a numeric vector storing brain region indexes.
#' @keywords internal
#' @noRd

region_name_to_index <- function(region_name, template = stop("Please specify a template!")) {
  which(label4mri_metadata[[template]]$label$Region_name == region_name)
}
