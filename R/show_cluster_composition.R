#' @title
#' Show brain cluster composition
#' @description
#' Input a matrix of all MNI coordinates within a cluster,
#' and output the brain regions and the percentage of each region.
#' @param template One character vector which indicates the templates to use
#' (\code{"aal"} or \code{"ba"}). Use \code{"aal"} by default.
#' @return
#' Return a list of data frames and each of them correspond to a template.
#' Each data frame consists the brain region names and the corresponding percentage
#' of the input brain cluster.

#' If the coordinate does not fall into any labeled brain region (e.g., white matter),
#' it will be labeled as "NULL".
#' @seealso
#' \code{\link{show_nii_clusters}}
#' @export

show_cluster_composition <- function(coordinate_matrix, template = c("aal", "ba")) {

  # example matrix used: coordinate_matrix <- matrix(4:39, nrow = 3)
  if_template_exist <- template %in% names(label4mri_metadata)

  if (sum(!if_template_exist) != 0) {
    stop(paste0("Template `", paste(template[!if_template_exist], collapse = ", "), "` does not exist."))
  }

  # result <- t(mapply(
  #   FUN = mni_to_region_name,
  #   x = coordinate_matrix[1, ],
  #   y = coordinate_matrix[2, ],
  #   z = coordinate_matrix[3, ],
  #   distance = F,
  #   MoreArgs = list(template = template)
  # ))

  list_frequency_table <-
    lapply(
      template,
      function(.template) {
        # Label the coordinate matrix
        labeled_coordinate_matrix <-
          mapply(
            FUN = mni_to_region_name,
            x = coordinate_matrix[1, ],
            y = coordinate_matrix[2, ],
            z = coordinate_matrix[3, ],
            distance = F,
            MoreArgs = list(template = .template)
          )

        # Create a frequency table of the coordinates of each brain region
        brain_frequency <-
          table(unlist(labeled_coordinate_matrix[paste0(.template, ".label"), ]))

        sorted_brain_frequency <-
          sort(brain_frequency, decreasing = T)

        # Add a column of percentate of each brain region
        sorted_brain_percentage <-
          round(sorted_brain_frequency / ncol(coordinate_matrix), 3) * 100

        sorted_table_frequency_percentage <-
          cbind(sorted_brain_frequency, sorted_brain_percentage)

        colnames(sorted_table_frequency_percentage) <-
          c("Number of coordinates", "Percentage (%)")

        sorted_table_frequency_percentage
      }
    )

  names(list_frequency_table) <- paste(template,
    "cluster",
    "composition",
    sep = "."
  )

  # all_regions <- apply(result[, paste0(template, ".label")], 2, as.list)
  #
  # unique_regions <- lapply(all_regions,
  #   FUN = unique
  # )

  # percentage <-
  #   lapply(seq_along(all_regions),
  #     FUN = function(tem_index) {
  #       region_table <- table(unlist(all_regions[[tem_index]]))
  #
  #       paste0(round((unname(region_table) / sum(unname(region_table))) * 100, digits = 2), "%")
  #     }
  #   )

  list_frequency_table
}
