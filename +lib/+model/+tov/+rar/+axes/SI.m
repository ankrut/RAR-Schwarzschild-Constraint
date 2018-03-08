MAP		= lib.require(@lib.model.tov.rar.map);
SCALE	= lib.require(@lib.model.tov.rar.scale);

fLabelUnit		= @(Q) lib.sprintf('$%s\quad[%s]$', Q.map.label, Q.scale.label);
fLabelUnitless	= @(Q) lib.sprintf('$%s$', Q.map.label);

% define axis
EXPORT.radius			= lib.module.ProfileAxis('map',	MAP.radius,					'scale', SCALE.SI.radius,	'label', fLabelUnit);
EXPORT.density			= lib.module.ProfileAxis('map',	MAP.cache.density,			'scale', SCALE.SI.density,	'label', fLabelUnit);
EXPORT.pressure			= lib.module.ProfileAxis('map',	MAP.cache.pressure,			'scale', SCALE.SI.pressure,	'label', fLabelUnit);
EXPORT.mass				= lib.module.ProfileAxis('map',	MAP.mass,					'scale', SCALE.SI.mass,		'label', fLabelUnit);
EXPORT.velocity			= lib.module.ProfileAxis('map',	MAP.velocity,				'scale', SCALE.SI.velocity,	'label', fLabelUnit);
EXPORT.velDisp			= lib.module.ProfileAxis('map',	MAP.velocity_dispersion,	'scale', SCALE.SI.velocity,	'label', fLabelUnit);
EXPORT.speedOfSound		= lib.module.ProfileAxis('map',	MAP.velocitySOS,			'scale', SCALE.SI.velocity,	'label', fLabelUnit);
EXPORT.acceleration		= lib.module.ProfileAxis('map',	MAP.acceleration,			'scale', SCALE.SI.acceleration,	'label', fLabelUnit);


EXPORT.potential		= lib.module.ProfileAxis('map',	MAP.potential,		'label', fLabelUnitless);
EXPORT.compactness		= lib.module.ProfileAxis('map',	MAP.compactness,	'label', fLabelUnitless);
EXPORT.degeneracy		= lib.module.ProfileAxis('map',	MAP.degeneracy,		'label', fLabelUnitless);
EXPORT.cutoff			= lib.module.ProfileAxis('map',	MAP.cutoff,			'label', fLabelUnitless);
