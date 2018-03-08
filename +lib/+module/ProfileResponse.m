classdef ProfileResponse < lib.module.ProfileMapping
	properties
		prediction
		weight
	end
	
	methods
		function obj = ProfileResponse(fmap,prediction,varargin)
			obj = obj@lib.module.ProfileMapping(fmap,'');
			
			obj.prediction	= prediction;
			
			if nargin == 2
				obj.weight = 1./prediction.^2;
			else
				obj.weight = varargin{1};
			end
		end
		
		function x=chi2(obj,profile)
			switch class(obj.prediction)
				case 'char'
					switch obj.prediction
						case 'min'
						x = obj.map(profile);

						case 'max'
						x = -obj.map(profile);
					end
					
				case 'double'
				x = obj.weight.*(obj.map(profile) - obj.prediction).^2;
			end
		end
	end
end
