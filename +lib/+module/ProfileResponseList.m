classdef ProfileResponseList < lib.module.array
	methods
		function obj = ProfileResponseList(varargin)
			obj = obj@lib.module.array(varargin{:});
		end
		
		function value=chi2(obj,profile)
			fCHI2 = @(elm) elm.chi2(profile);
			value = sum(obj.accumulate(fCHI2));
		end
	end
end