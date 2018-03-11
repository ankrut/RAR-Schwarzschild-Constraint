% load constants
lib.module.constraints

% load packages
ANCH	= lib.require(@lib.model.tov.rar.anchor);
MAP		= lib.require(@lib.model.tov.rar.map);
AXIS	= lib.require(@lib.model.tov.rar.axes.raw);
AXIS_SI	= lib.require(@lib.model.tov.rar.axes.SI);

% set model parameter
opts	= struct('xmax', 1E15, 'tau', 1E-16, 'rtau', 1E-4);
param	= struct('m', 48*keVcc, 'beta0', 1E-3, 'theta0', 30, 'W0', 200);
vm		= struct('param', param, 'options', opts);

% set condition (Schwarzschild)
N		= 1E73;
NU0		= -1E-1;					% prediction (valid range depends on beta0)

oAnch	= ANCH.interp1.radius(1E6);	% define radius (in R units)
% oAnch	= ANCH.velocity_plateau;	% define radius (at plateau)

fT		= @(obj) oAnch.map(obj,MAP.temperature);
fM		= @(obj) oAnch.map(obj,MAP.mass);
fR		= @(obj) oAnch.map(obj,MAP.radius);

fNU0	= @(obj) 2*log(fT(obj)/obj.data.beta0) + log(1 - fM(obj)/fR(obj));
fN		= @(obj) oAnch.map(obj,AXIS_SI.particleNumber);

list	= lib.module.ProfileResponseList([
	lib.module.ProfileResponse(fN, N)			% particle number condition
	lib.module.ProfileResponse(fNU0, NU0)		% Schwarzschild condition
]);

% find solution (theta0)
[p,vm] = script.nlinfit.beta0_theta0(vm,list);
% p = lib.model.tov.rar.profile('model', vm);


% plot metric potential
lib.module.figure.axes('x', AXIS.radius, 'axes', {
	'XScale',	'log',...
	'parent',	figure() ...
});

lib.view.plot.curve2D('data', p, 'x', AXIS.radius, 'y', @(obj) exp(obj.data.potential + fNU0(p)), 'plot', {'DisplayName', '${\rm e}^{\nu(r)}$'});
lib.view.plot.curve2D('data', p, 'x', AXIS.radius, 'y', @(obj) (1 - obj.data.mass./obj.data.radius), 'plot', {'DisplayName', '${\rm e}^{-\lambda(r)}$'});
lib.view.plot.legend([],'Location', 'northwest');

% plot particle density
lib.module.figure.axes('x', AXIS.radius, 'y', AXIS_SI.particleNumber, 'axes', {
	'XScale',	'log',...
	'YScale',	'log',...
	'parent',	figure() ...
});

lib.view.plot.curve2D('data', p, 'x', AXIS.radius, 'y', AXIS_SI.particleNumber);
plot(oAnch.map(p,MAP.radius),oAnch.map(p,AXIS_SI.particleNumber),'o');

