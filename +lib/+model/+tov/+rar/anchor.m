% load FD anchors
EXPORT = lib.require(@lib.model.tov.fd.anchor);

% extend RAR anchors
MAP		= lib.require(@lib.model.tov.rar.map);
AXIS	= lib.require(@lib.model.tov.rar.axes.astro);

EXPORT.surface = lib.module.ProfileAnchor(...
	@(obj) MAP.radius.map(obj),...
	@(obj,X) obj.data.radius(end)...
);

EXPORT.interp1.radius = @(R) lib.module.ProfileAnchor(...
	@(obj) MAP.radius.map(obj),...
	@(obj,X) R ...
);

% define anchor for critical surface
RHOcr		= 1E-5; % in Msun/pc³
fDensity	= @(obj) AXIS.density.map(obj) - RHOcr;
fRadius		= @(obj) [
	EXPORT.velocity_halo.map(obj,AXIS.radius)
	EXPORT.surface.map(obj,AXIS.radius)
];
fCriticalRadius = @(obj) fzero(@(x) interp1(AXIS.radius.map(obj), fDensity(obj),x,'spline'),fRadius(obj));

EXPORT.virialSurface = lib.module.ProfileAnchor(...
	@(obj) AXIS.radius.map(obj),...
	@(obj,X) interp1(AXIS.radius.map(obj),X,fCriticalRadius(obj),'spline') ...
);
