classdef profile < lib.module.ProfileData
	methods
		function obj=profile(M,varargin)
			obj = obj@lib.module.ProfileData(varargin{:});
			obj.set('M0',M);
		end
	end
end