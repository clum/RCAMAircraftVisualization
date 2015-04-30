function [varargout] = SendPositionOrientationAndCameraViewToXPlaneOverUDP(varargin)

%SENDPOSITIONORIENTATIONANDCAMERAVIEWTOXPLANEOVERUDP Does as described
%
%   SENDPOSITIONORIENTATIONANDCAMERAVIEWTOXPLANEOVERUDP(U, IP_ADDRESS,
%   PORT_NUMBER, DIGITSPREC) takes the orientation and positions of both
%   the aircraft and the camera (in vector U) and converts to an
%   appropriate string to send and sends over UDP to X-Plane.
%
%   The vector U should be
%
%       U = [
%            phi (radians)
%            theta (radians)
%            psi (radians)
%            latitude (radians)
%            longitude (radians)
%            altitude (m)
%            phi_c (radians) (camera view euler angle)
%            theta_c (radians) camera view euler angle)
%            psi_c (radians) (camera view euler angle)
%            latitude_c (radians) (camera view location)
%            longitude_c (radians) (camera view location)
%            altitude_c (m) (camera view location)
%            zoom_c (camera zoom factor, 1 = no zoom, 2 = double zoom)
%           ]
%   
%   X-Plane receives and handles this message using the
%   UWTimedProcessingWithCameraUDP.xpl plugin.
%
%   The PORT_NUMBER should be set to the same thing that the
%   UWTimedProcessingWithCameraUDP.xpl (the X-Plane plugin) is expecting
%   (typically 49003).
%
%   DIGITSPREC specifies how many digits of precision to use when
%   converting from a number to a string (in the num2str command).  If you
%   are getting choppy animation X-Plane, try increasing this value.
%
%   Example usage
%
%       SendPositionOrientationAndCameraViewToXPlaneOverUDP(U,
%       '192.168.1.3', 49003, 10)
%   
%
%
%INPUT:     -U:             13x1 vector of [phi;theta;psi;lat;lon;alt;phi_c;theta_c;psi_c;lat_c;lon_c;alt_c;zoom_c]
%           -IP_ADDRESS:    string of the IP address of the machine running
%                           X-Plane
%           -PORT_NUMBER:   port number that
%                           UWTimedProcessingWithCameraUDP.xpl is using to
%                           listen for UDP packets
%           -DIGITSPREC:    number of digits of precision to use when
%                           converting a number to a string
%
%OUTPUT:    -None
%
%Created by Christopher Lum
%lum@u.washington.edu

%Version History:   05/11/12: Created
%                   05/14/12: Updated documentation
%                   05/15/12: Added zoom
%                   10/19/14: Updated for new UWMatlab codebase
%                   01/09/15: Removed reliance on mapping toolbox radtodeg

%----------------------OBTAIN USER PREFERENCES-----------------------------
switch nargin
    case 4
        %User supplies all inputs
        U                   = varargin{1};
        IP_ADDRESS          = varargin{2};
        PORT_NUMBER         = varargin{3};
        DIGITSPREC          = varargin{4};
        
    otherwise
        error('Invalid number of inputs');
end


%-----------------------CHECKING DATA FORMAT-------------------------------
%In the interest of efficiency, do not check inputs, errors should be
%raised later if input arguments are incorrect

% U

% IP_ADDRESS

% PORT_NUMBER

% DIGITSPREC


%-------------------------BEGIN CALCULATIONS-------------------------------
%Unpack inputs
phi             = U(1);
theta           = U(2);
psi             = U(3);
latitude        = U(4);
longitude       = U(5);
altitude        = U(6);
phi_c           = U(7);
theta_c         = U(8);
psi_c           = U(9);
latitude_c      = U(10);
longitude_c     = U(11);
altitude_c      = U(12);
zoom_c          = U(13);

%UWTimedProcessingWithCameraUDP.xpl is expecting phi, theta, psi, lat, and
%lon to be in degrees, convert there here
phiDeg          = UWConversionFactorsMisc.RadianToDegree(phi);
thetaDeg        = UWConversionFactorsMisc.RadianToDegree(theta);
psiDeg          = UWConversionFactorsMisc.RadianToDegree(psi);
latitudeDeg     = UWConversionFactorsMisc.RadianToDegree(latitude);
longitudeDeg    = UWConversionFactorsMisc.RadianToDegree(longitude);

phi_c_Deg          = UWConversionFactorsMisc.RadianToDegree(phi_c);
theta_c_Deg        = UWConversionFactorsMisc.RadianToDegree(theta_c);
psi_c_Deg          = UWConversionFactorsMisc.RadianToDegree(psi_c);
latitude_c_Deg     = UWConversionFactorsMisc.RadianToDegree(latitude_c);
longitude_c_Deg    = UWConversionFactorsMisc.RadianToDegree(longitude_c);

%UWTimedProcessingWithCameraUDP.xpl is expecting a space deliniated file string
data=[num2str(phiDeg, DIGITSPREC),' ',...
    num2str(thetaDeg, DIGITSPREC),' ',...
    num2str(psiDeg, DIGITSPREC),' ',...
    num2str(latitudeDeg, DIGITSPREC),' ',...
    num2str(longitudeDeg, DIGITSPREC),' ',...
    num2str(altitude, DIGITSPREC),' ',...
    num2str(phi_c_Deg, DIGITSPREC),' ',...
    num2str(theta_c_Deg, DIGITSPREC),' ',...
    num2str(psi_c_Deg, DIGITSPREC),' ',...
    num2str(latitude_c_Deg, DIGITSPREC),' ',...
    num2str(longitude_c_Deg, DIGITSPREC),' ',...
    num2str(altitude_c, DIGITSPREC),' ',...
    num2str(zoom_c, DIGITSPREC)];
    
%Send the data over UDP
debug = 0;
SendStringOverUDP(data, IP_ADDRESS, PORT_NUMBER, debug );




