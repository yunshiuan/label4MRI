#' @title
#' Label the brain MNI coordinate with brain index by AAL/BA system
#' @description
#' Input an MNI coordinate, output the corresponding AAL/BA brain region index.
#' @param x The numeric x value of the MNI coordinate.
#' @param y The numeric y value of the MNI coordinate.
#' @param z The numeric z value of the MNI coordinate.
#' @param distance  A logical value which indicates whether the closest region
#'   should be shown when there is no exact match (\code{default = T}).
#'   This could be turned off to speed up the labeling process.
#' @param template One character value which indicates the templates to use.
#' @keywords internal
#' @noRd

mni_to_region_index <- function(x, y, z, distance = T, template = stop("Please specify a template!")) {
  matrix_index <- which(label4mri_metadata[[template]]$coordinate_list[1, ] == x)
  matrix_index <- matrix_index[which(label4mri_metadata[[template]]$coordinate_list[2, matrix_index] == y)]
  matrix_index <- matrix_index[which(label4mri_metadata[[template]]$coordinate_list[3, matrix_index] == z)]

  if (length(matrix_index) != 0) {
    r_index <- label4mri_metadata[[template]]$coordinate_label[matrix_index]
    r_distance <- ifelse(distance, 0, "NULL")
  } else {
    if (distance) {
      d2 <- colSums((label4mri_metadata[[template]]$coordinate_list - c(x, y, z))^2)
      r_index <- label4mri_metadata[[template]]$coordinate_label[which.min(d2)]
      r_distance <- sqrt(min(d2))
    } else {
      r_index <- "NULL"
      r_distance <- "NULL"
    }
  }

  return(list(index = r_index, distance = r_distance))
}
