% class for fully degenerate core (fermionic model)
classdef profile < lib.module.tov
    methods
        function obj=profile(varargin)
			obj = obj@lib.module.tov();
			
			Q = lib.module.struct(varargin{:});
			
			if isfield(Q,'fermi_energy')
				obj.data.fermi_energy = Q.fermi_energy;
			end
		end
		
		function obj=calc(obj,opts)
			% destructor
			CELL = lib.struct.toCell(opts);
			Q = lib.module.struct(...
				'xmin',			'auto',...
				'xmax',			1E20,...
				'tau',			1E-16,...
				'rtau',			1E-4,...
				'tol',			1E-15,...
				CELL{:} ...
			);
		
			EF		= obj.data.fermi_energy;
			XMIN	= Q.xmin;
			XMAX	= Q.xmax;
			TOL		= Q.tol;		% how close to singularity (TOL > 0)
			TAU		= Q.tau;		% absolute error for ode solver
			RTAU	= Q.rtau;		% relative error for ode solver
			
			tt = cputime;
			dt = 10; % sec;
			
			function [value,isterminal,direction] = fMaxExecutionTime()
				value		= dt - (cputime - tt);
				isterminal	= 1;
				direction	= 0;
			end
			
			function [value,isterminal,direction] = fEventNegative(x)
				value      = real(x);
				isterminal = 1;    % stop the integration
				direction  = -1;   % positive direction only
			end
			
			function [value,isterminal,direction] = fEvent(x)
				[value(1),isterminal(1),direction(1)] = fMaxExecutionTime();
				[value(2),isterminal(2),direction(2)] = fEventNegative(x);
			end
			
			% substitution
			fE		= @(nu) EF*exp(-nu./2);
			fK		= @(nu) sqrt(EF^2*exp(-nu) - 1);
			
			% method 1: most general approximation (f(r,E) ~ 1)
			frho	= @(r,nu) 1/2/sqrt(pi)*(2*fE(nu).*fK(nu).^3 + fE(nu).*fK(nu) - log(fE(nu) + fK(nu)));
			fp		= @(r,nu) 1/2/sqrt(pi)*(2/3*fE(nu).*fK(nu).^3 - fE(nu).*fK(nu) + log(fE(nu) + fK(nu)));
			
			% method 2: low Fermi energies (E_F ~ 1)
% 			frho	= @(r,nu) 4/3/sqrt(pi)*(2*fE(nu) - 2).^(3/2);
% 			fp		= @(r,nu) 4/5/sqrt(pi)*(2*fE(nu) - 2).^(5/2);
			
			% method 3: high Fermi energies (E_F >> 1)
% 			frho	= @(r,nu) 1/sqrt(pi)*(fE(nu)).^4;
% 			fp		= @(r,nu) 1/sqrt(pi)*(fE(nu)).^4;
			
			% set OPTIONS (for ODE solver)
			fevent	= @(r,y) fEvent(EF*exp(-y(1)/2) - 1); % check cutoff condition
			options	= odeset('RelTol',RTAU,'AbsTol',TAU*[1 1],'Event',fevent);
			
			if strcmp(XMIN,'auto')
				XMIN = sqrt(6*TOL/frho(0,0));
				
				if isinf(XMIN) || isnan(XMIN)
					error('derived xmin is ill (Inf or NaN)');
				end
			end

			% call ode solver for theta(r)
			RHO0		= frho(0,0);
			ICS			= [1/6*RHO0*XMIN^2, 1/3*RHO0*XMIN^2];
			[R, NU, M]	= lib.module.tov.ode_solver(ICS,frho,fp,XMIN,XMAX,options);
			
			kk = find(imag(NU) == 0);
			obj.data.radius			= R(kk);
			obj.data.potential		= NU(kk);
			obj.data.mass			= M(kk);
			
			% cache time consuming magnitudes
			obj.data.density		= frho(R(kk),NU(kk));
			obj.data.pressure		= fp(R(kk),NU(kk));
		end
	end
end