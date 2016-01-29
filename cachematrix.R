# Special matrix to cache inverse
makeCacheMatrix <- function( m = matrix() ) {
i <- NULL
# set the matrix
set <- function( matrix ) {
m <<- matrix
i <<- NULL
}
# get the matrix
get <- function() {
# return the matrix
m
}
#set the inverse of the matrix
setInverse <- function(inverse) {
i <<- inverse
}
#  get the inverse of the matrix
getInverse <- function() {
i
}


list(set = set, get = get,
setInverse = setInverse,
getInverse = getInverse)
}

# Compute the inverse of the special matrix returned by "makeCacheMatrix"

cacheSolve <- function(x, ...) {
# matrix that is the inverse of 'x'
m <- x$getInverse()
if( !is.null(m) ) {
message("getting cached data")
return(m)
}

data <- x$get()
# inverse using matrix multiplication
m <- solve(data) %*% data
# Set the inverse to the object
x$setInverse(m)
## Return the matrix
m
}