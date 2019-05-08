function [soundOut]=flanger(constants,inSound,depth,delay,width,LFO_Rate)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%    [soundOut]=flanger(constants,inSound,depth,delay,width,LFO_Rate)
%
% This function creates the sound output from the flanger effect
%
% OUTPUTS
%   soundOut = The output sound vector
%
% INPUTS
%   constants   = the constants structure
%   inSound     = The input audio vector
%   depth       = depth setting in seconds
%   delay       = minimum time delay in seconds
%   width       = total variation of the time delay from the minimum to the maximum
%   LFO_Rate    = The frequency of the Low Frequency oscillator in Hz
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Flanger is chorus when set to relatively higher delay values
 L = length(inSound);
 timeVec = (1:L)/constants.fs;%Needed to calculate LFO
 LFO = .5*width*sawtooth(2*pi*LFO_Rate*timeVec,.8);%Triangle sounds better I think but you could use sine or play around with the balance on the triangles
 offset = delay + .5*width;%This moves the LFO to the right place
 total_delay = offset + LFO;%This is in seconds
 sample_delay = round(total_delay * constants.fs);%Converts from seconds to samples and rounds to integers
 Max = max(sample_delay);%Neccessary to start high enough that you have previous stuff to delay to
in = zeros(L,1);%Preallocating for speed
 for k = Max:L-1
     in(k) = inSound(k-sample_delay(k)+1 );%Generates a signal delayed by the sampledelay at that point. The +1 is there bc matlab indexes at 0
 end
 soundOut = depth*in + inSound;%Adds delayed sound to sound
end