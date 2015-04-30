classdef UWConversionFactorsLength
    %Conversion factors of lengths
    %
    %Christopher Lum
    %lum@u.washington.edu
    %
    %Version History:   01/05/15: Created from C# version of this struct

    %----------------------------------------------------------------------
    %Static methods
    %----------------------------------------------------------------------
    methods(Static)
        function [M] = FtToM(Ft)
            %Convert feet to meters
            M = Ft ./ UWConversionFactorsLength.MToFt(1);
        end
        
        function [Ft] = MToFt(M)
            %Convert meters to feet
            Ft = 3.28083989501 * M;
        end
        
        function [M] = NauticalMilesToMeters(NauticalMiles)
            %Convert nautical miles to meters
            M = 1852 * NauticalMiles;
        end
        
        function [NauticalMiles] = MetersToNauticalMiles(M)
            %Convert meters to nautical miles 
            NauticalMiles = M ./ UWConversionFactorsLength.NauticalMilesToMeters(1);
        end
        
    end
    
end

