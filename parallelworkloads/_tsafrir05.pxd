# distutils: language = c++

from parallelworkloads cimport swf
from parallelworkloads._swf cimport Job_t

from libcpp cimport bool
from libcpp.vector cimport vector

cdef extern from "est_model.cc":
    pass

cdef extern from "est_model.hh":
    cpdef cppclass EstBin_t:
        int time
        int njobs
        EstBin_t()
        EstBin_t(int, int)

    cpdef cppclass EstParams_t:
        int njobs
        int max_est
        vector[EstBin_t] bins
        bool binnum_linear_model
        double binnum_power_params[2]
        int binnum
        double binsiz_head_params[3]
        double binsiz_head_sum
        double binsiz_tail_params[3]
        double bintim_param
        EstParams_t()
        EstParams_t(int, int, vector[EstBin_t])

    cdef void est_gen_dist(EstParams_t, vector[EstBin_t] *)
    cdef void est_assign(vector[EstBin_t] &, vector[Job_t] *)

ctypedef (EstParams_t *) ParamPointer
