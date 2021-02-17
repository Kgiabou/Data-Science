### Profiling on optimizing R code ####

###Profilling collects data to understad what part of 
## the code are running slow and they need optimization

system.time()

### Muti threaded BLAS (basic algebra standard librares)
### libraries for using multi-core processing or computation
### Package parallel for parallel programming

Rprof()

summaryRprof() #tabulates the output - time spent in ech function in the call stack


by.total()= #divides time spent on the function by total time
by.self()=  # the same but subtracts the time of previous functions

        
sample.interval

sampling.time

obtect.size ## returns the size of an R object