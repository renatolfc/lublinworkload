lublinworkload
==============

A Python port of the Workload Model proposed by Lublin & Feitelson.

The following code shows how to use it:

.. code:: python

   from parallelworkloads import lublin99
   w = lublin99.Lublin99(1, 2)  # Will use both batch and interactive jobs
   w.numJobs=4  # will generate four jobs
   w.generate()  # The four generated jobs are shown below

   [SwfJob(jobId=1, submissionTime=103, waitTime=-1, runTime=12379,
   allocProcs=16, avgCpuUsage=-1, usedMem=-1, reqProcs=-1, reqTime=-1,
   reqMem=-1, status=1, userId=-1, groupId=-1, executable=-1, queueNum=1,
   partNum=-1, precedingJob=-1, thinkTime=-1),

   SwfJob(jobId=2, submissionTime=3089, waitTime=-1, runTime=177,
   allocProcs=16, avgCpuUsage=-1, usedMem=-1, reqProcs=-1, reqTime=-1,
   reqMem=-1, status=1, userId=-1, groupId=-1, executable=-1, queueNum=1,
   partNum=-1, precedingJob=-1, thinkTime=-1),

   SwfJob(jobId=3, submissionTime=3150, waitTime=-1, runTime=10, allocProcs=2,
   avgCpuUsage=-1, usedMem=-1, reqProcs=-1, reqTime=-1, reqMem=-1, status=1,
   userId=-1, groupId=-1, executable=-1, queueNum=0, partNum=-1,
   precedingJob=-1, thinkTime=-1),

   SwfJob(jobId=4, submissionTime=3172, waitTime=-1, runTime=7,
   allocProcs=32, avgCpuUsage=-1, usedMem=-1, reqProcs=-1, reqTime=-1,
   reqMem=-1, status=1, userId=-1, groupId=-1, executable=-1, queueNum=0,
   partNum=-1, precedingJob=-1, thinkTime=-1)]

