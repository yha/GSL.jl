#!/usr/bin/env julia
#GSL Julia wrapper
#(c) 2013 Jiahao Chen <jiahao@mit.edu>
################################
# 15.1 Real Symmetric Matrices #
################################
export gsl_eigen_symm_alloc, gsl_eigen_symm_free, gsl_eigen_symm,
       gsl_eigen_symmv_alloc, gsl_eigen_symmv_free, gsl_eigen_symmv


# This function allocates a workspace for computing eigenvalues of n-by-n real
# symmetric matrices.  The size of the workspace is O(2n).
# 
#   Returns: Ptr{Void}
#XXX Unknown output type Ptr{gsl_eigen_symm_workspace}
#XXX Coerced type for output Ptr{Void}
function gsl_eigen_symm_alloc{gsl_int<:Integer}(n::gsl_int)
    ccall( (:gsl_eigen_symm_alloc, :libgsl), Ptr{Void}, (Csize_t, ), n )
end


# This function frees the memory associated with the workspace w.
# 
#   Returns: Void
#XXX Unknown input type w::Ptr{gsl_eigen_symm_workspace}
#XXX Coerced type for w::Ptr{Void}
function gsl_eigen_symm_free(w::Ptr{Void})
    ccall( (:gsl_eigen_symm_free, :libgsl), Void, (Ptr{Void}, ), w )
end


# This function computes the eigenvalues of the real symmetric matrix A.
# Additional workspace of the appropriate size must be provided in w.  The
# diagonal and lower triangular part of A are destroyed during the computation,
# but the strict upper triangular part is not referenced.  The eigenvalues are
# stored in the vector eval and are unordered.
# 
#   Returns: Cint
#XXX Unknown input type w::Ptr{gsl_eigen_symm_workspace}
#XXX Coerced type for w::Ptr{Void}
function gsl_eigen_symm(w::Ptr{Void})
    A = convert(Ptr{gsl_matrix}, Array(gsl_matrix, 1))
    eval = convert(Ptr{gsl_vector}, Array(gsl_vector, 1))
    gsl_errno = ccall( (:gsl_eigen_symm, :libgsl), Cint, (Ptr{gsl_matrix},
        Ptr{gsl_vector}, Ptr{Void}), A, eval, w )
    if gsl_errno!= 0 throw(GSL_ERROR(gsl_errno)) end
    return unsafe_ref(A) ,unsafe_ref(eval)
end


# This function allocates a workspace for computing eigenvalues and
# eigenvectors of n-by-n real symmetric matrices.  The size of the workspace is
# O(4n).
# 
#   Returns: Ptr{Void}
#XXX Unknown output type Ptr{gsl_eigen_symmv_workspace}
#XXX Coerced type for output Ptr{Void}
function gsl_eigen_symmv_alloc{gsl_int<:Integer}(n::gsl_int)
    ccall( (:gsl_eigen_symmv_alloc, :libgsl), Ptr{Void}, (Csize_t, ), n )
end


# This function frees the memory associated with the workspace w.
# 
#   Returns: Void
#XXX Unknown input type w::Ptr{gsl_eigen_symmv_workspace}
#XXX Coerced type for w::Ptr{Void}
function gsl_eigen_symmv_free(w::Ptr{Void})
    ccall( (:gsl_eigen_symmv_free, :libgsl), Void, (Ptr{Void}, ), w )
end


# This function computes the eigenvalues and eigenvectors of the real symmetric
# matrix A.  Additional workspace of the appropriate size must be provided in
# w.  The diagonal and lower triangular part of A are destroyed during the
# computation, but the strict upper triangular part is not referenced.  The
# eigenvalues are stored in the vector eval and are unordered.  The
# corresponding eigenvectors are stored in the columns of the matrix evec.  For
# example, the eigenvector in the first column corresponds to the first
# eigenvalue.  The eigenvectors are guaranteed to be mutually orthogonal and
# normalised to unit magnitude.
# 
#   Returns: Cint
#XXX Unknown input type w::Ptr{gsl_eigen_symmv_workspace}
#XXX Coerced type for w::Ptr{Void}
function gsl_eigen_symmv(w::Ptr{Void})
    A = convert(Ptr{gsl_matrix}, Array(gsl_matrix, 1))
    eval = convert(Ptr{gsl_vector}, Array(gsl_vector, 1))
    evec = convert(Ptr{gsl_matrix}, Array(gsl_matrix, 1))
    gsl_errno = ccall( (:gsl_eigen_symmv, :libgsl), Cint, (Ptr{gsl_matrix},
        Ptr{gsl_vector}, Ptr{gsl_matrix}, Ptr{Void}), A, eval, evec, w )
    if gsl_errno!= 0 throw(GSL_ERROR(gsl_errno)) end
    return unsafe_ref(A) ,unsafe_ref(eval) ,unsafe_ref(evec)
end