# distutils: language = c++

from . cimport _swf

cdef class SwfJob:
    cdef _swf.Job_t job

cdef object build(_swf.JobPointer)
cdef inline _swf.Job_t base(SwfJob job):
    return job.job
