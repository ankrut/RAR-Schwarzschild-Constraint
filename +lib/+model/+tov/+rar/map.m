% load FD mapping
EXPORT = lib.require(@lib.model.tov.map,@lib.model.tov.fd.map);

% define density and pressure function handles
NN			= 500;

func_n		= @(E,beta,alpha,ec) (1 - exp((E - ec)./beta))./(exp((E - alpha)./beta) + 1).*sqrt(E.^2 - 1).*E;
func_rho	= @(E,beta,alpha,ec) (1 - exp((E - ec)./beta))./(exp((E - alpha)./beta) + 1).*sqrt(E.^2 - 1).*E.^2;
func_p		= @(E,beta,alpha,ec) (1 - exp((E - ec)./beta))./(exp((E - alpha)./beta) + 1).*(E.^2 - 1).^(3/2);

% % % fn			= @(r,nu) real(4/sqrt(pi)*lib.model.tov.rar.integral.trapz(func_n,BETA0*exp(-nu./2),ALPHA0*exp(-nu./2),EC0*exp(-nu./2),NN));
% % % frho		= @(r,nu) real(4/sqrt(pi)*lib.model.tov.rar.integral.trapz(func_rho,BETA0*exp(-nu./2),ALPHA0*exp(-nu./2),EC0*exp(-nu./2),NN));
% % % fp			= @(r,nu) real(4/3/sqrt(pi)*lib.model.tov.rar.integral.trapz(func_p,BETA0*exp(-nu./2),ALPHA0*exp(-nu./2),EC0*exp(-nu./2),NN));


func_vRMS1	= @(E,beta,alpha,ec) sqrt(E.^2 - 1)./E.*(1 - exp((E - ec)./beta))./(exp((E - alpha)./beta) + 1);
func_vRMS2	= @(E,beta,alpha,ec) sqrt(E.^2 - 1).*E.*(1 - exp((E - ec)./beta))./(exp((E - alpha)./beta) + 1);
fvRMS		= @(r,nu) real(1 - lib.model.tov.rar.integral.trapz(func_vRMS1,BETA0*exp(-nu./2),ALPHA0*exp(-nu./2),EC0*exp(-nu./2),NN)./lib.model.tov.rar.integral.trapz(func_vRMS2,BETA0*exp(-nu./2),ALPHA0*exp(-nu./2),EC0*exp(-nu./2),NN));


func_pRMS1	= @(E,beta,alpha,ec) sqrt(E.^2 - 1).*E.^3.*(1 - exp((E - ec)./beta))./(exp((E - alpha)./beta) + 1);
func_pRMS2	= @(E,beta,alpha,ec) sqrt(E.^2 - 1).*E.*(1 - exp((E - ec)./beta))./(exp((E - alpha)./beta) + 1);
fpRMS		= @(r,nu) real(lib.model.tov.rar.integral.trapz(func_pRMS1,BETA0*exp(-nu./2),ALPHA0*exp(-nu./2),EC0*exp(-nu./2),NN)./lib.model.tov.rar.integral.trapz(func_pRMS2,BETA0*exp(-nu./2),ALPHA0*exp(-nu./2),EC0*exp(-nu./2),NN) - 1);

% extensions for RAR model

EXPORT.particleDensity = lib.module.ProfileMapping(...
	@(obj) real(4/sqrt(pi)*lib.model.tov.rar.integral.trapz(...
		func_n,...
		obj.data.beta0*exp(-obj.data.potential./2),...
		(1 + obj.data.beta0*obj.data.theta0)*exp(-obj.data.potential./2),...
		(1 + obj.data.beta0*obj.data.W0)*exp(-obj.data.potential./2),...
		NN ...
	)),...
	'n(r)' ...
);


fn0 = @(obj) 4/sqrt(pi)*lib.model.tov.rar.integral.trapz(...
	func_n,...
	obj.data.beta0,...
	(1 + obj.data.beta0*obj.data.theta0),...
	(1 + obj.data.beta0*obj.data.W0),...
	NN ...
);

EXPORT.particleNumber = lib.module.ProfileMapping(...
	@(obj) cumtrapz(EXPORT.radius.map(obj),EXPORT.particleDensity.map(obj).*EXPORT.radius.map(obj).^2),...
	'N(r)' ...
);

EXPORT.density = lib.module.ProfileMapping(...
	@(obj) real(4/sqrt(pi)*lib.model.tov.rar.integral.trapz(...
		func_rho,...
		obj.data.beta0*exp(-obj.data.potential./2),...
		(1 + obj.data.beta0*obj.data.theta0)*exp(-obj.data.potential./2),...
		(1 + obj.data.beta0*obj.data.W0)*exp(-obj.data.potential./2),...
		NN ...
	)),...
	'\rho(r)' ...
);

EXPORT.pressure = lib.module.ProfileMapping(...
	@(obj) real(4/3/sqrt(pi)*lib.model.tov.rar.integral.trapz(...
		func_p,...
		obj.data.beta0*exp(-obj.data.potential./2),...
		(1 + obj.data.beta0*obj.data.theta0)*exp(-obj.data.potential./2),...
		(1 + obj.data.beta0*obj.data.W0)*exp(-obj.data.potential./2),...
		NN ...
	)),...
	'P(r)' ...
);


fvRMS1 = @(obj) lib.model.tov.rar.integral.trapz(...
	func_vRMS1,...
	obj.data.beta0*exp(-obj.data.potential./2),...
	(1 + obj.data.beta0*obj.data.theta0)*exp(-obj.data.potential./2),...
	(1 + obj.data.beta0*obj.data.W0)*exp(-obj.data.potential./2),...
	NN ...
);

fvRMS2 = @(obj) lib.model.tov.rar.integral.trapz(...
	func_vRMS2,...
	obj.data.beta0*exp(-obj.data.potential./2),...
	(1 + obj.data.beta0*obj.data.theta0)*exp(-obj.data.potential./2),...
	(1 + obj.data.beta0*obj.data.W0)*exp(-obj.data.potential./2),...
	NN ...
);

EXPORT.velocityRMS = lib.module.ProfileMapping(...
	@(obj) sqrt(1 - fvRMS1(obj)./fvRMS2(obj)),...
	'\sigma(r)' ...
);


fpRMS1 = @(obj) lib.model.tov.rar.integral.trapz(...
	func_pRMS1,...
	obj.data.beta0*exp(-obj.data.potential./2),...
	(1 + obj.data.beta0*obj.data.theta0)*exp(-obj.data.potential./2),...
	(1 + obj.data.beta0*obj.data.W0)*exp(-obj.data.potential./2),...
	NN ...
);

fpRMS2 = @(obj) lib.model.tov.rar.integral.trapz(...
	func_pRMS2,...
	obj.data.beta0*exp(-obj.data.potential./2),...
	(1 + obj.data.beta0*obj.data.theta0)*exp(-obj.data.potential./2),...
	(1 + obj.data.beta0*obj.data.W0)*exp(-obj.data.potential./2),...
	NN ...
);

EXPORT.momentumRMS = lib.module.ProfileMapping(...
	@(obj) sqrt(fpRMS1(obj)./fpRMS2(obj) - 1),...
	'\varpi(r)' ...
);


EXPORT.escapeEnergy = lib.module.ProfileMapping(...
	@(obj) (1 + obj.data.beta0*obj.data.W0)*exp(-1/2*obj.data.potential),...
	'\varepsilon(r)' ...
);

EXPORT.cutoff = lib.module.ProfileMapping(...
	@(obj) (EXPORT.escapeEnergy.map(obj) - 1)./EXPORT.temperature.map(obj),...
	'W(r)'...
);

EXPORT.cutoffDiff = lib.module.ProfileMapping(...
	@(obj) -1/2./EXPORT.temperature.map(obj).*EXPORT.potentialDiff.map(obj),...
	'W''(r)'...
);



% map CACHED data
EXPORT.cache.density = lib.module.ProfileMapping(...
	@(obj) obj.data.density,...
	'\rho(r)' ...
);


EXPORT.cache.pressure = lib.module.ProfileMapping(...
	@(obj) obj.data.pressure,...
	'P(r)' ...
);


% MAKEUP (hide artefacts)
EXPORT.makeup.radius = lib.module.ProfileMapping(...
	@(obj) [realmin;obj.data.radius(2:end)],...
	'r' ...
);

EXPORT.makeup.density = lib.module.ProfileMapping(...
	@(obj) [obj.data.density(1:end-1); realmin],...
	'\rho(r)' ...
);

EXPORT.makeup.pressure = lib.module.ProfileMapping(...
	@(obj) [obj.data.pressure(1:end-1); realmin],...
	'P(r)'...
);