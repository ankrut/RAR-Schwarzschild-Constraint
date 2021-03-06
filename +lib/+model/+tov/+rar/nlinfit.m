function varargout = nlinfit(vm,list,varargin)
% set iteration print function
sPrec	= '%1.15e';
sFormat = strjoin({sPrec,sPrec,sPrec,'%1.3e\n'},'\t');
fLog	= @(SOL) fprintf(sFormat,SOL.data.beta0,SOL.data.theta0,SOL.data.W0,list.chi2(SOL));

% set predictions and weights
predictions = list.accumulate(@(elm) elm.prediction)';
weights		= list.accumulate(@(elm) elm.weight)';

% set response function
fResponse = @(SOL) list.accumulate(@(elm) elm.map(SOL))';

% set model wrapper (nlinfit vector => model)
fModel = @(SOL) struct(...
	'param', struct(...
		'beta0',	SOL.data.beta0,...
		'theta0',	SOL.data.theta0,...
		'W0',		SOL.data.W0 ...
	),...
	'options',	vm.options ...
);

% set solution function
fSolution = @(vm) lib.model.tov.rar.profile('model', vm);

% set options
opts = statset('nlinfit');
opts.FunValCheck = 'off';

% seach for solution
[varargout{1:nargout}] = lib.fitting.nlinfit(...
	'model',		vm,...
	'predictions',	predictions,...
	'weights',		weights,...
	'fResponse',	fResponse,...
	'fModel',		fModel,...
	'fSolution',	fSolution,...
	'fLog',			fLog,...
	'options',		opts,...
	varargin{:} ...
);