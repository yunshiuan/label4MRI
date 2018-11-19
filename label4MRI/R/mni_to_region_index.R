
mni_to_region_index <- function(x, y, z, distance = T) {
    
    index = as.numeric(subset(mni2aal, x_mni == round(x) & y_mni == round(y) & z_mni == round(z), select = Region_index))
    
    if (distance == T) {
        if (is.na(index) == F) {
            return(list(index, distance = 0))
        } else {
            d_x = (mni2aal$x_mni - x)^2
            d_y = (mni2aal$y_mni - y)^2
            d_z = (mni2aal$z_mni - z)^2
            d2 = colSums(rbind(d_x, d_y, d_z))
            index = mni2aal$Region_index[which.min(d2)]
            distance = sqrt(min(d2))
            return(list(index, distance))
        }
    } else if (distance == F) {
        if (is.na(index) == F) {
            return(list(index))
        } else {
            (return(paste0("Not exactly correspond to aal-labeled brain region. Please set distance=T if youn want the nearest aal-labeled region name.")))
        }
    }
}

