# detonation

A simple carbon detonation.  The reaction network should be set
through the GNUmakefile.

This sets up a domain with a uniform density (dens).  A large
temperature (T_l) is placed in the left side of the domain, and an
ambient temperature (T_r) is in the right.  The parameter center_T
specifies where, as a fraction of the domain length, to put the
interface, while width_T determines how wide the transition region is,
as a fraction of the domain length. Finally, the parameter cfrac, nfrac,
and ofrac, are the initial C12, N14, O16 fraction, and the remaining
material is He4.

The left side and right side can optionally approach each other with a
non-zero infall velocity, vel.

When run, the large temperature in the left side instantly flashes the
fuel, generating a lot of energy and a large overpressure.  The
signature of a propagating detonation is that a narrow energy
generation zone will keep pace with the rightward propagating
shockwave (as seen in the pressure field).

Note: if the domain is too small, then the burning will decouple from
the shock wave, and you will not get a detonation.

Some important inputs files:

* `inputs-det-x.nse` : this produces a nice detonation that gets hot
  enough for the ash to be in NSE.
* `inputs-det-x.subch_base`: this produces a He4 detonation using the
same initial condition in the shell burning stage of the subchandra problem.
