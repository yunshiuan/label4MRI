#' @title Output the MNI coordinates of a brain region name defined by AAL/BA labeling system
#' @description Input a brain region name, output the corresponding MNI coordinates.
#' This is the inverse function of the function \code{mni_to_region_name()}.
#' @param region_names A character vector which indeicates the brain region names of interest.
#' Use \code{list_brain_regions()} to see all brain region names defined by AAL/BA system.
#' @param template One character value which indicates the templates to use
#' (\code{"aal"} or \code{"ba"}). Use \code{"aal"} by default.
#' @return Return a list of data frames and each of them correspond to a template.
#' Each data frame consists the MNI coordinates of the input brain region.
#' @examples
#' # Get the MNI cooridnates of right precentral region defined by AAL template
#' region_name_to_mni(region_names = "Precentral_R", template = "aal")
#'
#' # Get the MNI cooridnates of the union of both right and left precentral region
#' # defined by AAL template
#' region_name_to_mni(
#'   region_names = c("Precentral_R", "Precentral_L"),
#'   template = "aal"
#' )
#' @export

region_name_to_mni <- function(region_names, template = "aal") {
  if_template_exist <- template %in% names(label4mri_metadata)

  if (if_template_exist == F) {
    stop(paste0("Template ", template, " does not exist."))
  }

  list_mni_coordinates <- lapply(
    region_names,
    function(.region_name) {
      region_index <- region_name_to_index(.region_name, template)
      region_index_to_mni(region_index, template)
    }
  )

  names(list_mni_coordinates) <- paste(
    rep(template, times = length(region_names)),
    region_names,
    sep = "."
  )

  list_mni_coordinates
}
