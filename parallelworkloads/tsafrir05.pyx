# distutils: language = c++

from typing import Optional, List

from libcpp.vector cimport vector

cimport swf
from parallelworkloads cimport _tsafrir05
from parallelworkloads._swf cimport Job_t

cdef class Tsafrir05:
    cdef _tsafrir05.ParamPointer params
    cdef vector[_tsafrir05.EstBin_t] bins

    def __cinit__(self):
        self.params = NULL

    def __init__(self, jobList: List[swf.SwfJob],
                 max_est : Optional[int] = None):

        if max_est is None:
            max_est = max([e.runTime for e in jobList])

        cdef vector[_tsafrir05.EstBin_t] bins = vector[_tsafrir05.EstBin_t]()
        cdef int size = len(jobList)
        self.params = new _tsafrir05.EstParams_t(size, max_est, bins)
        _tsafrir05.est_gen_dist(self.params[0], &self.bins)

    def __dealloc__(self):
        if self.params is not NULL:
            del self.params
            self.params = NULL

    def generate(self, jobs: List[swf.SwfJob]) -> List[swf.SwfJob]:
        if len(jobs) < 200:  # determined empirically, see
            raise ValueError(# `params_sanity_check`
                'User estimate generation requires at least 200 jobs'
            )
        cdef vector[Job_t] tmp
        for job in jobs:
            tmp.push_back(swf.base(job))

        _tsafrir05.est_assign(
            self.bins, &tmp
        )

        print(tmp[0].estimate)
        ret = [0] * tmp.size()
        i = 0
        for e in tmp:
            ret[i] = swf.build(&e)
            i += 1
        return ret
