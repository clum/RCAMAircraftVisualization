classdef UWConversionFactorsMisc
    %Conversion factors for miscellaneous units
    %
    %Christopher Lum
    %lum@u.washington.edu
    %
    %Version History:   01/07/15: Created from C# version of this struct

    %----------------------------------------------------------------------
    %Static methods
    %----------------------------------------------------------------------
    methods(Static)
        function [Radian] = DegreeToRadian(Degree)
            %Convert degree to radian
            Radian = Degree .* (pi/180);
        end
        
        function [Degree] = RadianToDegree(Radian)
            %Convert radian to degree
            Degree = Radian .* (180/pi);
        end
        
        function [Seconds] = DaysToSeconds(Days)
            %Convert days to seconds
            Seconds = Days*24*60*60;
        end
        
        function [Days] = SecondsToDays(Seconds)
            %Convert seconds to days
            Days = Seconds./(UWConversionFactorsMisc.DaysToSeconds(1));
        end
    end
    
end

