
mni_to_region_index <- function(x, y, z, distance = T, dset = stop("Please specify a data set name!")) {

  index <- which(label4mri_metadata[[dset]]$coordinate_list[1, ] == x)
  index <- index[which(label4mri_metadata[[dset]]$coordinate_list[2, index] == y)]
  index <- index[which(label4mri_metadata[[dset]]$coordinate_list[3, index] == z)]


  if (distance == T) {
    if (length(index) != 0) {
      return(list(index, distance = 0))
    } else {
      d2 = colSums((label4mri_metadata[[dset]]$coordinate_list - c(x, y, z))^2)
      index = label4mri_metadata[[dset]]$coordinate_label[which.min(d2)]
      distance = sqrt(min(d2))
      return(list(index, distance))
    }
  } else if (distance == F) {
    if (is.na(index) == F) {
      return(list(index))
    } else {
      (return(paste0("Not exactly correspond to labeled brain region. Please set distance=T if youn want the nearest labeled region name.")))
    }
  }
}

