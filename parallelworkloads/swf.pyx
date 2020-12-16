# distutils: language = c++

from . cimport _swf

cdef object build(_swf.JobPointer job):
    return SwfJob(
        job.id, job.submit, job.wait, job.runtime, job.size, job.cpu, job.mem,
        job.reqsize, job.estimate, job.reqmem, job.status, job.uid, job.gid,
        job.executable, job.queueid, job.partition, job.depjob, job.think
    )

cdef class SwfJob:
    def __init__(self, jobId=-1, submissionTime=-1, waitTime=-1, runTime=-1,
                 allocProcs=1, avgCpuUsage=-1, usedMem=-1, reqProcs=-1,
                 reqTime=-1, reqMem=-1, status=-1, userId=-1, groupId=-1,
                 executable=-1, queueNum=-1, partNum=-1, precedingJob=-1,
                 thinkTime=-1):
        self.jobId = jobId
        self.submissionTime = submissionTime
        self.waitTime = waitTime
        self.runTime = runTime
        self.allocProcs = allocProcs
        self.avgCpuUsage = avgCpuUsage
        self.usedMem = usedMem
        self.reqProcs = reqProcs
        self.reqTime = reqTime
        self.reqMem = reqMem
        self.status = status
        self.userId = userId
        self.groupId = groupId
        self.executable = executable
        self.queueNum = queueNum
        self.partNum = partNum
        self.precedingJob = precedingJob
        self.thinkTime = thinkTime

    def __repr__(self):
        return (
            f'SwfJob(jobId={self.jobId}, submissionTime={self.submissionTime}, '
            f'waitTime={self.waitTime}, runTime={self.runTime}, '
            f'allocProcs={self.allocProcs}, avgCpuUsage={self.avgCpuUsage}, '
            f'usedMem={self.usedMem}, reqProcs={self.reqProcs}, '
            f'reqTime={self.reqTime}, reqMem={self.reqMem}, '
            f'status={self.status}, usedId={self.userId}, '
            f'groupId={self.groupId}, executable={self.executable}, '
            f'queueNum={self.queueNum}, partNum={self.partNum}, '
            f'precedingJob={self.precedingJob}, thinkTime={self.thinkTime})'
        )

    # Getters and Setters {{{
    @property  # {{{
    def jobId(self):
        return self.job.id
    @jobId.setter
    def jobId(self, id):
        self.job.id = id
    # }}}

    @property  # {{{
    def submissionTime(self):
        return self.job.submit
    @submissionTime.setter
    def submissionTime(self, submit):
        self.job.submit = submit
    # }}}

    @property  # {{{
    def waitTime(self):
        return self.job.wait
    @waitTime.setter
    def waitTime(self, wait):
        self.job.wait = wait
    # }}}

    @property  # {{{
    def runTime(self):
        return self.job.runtime
    @runTime.setter
    def runTime(self, runtime):
        self.job.runtime = runtime
    # }}}

    @property  # {{{
    def allocProcs(self):
        return self.job.size
    @allocProcs.setter
    def allocProcs(self, size):
        self.job.size = size
    # }}}

    @property  # {{{
    def avgCpuUsage(self):
        return self.job.cpu
    @avgCpuUsage.setter
    def avgCpuUsage(self, cpu):
        self.job.cpu = cpu
    # }}}

    @property  # {{{
    def usedMem(self):
        return self.job.mem
    @usedMem.setter
    def usedMem(self, mem):
        self.job.mem = mem
    # }}}

    @property  # {{{
    def reqProcs(self):
        return self.job.reqsize
    @reqProcs.setter
    def reqProcs(self, reqsize):
        self.job.reqsize = reqsize
    # }}}

    @property  # {{{
    def reqTime(self):
        return self.job.estimate
    @reqTime.setter
    def reqTime(self, estimate):
        self.job.estimate = estimate
    # }}}

    @property  # {{{
    def reqMem(self):
        return self.job.reqmem
    @reqMem.setter
    def reqMem(self, reqmem):
        self.job.reqmem = reqmem
    # }}}

    @property  # {{{
    def status(self):
        return self.job.status
    @status.setter
    def status(self, status):
        self.job.status = status
    # }}}

    @property  # {{{
    def userId(self):
        return self.job.uid
    @userId.setter
    def userId(self, uid):
        self.job.uid = uid
    # }}}

    @property  # {{{
    def groupId(self):
        return self.job.gid
    @groupId.setter
    def groupId(self, gid):
        self.job.gid = gid
    # }}}

    @property  # {{{
    def executable(self):
        return self.job.executable
    @executable.setter
    def executable(self, executable):
        self.job.executable = executable
    # }}}

    @property  # {{{
    def queueNum(self):
        return self.job.queueid
    @queueNum.setter
    def queueNum(self, queueid):
        self.job.queueid = queueid
    # }}}

    @property  # {{{
    def partNum(self):
        return self.job.partition
    @partNum.setter
    def partNum(self, partition):
        self.job.partition = partition
    # }}}

    @property  # {{{
    def precedingJob(self):
        return self.job.depjob
    @precedingJob.setter
    def precedingJob(self, depjob):
        self.job.depjob = depjob
    # }}}

    @property  # {{{
    def thinkTime(self):
        return self.job.think
    @thinkTime.setter
    def thinkTime(self, think):
        self.job.think = think
    # }}}

    # }}}
