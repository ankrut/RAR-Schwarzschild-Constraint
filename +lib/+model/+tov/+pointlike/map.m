fV = @(M0,r) sqrt(1/2*(M0./r)./(1 - (M0./r)));

EXPORT.radius = lib.module.ProfileMapping(...
	@(obj) obj.data.radius,...
	'r' ...
);

EXPORT.mass = lib.module.ProfileMapping(...
	@(obj) obj.data.M0*ones(size(obj.data.radius)),...
	'M(r)'...
);

EXPORT.velocity = lib.module.ProfileMapping(...
	@(obj) real(fV(obj.data.M0,obj.data.radius)),...
	'v(r)'...
);