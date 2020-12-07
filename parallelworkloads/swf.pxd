# distutils: language = c++

from parallelworkloads cimport _swf

cdef class SwfJob:
    cdef _swf.Job_t job

cdef object build(_swf.JobPointer)
cdef _swf.Job_t base(SwfJob)
