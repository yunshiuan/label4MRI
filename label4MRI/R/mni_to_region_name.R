#' @title MRI-labeling: label the brain MNI coordinate by AAL/BA system
#' @description Input an MNI coordinate, output the corresponding AAL/BA brain region name.
#' @param x The numeric x value of the MNI coordinate.
#' @param y The numeric y value of the MNI coordinate.
#' @param z The numeric z value of the MNI coordinate.
#' @param distance  A logical value which indicates whether the closest region
#' should be shown when there is no exact match (\code{default = T}).
#' This could be turned off to speed up the labeling process.
#' @param template A character vector which indicates the templates to use,
#'  `aal` by default.
#' @return If distance mode is on (\code{distance = T}),
#' output a list of brain region names along with the corresponding distances (mm).
#' Please set \code{distance = T} if you want the closest region name even when
#' there is no exact matching brain region.
#' If distance mode is off (\code{distance = F}),
#' output a string of region names only when available,
#' otherwise output 'NULL'.
#' @examples
#' # Exact matching brain region with distance mode on
#' mni_to_region_name(26, 0, 0, distance = T)
#' # Exact matching brain region with distance mode off (much faster)
#' mni_to_region_name(26, 0, 0, distance = F)
#'
#' # No exact matching brain region with distance mode on (output the nearest brain region name)
#' mni_to_region_name(0, 0, 0, distance = T)
#' # No exact matching brain region  with distance mode off (output nothing)
#' mni_to_region_name(0, 0, 0, distance = F)
#'
#' # Only acquire AAL region name
#' mni_to_region_name(26, 0, 0, distance = T, template = "aal")
#' @export

mni_to_region_name <- function(x, y, z, distance = T, template = c("aal", "ba")) {
  if_template_exist <- template %in% names(label4mri_metadata)

  if (sum(!if_template_exist) != 0) {
    stop(paste0("Template `", paste(template[!if_template_exist], collapse = ", "), "` does not exist."))
  }

  r_indexes <- lapply(
    template,
    function(.template) {
      result <- mni_to_region_index(x, y, z, distance, .template)
      df_region_index_name <- label4mri_metadata[[.template]]$label

      result$label <- as.character(
        df_region_index_name[
          df_region_index_name$Region_index == result$index,
          "Region_name"
        ]
      )
      result$label <- ifelse(length(result$label) == 0, "NULL", result$label)
      result$index <- NULL
      result
    }
  )

  result <- unlist(r_indexes, recursive = F)
  names(result) <- paste(
    rep(template, each = 2),
    rep(c("distance", "label"), length(template)),
    sep = "."
  )

  result
}
