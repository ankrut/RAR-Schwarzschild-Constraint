% load packages
ANCH	= lib.require(@lib.model.tov.rar.anchor);
MAP		= lib.require(@lib.model.tov.rar.map);
AXIS	= lib.require(@lib.model.tov.rar.axes.raw);

% set model parameter
opts	= struct('xmax', 1E15, 'tau', 1E-16, 'rtau', 1E-4);
param	= struct('beta0', 1E-6, 'theta0', 30, 'W0', 200);
vm		= struct('param', param, 'options', opts);

% set nlinfit options
nlOpts = statset('nlinfit');
nlOpts.FunValCheck	= 'off';
nlOpts.MaxIter		= 50;
nlOpts.DerivStep	= 1E-2;

% set condition (Schwarzschild)
NU0		= -1E-4;					% prediction (between -2E-5 and -20E-5)
oAnch	= ANCH.velocity_plateau;	% define radius

fT		= @(obj) oAnch.map(obj,MAP.temperature);
fM		= @(obj) oAnch.map(obj,MAP.mass);
fR		= @(obj) oAnch.map(obj,MAP.radius);
fResp	= @(obj) 2*log(fT(obj)/obj.data.beta0) + log(1 - fM(obj)/fR(obj));

list	= lib.module.ProfileResponseList([
	lib.module.ProfileResponse(fResp, NU0)
]);

% find solution (theta0)
[p,vm] = lib.model.tov.rar.nlinfit.theta0(vm,list);
% p = lib.model.tov.rar.profile('model', vm);

% set axes
lib.module.figure.axes('x', AXIS.radius, 'axes', {
	'XScale',	'log',...
	'parent',	figure() ...
});

% plot metric potential
lib.view.plot.curve2D('data', p, 'x', AXIS.radius, 'y', @(obj) exp(obj.data.potential + fResp(p)), 'plot', {'DisplayName', '${\rm e}^{\nu(r)}$'});
lib.view.plot.curve2D('data', p, 'x', AXIS.radius, 'y', @(obj) (1 - obj.data.mass./obj.data.radius), 'plot', {'DisplayName', '${\rm e}^{-\lambda(r)}$'});
lib.view.plot.legend([],'Location', 'northwest');