#' @title
#' ....
#' @description
#' ...
#' ...
#' @param template One character value which indicates the templates to use
#'   (\code{"aal"} or \code{"ba"}). Use \code{"aal"} by default.
#' @return
#' Return a list of data frames and each of them correspond to a template.
#' Each data frame consists the MNI coordinates of the input brain region.
#' @seealso
#' \code{\link{mni_to_region_name}} \cr
#' \code{\link{list_brain_regions}}
#' @examples
#' # Get the MNI cooridnates of the right precentral region
#' # defined by AAL template
#' region_name_to_mni(region_names = "Precentral_R", template = "aal")
#'
#' # Get the MNI cooridnates of both the right and left precentral region
#' # defined by AAL template
#' region_name_to_mni(
#'   region_names = c("Precentral_R", "Precentral_L"),
#'   template = "aal"
#' )
#' @keywords internal
#' @noRd



show_cluster_composition <- function(coordinate_matrix, template = c("aal", "ba")) {
  ## Step1 : Call the function mni_to_region_name to compute the composition

  # my logic & thought process:
  # what form will coordinate_matrix take? now assumed: 3 by n matrix
  # example matrix used: ccmatrix <- matrix(4:39, nrow = 3)
  # read all the coordinates in the matrix, output a list of result
  # ignore distance for now? maybe can output text warning if some distance != 0
  # count the number of coordinates, set as denaminator
  # count unique region names, set as numerator
  # fraction * 100% = percentage
  m <- coordinate_matrix
  Result <- t(mapply(FUN = mni_to_region_name, x = m[1, ], y = m[2, ], z = m[3, ]))


  if (template == "aal") {
    # all_regions <- unlist(Result[, 2])
    all_regions <- Result[, 2]
  } else if (template == "ba") {
    all_regions <- Result[, 4]
  }

  unique_comp <- unique(all_regions)

  percentage <- lapply(unique_comp,
    FUN = function(.unique_comp) {
      whole_num <- ncol(m)
      part_num <- sum(all_regions == .unique_comp)
      round((part_num / whole_num) * 100, digits = 2)
    }
  )

  # Step2 : Output the result as a list
  return(list(
    region_names = unique_comp,
    percentage = percentage
  ))
}
