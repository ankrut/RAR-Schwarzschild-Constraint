function [SOL,varargout] = find(varargin)
Q = lib.module.struct(...
	'tau',		1E-6,...
	varargin{:}...
); 

% destructure
vm			= Q.model;
list		= parseQuery(Q);
fSolution	= parseSolutionHandle(Q);

% init loop
nn			= numel(fSolution);
chi2(1:nn)	= nan;

for ii = 1:nn
	if isnan(min(chi2)) || min(chi2) > Q.tau
		try
			fprintf('\n');
			[SOL(ii),VM(ii)] = fSolution{ii}(vm,list);
			chi2(ii)		 = list.chi2(SOL(ii));
		end
	end
end

if isnan(min(chi2))
	error('no solution found')
end

% select best solution
kk				= chi2 == min(chi2);
SOL				= SOL(kk);
varargout{1}	= VM(kk);
varargout{2}	= chi2(kk);


function fSolution = parseSolutionHandle(Q)
switch class(Q.fSolution)
	case 'function_handle'
	fSolution{1} = Q.fSolution;
		
	case 'cell'
	fSolution = Q.fSolution;
		
	otherwise
	error('unknown fSolution type');	
end

function list = parseQuery(Q)
switch class(Q.query)
	case 'cell'
	q	 = lib.module.struct(Q.query{:});
	list = convertQueryToResponselist(q,Q.ResponseList);
	
	case 'struct'
	q	 = Q.query;
	list = convertQueryToResponselist(q,Q.ResponseList);
	
	case 'lib.module.ProfileResponse'
	list = lib.module.ProfileResponseList(Q.query);
	
	case 'lib.module.ProfileResponseList'
	list = Q.query;
	
	otherwise
	error('unknown query type');
end

function list = convertQueryToResponselist(q,ResponseList)
list = lib.module.array(fieldnames(q)).map(@(key) ...
	createResponse(ResponseList.(key),q.(key)) ...
).pipe(@lib.module.ProfileResponseList);

function elm = createResponse(response,prediction)
if numel(prediction) == 1
	elm = lib.module.ProfileResponse(response,prediction);
else
	elm = lib.module.ProfileResponse(response(prediction(1:end-1)),prediction(end));
end