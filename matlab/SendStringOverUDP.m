function [] = SendStringOverUDP(varargin)

%SENDSTRINGOVERUDP  Sends a string over UDP to a location and port number
%
%   SENDSTRINGOVERUDP(STR,IP_ADDRESS,PORT_NUMBER) Sends the string STR to
%   the specified IP_ADDRESS using PORT_NUMBER over a UDP connection.  
%
%   SENDSTRINGOVERUDP(STR,IP_ADDRESS,PORT_NUMBER,DEBUG) Does as above but
%   prints messages to the screen about the status if DEBUG==1.
%
%   Example usage
%
%       SendStringOverUDP('test string', '192.168.1.112', 49003)
%
%   This requires the UDP Toolbox (downloaded from Matlab Central and
%   located at D:\lum\matlab\UDP_toolbox\tcp_udp_ip_2_0_6\tcp_udp_ip)
%
%
%INPUT:     -STR:           string of data to send
%           -IP_ADDRESS:    string of the IP address where to send data
%           -PORT_NUMBER:   port number to use for sending data
%           -DEBUG:         set to 1 to display messages about status
%
%OUTPUT:    -None
%
%Created by Christopher Lum
%lum@u.washington.edu

%Version History:   -05/04/12: Created

%----------------------OBTAIN USER PREFERENCES-----------------------------
switch nargin
    case 4
        %User supplies all inputs
        STR             = varargin{1};
        IP_ADDRESS      = varargin{2};
        PORT_NUMBER     = varargin{3};
        DEBUG           = varargin{4};
        
    case 3
        %Assume user does not want DEBUG messages
        STR             = varargin{1};
        IP_ADDRESS      = varargin{2};
        PORT_NUMBER     = varargin{3};
        DEBUG           = 0;
        
    otherwise
        error('Invalid number of inputs');
end


%-----------------------CHECKING DATA FORMAT-------------------------------
% STR

% IP_ADDRESS

% PORT_NUMBER

% DEBUG


%-------------------------BEGIN CALCULATIONS-------------------------------
%Setup a UDP port

if(DEBUG)
    disp(['Setting up udpsocket on port #',num2str(PORT_NUMBER),' ...'])
end
udp=pnet('udpsocket',PORT_NUMBER);

if udp~=-1
    if(DEBUG)
        disp('   Success');
        disp(' ')
    end
    
    try
        %Write to the write buffer
        pnet(udp,'write',STR);
        
        %send data in the write buffer as a UDP packet        
        if(DEBUG)
            disp('Sending data over UDP...')
        end
        
        pnet(udp,'writepacket',IP_ADDRESS,PORT_NUMBER);
        
        if(DEBUG)
            disp('   Success');
            disp(' ')
        end
    catch exception
        if(DEBUG)
            disp(['   FAIL!!! ',exception.message])
            disp(' ')
        end
        throw(exception)
    end
    
    %Close the UDP connection
    if(DEBUG)
        disp('Closing UDP socket...')
    end
    
    pnet(udp,'close');
    
    if(DEBUG)
        disp('   Success');
        disp(' ')
    end
    
else
    error('Could not setup the UDP port')
end