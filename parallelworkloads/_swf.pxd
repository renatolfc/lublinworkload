# distutils: language = c++
#
cdef extern from "est_swf_job.hh":
    cdef cppclass Job_t:
        int id
        double submit
        double wait
        double runtime
        int size
        double cpu
        double mem
        int reqsize
        double estimate
        double reqmem
        short status
        int uid
        int gid
        int executable
        int queueid
        int partition
        int depjob
        double think

        Job_t()
        Job_t(int, double, double, double, int, double, double, int, double,
              double, short, int, int, int, int, int, int, double)

ctypedef (Job_t *) JobPointer
