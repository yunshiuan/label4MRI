#' @title
#' List all brain region names in AAL/BA system
#' @description
#' Input template names, output all the brain region names.
#' @param template A character value which indicates the templates of interest
#' (\code{"aal"} or \code{"ba"}). Use both of them by default.
#' @return
#' Return a list of charcter vectors.
#' Each character vector is all the brain region names defined by one of the template.
#' @examples
#' # List all brain region names defined by AAL.
#' list_brain_regions(template = "aal")
#' @export

list_brain_regions <- function(template = c("aal", "ba")) {
  if_template_exist <- template %in% names(label4mri_metadata)
  if (sum(!if_template_exist != 0)) {
    stop(paste0("Template `", paste(template[!if_template_exist], collapse = ", "), "` does not exist."))
  }

  list_of_brain_regions <-
    lapply(
      template,
      function(.template) {
        as.character(label4mri_metadata[[.template]]$label$Region_name)
      }
    )
  names(list_of_brain_regions) <- template
  list_of_brain_regions
}
