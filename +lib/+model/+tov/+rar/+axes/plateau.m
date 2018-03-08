ANCH	= lib.require(@lib.model.tov.rar.anchor);
MAP		= lib.require(@lib.model.tov.rar.map);
SCALE	= lib.require(@lib.model.tov.rar.scale);

fLabel = @(Q) lib.sprintf('$%s/%s$', Q.map.label, Q.scale.label);

% define axis
EXPORT.radius			= lib.module.ProfileAxis('map', MAP.radius,			'scale', SCALE.plateau.radius,		'label', fLabel);
EXPORT.density			= lib.module.ProfileAxis('map', MAP.cache.density,	'scale', SCALE.plateau.density,		'label', fLabel);
EXPORT.pressure			= lib.module.ProfileAxis('map', MAP.cache.pressure,	'scale', SCALE.plateau.pressure,	'label', fLabel);
EXPORT.potential		= lib.module.ProfileAxis('map', MAP.potential,		'scale', SCALE.plateau.potential,	'label', fLabel);
EXPORT.mass				= lib.module.ProfileAxis('map', MAP.mass,			'scale', SCALE.plateau.mass,		'label', fLabel);
EXPORT.velocity			= lib.module.ProfileAxis('map', MAP.velocity,		'scale', SCALE.plateau.velocity,	'label', fLabel);
EXPORT.compactness		= lib.module.ProfileAxis('map', MAP.compactness,	'scale', SCALE.plateau.compactness,	'label', fLabel);
EXPORT.degeneracy		= lib.module.ProfileAxis('map', @(obj) ANCH.velocity_plateau.map(obj,MAP.degeneracy) - MAP.degeneracy.map(obj), 'label', '$\theta_p - \theta(r)$');