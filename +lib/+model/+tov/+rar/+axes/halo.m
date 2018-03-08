ANCH	= lib.require(@lib.model.tov.rar.anchor);
MAP		= lib.require(@lib.model.tov.rar.map);
SCALE	= lib.require(@lib.model.tov.rar.scale);

fLabel = @(Q) lib.sprintf('$%s/%s$', Q.map.label, Q.scale.label);

% define axis
EXPORT.radius			= lib.module.ProfileAxis('map', MAP.radius,			'scale', SCALE.halo.radius,			'label', fLabel);
EXPORT.density			= lib.module.ProfileAxis('map', MAP.cache.density,	'scale', SCALE.halo.density,		'label', fLabel);
EXPORT.pressure			= lib.module.ProfileAxis('map', MAP.cache.pressure,	'scale', SCALE.halo.pressure,		'label', fLabel);
EXPORT.potential		= lib.module.ProfileAxis('map', MAP.potential,		'scale', SCALE.halo.potential,		'label', fLabel);
EXPORT.mass				= lib.module.ProfileAxis('map', MAP.mass,			'scale', SCALE.halo.mass,			'label', fLabel);
EXPORT.velocity			= lib.module.ProfileAxis('map', MAP.velocity,		'scale', SCALE.halo.velocity,		'label', fLabel);
EXPORT.compactness		= lib.module.ProfileAxis('map', MAP.compactness,	'scale', SCALE.halo.compactness,	'label', fLabel);
EXPORT.degeneracy		= lib.module.ProfileAxis('map', @(obj) ANCH.velocity_halo.map(obj,MAP.degeneracy) - MAP.degeneracy.map(obj), 'label', '$\theta_h - \theta(r)$');