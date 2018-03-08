MAP		= lib.require(@lib.model.tov.pointlike.map);
SCALE	= lib.require(@lib.model.tov.scale);

% define axis
EXPORT.radius			= lib.module.ProfileAxis(MAP.radius,				SCALE.astro.radius);
EXPORT.mass				= lib.module.ProfileAxis(MAP.mass,					SCALE.astro.mass);
EXPORT.velocity			= lib.module.ProfileAxis(MAP.velocity,				SCALE.astro.velocity);
