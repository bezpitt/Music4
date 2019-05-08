function [soundOut,gain] = compressor(constants, inSound, threshold, slope, attack, avg_len)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%    [soundOut,gain] = compressor(constants,inSound,threshold,attack,avg_len)
%
%COMPRESSOR applies variable gain to the inSound vector by limiting the
% level of any audio sample of avg_length with rms power greater than
% threshold according to slope
%
% OUTPUTS
%   soundOut    = The soundOut sound vector
%   gain        = The vector of gain applied to inSound to create soundOut
%
% INPUTS
%   constants   = the constants structure
%   inSound     = The input audio vector
%   threshold   = The level setting to switch between the two gain settings
%   slope       = The ratio of input to gain to apply to the signal past
%   the threshold
%   attack      = time over which the gain changes
%   avg_len     = amount of time to average over for the power measurement

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Setup
L = length(inSound);
avg_bins = round(constants.fs * avg_len * 10^(-6));
gain = ones(L, 1);%Gain will remain 1 if below the threshold

for k = 1:L
    start = max(k-avg_bins, 1);
    current_Power = rms(inSound(start:k));
    if current_Power > threshold
        current_Gain = max(0, 1 - slope*(current_Power - threshold));
        gain(start:k+attack*constants.fs) = current_Gain * gain(start:k+attack*constants.fs);
    end
end
soundOut = gain.*inSound;

end