MAP		= lib.require(@lib.model.tov.rar.map);
SCALE	= lib.require(@lib.model.tov.rar.scale);

fLabel = @(Q) lib.sprintf('$%s\quad[%s]$', Q.map.label, Q.scale.label);

% define axis
EXPORT.radius			= lib.module.ProfileAxis('map', MAP.radius,			'scale', SCALE.astro.radius,		'label', fLabel);
EXPORT.density			= lib.module.ProfileAxis('map', MAP.cache.density,	'scale', SCALE.astro.density,		'label', fLabel);
EXPORT.pressure			= lib.module.ProfileAxis('map', MAP.cache.pressure,	'scale', SCALE.astro.pressure,		'label', fLabel);
EXPORT.mass				= lib.module.ProfileAxis('map', MAP.mass,			'scale', SCALE.astro.mass,			'label', fLabel);
EXPORT.velocity			= lib.module.ProfileAxis('map', MAP.velocity,		'scale', SCALE.astro.velocity,		'label', fLabel);
EXPORT.velocityRMS		= lib.module.ProfileAxis('map', MAP.velocityRMS,	'scale', SCALE.astro.velocity,		'label', fLabel);
EXPORT.massDiff			= lib.module.ProfileAxis('map', MAP.massDiff,		'scale', SCALE.astro.massDiff,		'label', fLabel);
EXPORT.degeneracyDiff	= lib.module.ProfileAxis('map', MAP.degeneracyDiff,	'scale', SCALE.astro.degeneracyDiff,'label', fLabel);
