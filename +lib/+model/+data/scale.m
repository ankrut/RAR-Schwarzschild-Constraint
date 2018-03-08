lib.module.constraints

% SI (DEFAULT)
EXPORT.SI.radius		= lib.module.ProfileMapping(1, '{\rm m}');
EXPORT.SI.mass			= lib.module.ProfileMapping(1, '{\rm kg}');
EXPORT.SI.velocity		= lib.module.ProfileMapping(1, '{\rm m/s}');

% astro
EXPORT.astro.radius		= lib.module.ProfileMapping(1/parsec, '{\rm pc}');
EXPORT.astro.mass		= lib.module.ProfileMapping(1/Msun, '{M_\odot');
EXPORT.astro.velocity	= lib.module.ProfileMapping(1E-3, '{\rm km/s}');