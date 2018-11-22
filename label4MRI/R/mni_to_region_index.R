mni_to_region_index <- function(x, y, z, distance = T, template = stop('Please specify a template!')) {
  matrix_index <- which(label4mri_metadata[[template]]$coordinate_list[1, ] == x)
  matrix_index <- matrix_index[which(label4mri_metadata[[template]]$coordinate_list[2, matrix_index] == y)]
  matrix_index <- matrix_index[which(label4mri_metadata[[template]]$coordinate_list[3, matrix_index] == z)]

  if (length(matrix_index) != 0) {
    r_index <- label4mri_metadata[[template]]$coordinate_label[matrix_index]
    r_distance <- ifelse(distance, 0, NULL)
  } else {
    if (distance) {
      d2 <- colSums((label4mri_metadata[[template]]$coordinate_list - c(x, y, z))^2)
      r_index <- label4mri_metadata[[template]]$coordinate_label[which.min(d2)]
      r_distance <- sqrt(min(d2))
    } else {
      r_index <- NULL
      r_distance <- NULL
    }
  }

  return(list(index = r_index, distance = r_distance))
}

