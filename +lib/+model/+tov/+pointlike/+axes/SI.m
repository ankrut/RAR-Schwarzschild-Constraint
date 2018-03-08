MAP		= lib.require(@lib.model.tov.pointlike.map);
SCALE	= lib.require(@lib.model.tov.scale);

% define axis
EXPORT.radius			= lib.module.ProfileAxis(MAP.radius,				SCALE.SI.radius);
EXPORT.mass				= lib.module.ProfileAxis(MAP.mass,					SCALE.SI.mass);
EXPORT.velocity			= lib.module.ProfileAxis(MAP.velocity,				SCALE.SI.velocity);
