#' Evaluate a FEM object at a set of point locations
#' 
#' @param FEM A \code{FEM} object to be evaluated.
#' @param locations A #dimensions-colums matrix with the spatial locations where the FEM object should be evaluated. (#dimensions = 2 or 3)
#' @param CPP_CODE Boolean. If \code{TRUE} the computation relies on the C++ implementation of a Visibility Walk Algorithm (Devillers et al. 2001). This usually ensures a fast computation.
#' @return 
#' A matrix of numeric evaluations of the \code{FEM} object. Each row indicates the location where the evaluation has been taken, the column indicates the 
#' function evaluated.
#' @description It evaluates a FEM object the specified set of locations.  
#' @usage eval.FEM(FEM, locations, CPP_CODE = TRUE)
#' @references 
#'  Devillers, O. et al. 2001. Walking in a Triangulation, Proceedings of the Seventeenth Annual Symposium on Computational Geometry

eval.FEM <- function(FEM, locations, CPP_CODE = TRUE)
{
  if (is.null(FEM)) 
    stop("FEM required;  is NULL.")
  if(class(FEM) != "FEM")
    stop("'FEM' is not of class 'FEM'")
  if (is.null(locations)) 
    stop("locations required;  is NULL.")
  if (is.null(CPP_CODE)) 
    stop("CPP_CODE required;  is NULL.")
  if(!is.logical(CPP_CODE))
    stop("'CPP_CODE' is not logical")
  
  locations = as.matrix(locations)
  
  res = NULL
  
  if(class(FEM$FEMbasis$mesh)=='MESH2D'){
    ndim = 2
    mydim = 2
	  if(CPP_CODE == FALSE)
	  {
	    res = R_eval.FEM(FEM, locations)
	  }else{ 
	    res = CPP_eval.FEM(FEM, locations, TRUE, ndim, mydim)
	  }
  }else if(class(FEM$FEMbasis$mesh)=='SURFACE_MESH'){
      ndim = 3
      mydim = 2
  	    res = CPP_eval.manifold.FEM(FEM, locations, TRUE, ndim, mydim)
  	  }
  return(as.matrix(res))
}
