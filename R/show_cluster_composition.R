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

show_cluster_composition=function(coordinate_matrix,template){
        #Step1 : Call the function mni_to_region_name to compute the composition
        ...
        #Step2 : Output the result as a list
        return(list(region_name=region_name,
                    percentage = percentage))
}