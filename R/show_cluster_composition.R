#' @title
#' Show cluster composition.
#' @description
#' Input a matrix of all MNI coordinates within a cluster,
#' and output the brain regions and the percentage of each region. 
#' @param template One character value which indicates the templates to use.
#'   (\code{"aal"} or \code{"ba"}). Use \code{"aal"} by default.
#' @return
#' Return a list of data frames and each of them correspond to a template.
#' Each data frame consists the brain region names and the corresponding percentage
#' of the input brain cluster.
#' @seealso
#' \code{\link{show_nii_clusters}}
#' @keywords internal
#' @noRd


# 1/16 found out it cant handel single template ...................... and output is UGLY

show_cluster_composition <- function(coordinate_matrix, template = c("aal", "ba")) {

  # example matrix used: coordinate_matrix <- matrix(4:39, nrow = 3)

  if_template_exist <- template %in% names(label4mri_metadata)

  if (sum(!if_template_exist) != 0) {
    stop(paste0("Template `", paste(template[!if_template_exist], collapse = ", "), "` does not exist."))
  }

  result <- t(mapply(
    FUN = mni_to_region_name,
    x = coordinate_matrix[1, ],
    y = coordinate_matrix[2, ],
    z = coordinate_matrix[3, ],
    distance = F,
    MoreArgs = list(template = template)
  ))

  all_regions <- apply(result[, paste0(template, ".label")], 2, as.list)

  unique_regions <- lapply(all_regions, # length = number of templates
    FUN = unique
  )

  percentage <-
    lapply(seq_along(all_regions), # length = number of templates
      FUN = function(tem_index) {
        region_table <- table(unlist(all_regions[[tem_index]]))

        paste0(round((unname(region_table) / sum(unname(region_table))) * 100, digits = 2), "%")
      }
    )

  return(list(unique_regions, percentage))
}
