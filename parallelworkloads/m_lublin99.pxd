# distutils: language = c++

cdef extern from "m_lublin99.c":
    void init(double* a1,double* b1,double* a2,double* b2,double* pa,double* pb,
              double* aarr,double* barr,double* anum,double* bnum , 
              double* SerialProb, double* Pow2Prob , 
              double* ULow , double* UMed , double* UHi , double* Uprob , 
              double weights[2][48])

    unsigned int calc_number_of_nodes(double SerialProb,double Pow2Prob,double ULow,
                                      double UMed,double Uhi,double Uprob)

    unsigned long time_from_nodes(double alpha1, double beta1,
                                  double alpha2, double beta2,
                                  double pa    , double pb   , unsigned int nodes)

    unsigned long arrive(int *type , double weights[2][48],
                         double aarr[2] , double barr[2])

    void calc_next_arrive(int type ,double weights[2][48] ,double aarr[2],
                          double barr[2])

    double hyper_gamma(double a1, double b1, double a2, double b2, double p)
