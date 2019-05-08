function [output] = tremolo(constants,inSound,LFO_type,LFO_rate,lag,depth)
%TREMOLO applies a stereo tremelo effect to inSound by multiplying the
%signal by a low frequency oscillator specified by LFO_type and LFO_rate. 
% depth determines the prevalence of the tremeloed signal in the output,
% and lag determines the delay between the left and right tracks. 

L = length(inSound);
timeVec = 0:1/constants.fs:(L-1)/constants.fs;
if strcmpi(LFO_type, 'sin')
	modulator = depth * sin(2 * pi * LFO_rate * (lag + timeVec)).';
elseif strcmpi(LFO_type, 'triangle')
	modulator = depth * sawtooth(2 * pi * LFO_rate * (lag + timeVec), 0.9).';
elseif strcmpi(LFO_type, 'square')
	modulator = depth * square(2 * pi * LFO_rate * (lag + timeVec) ).';
end
output = modulator .* inSound;
end
