# RAR Schwarzschild Constraint
This example shows how to implement the Scharzschild condition nu(r) = -lambda(r) in the original RAR model. The results of the metric potential are given in the general form nu(r) - nu0.  Because the model works only with the configuration paramaters beta0 and theta0 (and W0) we have to keep in mind that nu(r) is in general a function of the configuration parameter as well. It is therefore necessary to determine nu0 in order to fullfil the Scharzschild condition. With lambda(r) = -ln(1 - M(r)/M * R/r) and the Tolman condition, ln beta(r)/beta0 = -[nu(r) - nu0]/2, we find the relation

nu0 = 2 ln beta(r)/beta0 + ln(1 - M(r)/M * R/r)

Here, R and M are the schaling factors for length and mass as used in this framework. They are link via 2GM/R/c^2 = 1. Note that nu0 is the prediction and the lhs of the above relation is the response function for a given beta0 and theta0. Same as nu(r), the mass function M(r) is a function of beta0 and theta0 as well. The only remaining requirement is to define a proper radius for the box. In this code example the plateau radius has been chosen for demonstrative purpose. 
