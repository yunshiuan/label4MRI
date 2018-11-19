#' @title MRI-labeling: MNI to AAL
#' @description Input an MNI coordinate, output the corresponding AAL (Automated Anatomical Labeling) brain region name.
#' @param x A number
#' @param y A number
#' @param z A number
#' @param distance  A logical value which indicates whether the distance-to-nearest-aal-region information should be shown (default=T). This could be turned off to speed up labeling process.
#' @export
#' @seealso \code{\link[utils]{head}}
#' @return If distance mode is on (distance=T), output a list with brain region name along with the corresponding distance.If distance=F, output a string of region name when available, otherwise output 'Not exactly correspond to aal-labeled brain region. Please set distance=T if you want the nearest aal-labeled region name.'.
#' @examples
#' # aal-corresponding point with distance mode on
#' mni_to_region_name(26,0,0,distance=T)
#' # aal-corresponding point with distance mode off (much faster)
#' mni_to_region_name(26,0,0,distance=F)
#'
#' #non-aal-corresponding point with distance mode on (output the nearest aal region name)
#' mni_to_region_name(0,0,0,distance=T)
#' #non-aal-corresponding point with distance mode off (output none aal region name)
#'mni_to_region_name(0,0,0,distance=F)
mni_to_region_name = function(x, y, z, distance = T) {
    r_index = mni_to_region_index(x, y, z, distance = distance)
    if (distance == T) {
        return(list(region = region_index_to_name(r_index[[1]]), distance = r_index[[2]]))
    } else if (distance == F && !is.character(r_index)) {
        return(region = region_index_to_name(r_index[[1]]))
    } else {
        return(region = r_index)
    }
}
