#' @title
#' Output the MNI coordinates of a brain region index defined by AAL/BA labeling system
#' @description
#' Input a brain region index, output the corresponding MNI coordinates.
#' This is the inverse function of the function (\code{mni_to_region_name()}).
#' @param region_index A numeric vector which indeicates the brain region index of interest.
#' @param template One character value which indicates the templates to use
#'   ((\code{"aal"}) or (\code{"ba"})).
#' @return
#' Return a data frame consisting the x,y,z MNI coordinates of the input brain region.
#' @examples
#' # Get the MNI cooridnates of right precentral region defined by AAL template.
#' region_name_to_mni(region_index = 2, template = "aal")
#' @keywords internal
#' @noRd

region_index_to_mni <- function(region_index, template = stop("Please specify a template!")) {
  linear_indexes_of_the_region <-
    (label4mri_metadata[[template]]$coordinate_label == region_index)
  mni_coordinates <-
    label4mri_metadata[[template]]$coordinate_list[, linear_indexes_of_the_region]
  df_mni_coordinates <-
    data.frame(
      x = mni_coordinates[1, ],
      y = mni_coordinates[2, ],
      z = mni_coordinates[3, ]
    )
  df_mni_coordinates
}
