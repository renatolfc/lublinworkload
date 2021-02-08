# distutils: language = c++

DEF INTERACTIVE = 0
DEF BATCH = 1

DEF BUCKETS = 48

from typing import List
from . cimport swf
from ._swf cimport Job_t
from libcpp.vector cimport vector

cdef extern from "stdlib.h":
    void srand48(long seed)

cdef extern from "m_lublin99.c":
    void init(double* a1,double* b1,double* a2,double* b2,double* pa,double* pb,
              double* aarr,double* barr,double* anum,double* bnum , 
              double* SerialProb, double* Pow2Prob , 
              double* ULow , double* UMed , double* UHi , double* Uprob , 
              double weights[2][BUCKETS])

    void arrive_init(double *aarr , double*barr , double *anum, double *bnum,
                            int start_hour , double weights[2][BUCKETS])

    unsigned int calc_number_of_nodes(double SerialProb,double Pow2Prob,double ULow,
                                      double UMed,double Uhi,double Uprob)

    unsigned long time_from_nodes(double alpha1, double beta1,
                                  double alpha2, double beta2,
                                  double pa    , double pb   , unsigned int nodes)

    unsigned long arrive(int *type , double weights[2][BUCKETS],
                         double aarr[2] , double barr[2])

    void calc_next_arrive(int type ,double weights[2][BUCKETS] ,double aarr[2],
                          double barr[2])

    double hyper_gamma(double a1, double b1, double a2, double b2, double p)

ctypedef int bool
ctypedef int JobType 
ctypedef (double, double, double, double, double, double) RunTimeParameters
ctypedef (double, double, double, double) InterArrivalParameters

cdef _validateJobType(JobType jobType):
    if jobType > BATCH or jobType < INTERACTIVE:
        raise ValueError(
            'Unsupported job type ' + str(jobType)
        )

cdef class Lublin99:
    cdef JobType jobType
    cdef long seed

    cdef double[2] a1, b1, a2, b2, pa, pb
    cdef double[2] aarr, barr, anum, bnum
    cdef double[2] serialProb, pow2Prob
    cdef double[2] uLow, uMed, uHi, uProb
    cdef double[2][BUCKETS] weights

    cdef int _start
    cdef int _numJobs
    cdef JobType _currentType

    def __init__(self, jobType, seed, numJobs=1000):
        self.seed = seed
        self.jobType = jobType

        self._currentType = BATCH
        self.numJobs = numJobs
        self.start = 8

        srand48(self.seed)

        init(
            self.a1, self.b1, self.a2, self.b2, self.pa, self.pb,
            self.aarr, self.barr, self.anum, self.bnum,
            self.serialProb, self.pow2Prob,
            self.uLow, self.uMed, self.uHi, self.uProb,
            self.weights
        )

    property numJobs:
        def __get__(self):
            return self._numJobs
        def __set__(self, int _numJobs):
            if _numJobs < 1:
                raise ValueError("Can't generate less than a job")
            self._numJobs = _numJobs

    property start:
        def __set__(self, int _start):
            if not (0 <= _start <= 23):
                raise ValueError("start must be in [0, 23]")
            self._start = _start
        def __get__(self):
            return self._start

    cpdef setSerialProbability(self, JobType jobType, double prob):
        _validateJobType(jobType)

        if self.jobType:
            self.serialProb[jobType] = prob
        else:
            self.serialProb[0] = self.serialProb[1] = prob

    cpdef double getSerialProbability(self, JobType jobType):
        _validateJobType(jobType)

        return self.serialProb[jobType]

    cpdef setPower2Probability(self, JobType jobType, double prob):
        _validateJobType(jobType)

        if self.jobType:
            self.pow2Prob[jobType] = prob
        else:
            self.pow2Prob[0] = self.pow2Prob[1] = prob

    cpdef double getPower2Probability(self, JobType jobType):
        _validateJobType(jobType)

        return self.pow2Prob[jobType]

    cpdef setParallelJobProbabilities(self, JobType jobType, double uLow,
                                      double uMed, double uHi, double uProb):
        _validateJobType(jobType)

        if uLow > uHi:
            raise ValueError(
                "Lowest job size cannot be higher than max job size"
            )

        if not (uHi - 3.5 <= uMed <= uHi - 1.5):
            raise ValueError(
                "Medium probability should be in [uHi - 3.5, uHi - 1.5]"
            )

        if not (0.7 <= uProb <= .95):
            raise ValueError(
                "uProb should be in [0.7, 0.95]"
            )

        if self.jobType:
            self.uLow[jobType] = uLow
            self.uMed[jobType] = uMed
            self.uHi[jobType] = uHi
            self.uProb[jobType] = uProb
        else:
            self.uLow[INTERACTIVE] = self.uLow[BATCH] = uLow
            self.uMed[INTERACTIVE] = self.uMed[BATCH] = uMed
            self.uHi[INTERACTIVE] = self.uHi[BATCH] = uHi
            self.uProb[INTERACTIVE] = self.uProb[BATCH] = uProb

    cpdef double getParallelJobUProb(self, JobType jobType):
        _validateJobType(jobType)

        return self.uProb[jobType]

    cpdef double getParallelJobUHi(self, JobType jobType):
        _validateJobType(jobType)

        return self.uHi[jobType]

    cpdef double getParallelJobUMed(self, JobType jobType):
        _validateJobType(jobType)

        return self.uMed[jobType]

    cpdef double getParallelJobULow(self, JobType jobType):
        _validateJobType(jobType)

        return self.uLow[jobType]

    cpdef void setRunTimeParameters(self, JobType jobType, double a1, double a2,
                                    double b1, double b2, double pa, double pb):
        _validateJobType(jobType)

        if self.jobType:
            self.a1[jobType] = a1
            self.b1[jobType] = b1
            self.a2[jobType] = a2
            self.b2[jobType] = b2
            self.pa[jobType] = pa
            self.pb[jobType] = pb

        else:
            self.a1[INTERACTIVE] = self.a1[BATCH] = a1
            self.b1[INTERACTIVE] = self.b1[BATCH] = b1
            self.a2[INTERACTIVE] = self.a2[BATCH] = a2
            self.b2[INTERACTIVE] = self.b2[BATCH] = b2
            self.pa[INTERACTIVE] = self.pa[BATCH] = pa
            self.pb[INTERACTIVE] = self.pb[BATCH] = pb

    cpdef RunTimeParameters getRunTimeParameters(self, JobType jobType):
        _validateJobType(jobType)

        return (self.a1[jobType], self.a2[jobType], self.b1[jobType],
                self.b2[jobType], self.pa[jobType], self.pb[jobType])

    cpdef setInterArrivalTimeParameters(self, JobType jobType, double aarr,
                                       double barr, double anum, double bnum,
                                       double arar):
        _validateJobType(jobType)

        if self.jobType:
            self.aarr[jobType] = aarr * arar
            self.barr[jobType] = barr
            self.anum[jobType] = anum
            self.bnum[jobType] = bnum
        else:
            self.aarr[INTERACTIVE] = self.aarr[BATCH] = aarr * arar
            self.barr[INTERACTIVE] = self.barr[BATCH] = barr
            self.anum[INTERACTIVE] = self.barr[BATCH] = anum
            self.bnum[INTERACTIVE] = self.barr[BATCH] = bnum

    cpdef InterArrivalParameters getInterArrivalTimeParameters(self, JobType
                                                              jobType):
        return (self.aarr[jobType], self.barr[jobType],
                self.anum[jobType], self.bnum[jobType])

    cdef vector[Job_t] _generate(self):
        arrive_init(self.aarr, self.barr, self.anum, self.bnum,
                    self._start, self.weights)

        cdef vector[Job_t] ret
        for i in range(self._numJobs):
            arrivalTime = arrive(&self._currentType, self.weights, self.aarr,
                                 self.barr)
            nodes = calc_number_of_nodes(
                self.serialProb[self._currentType],
                self.pow2Prob[self._currentType],
                self.uLow[self._currentType], self.uMed[self._currentType],
                self.uHi[self._currentType], self.uProb[self._currentType]
            )

            runTime = time_from_nodes(
                self.a1[self._currentType], self.b1[self._currentType],
                self.a2[self._currentType], self.b2[self._currentType],
                self.pa[self._currentType], self.pb[self._currentType],
                nodes
            )

            ret.push_back(Job_t(
                i + 1, arrivalTime, -1, runTime, nodes, -1, -1, -1, -1, -1, 1,
                -1, -1, -1, self._currentType, -1, -1, -1
            ))

        return ret

    def generate(self) -> List[swf.SwfJob]:
        tmp = self._generate()
        ret = [0] * tmp.size()
        i = 0
        for e in tmp:
            ret[i] = swf.build(&e)
            i += 1
        return ret
