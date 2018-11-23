#' @title MRI-labeling: MNI to AAL
#' @description Input an MNI coordinate, output the corresponding AAL (Automated Anatomical Labeling) brain region name.
#' @param x A number
#' @param y A number
#' @param z A number
#' @param distance  A logical value which indicates whether the distance-to-nearest-aal-region information should be shown (default=T). This could be turned off to speed up labeling process.
#' @param template A character vector indicates the templates to use, `aal` by default.
#' @export
#' @seealso \code{\link[utils]{head}}
#' @return If distance mode is on (distance=T), output a list with brain region name along with the corresponding distance.If distance=F, output a string of region name when available, otherwise output 'Not exactly correspond to aal-labeled brain region. Please set distance=T if you want the nearest aal-labeled region name.'.
#' @examples
#' # aal-corresponding point with distance mode on
#' mni_to_region_name(26,0,0,distance=T)
#' # aal-corresponding point with distance mode off (much faster)
#' mni_to_region_name(26,0,0,distance=F)
#'
#' # non-aal-corresponding point with distance mode on (output the nearest aal region name)
#' mni_to_region_name(0,0,0,distance=T)
#' # non-aal-corresponding point with distance mode off (output none aal region name)
#' mni_to_region_name(0,0,0,distance=F)
#'
#' # query both aal and ba structure
#' mni_to_region_name(26,0,0,distance=T)
mni_to_region_name <- function(x, y, z, distance = T, template = c('aal', 'ba')) {
  if_template_exist <- template %in% names(label4mri_metadata)

  if(sum(!if_template_exist) != 0) {
    stop(paste0('Template `', paste(template[!if_template_exist], collapse = ', '), '` does not exist.'))
  }

  r_indexes <- lapply(
    template,
    function(.template) {
      result <- mni_to_region_index(x, y, z, distance, .template)

      result$label <- as.character(
        label4mri_metadata[[.template]]$label[label4mri_metadata[[.template]]$label$Region_index == result$index, "Region_name"]
      )

      result
    }
  )

  result <- unlist(r_indexes, recursive = F)
  names(result) <- paste(
    rep(template, each = 3),
    rep(c('index', 'distance', 'label'), length(template)),
    sep = '.'
  )

  result
}
