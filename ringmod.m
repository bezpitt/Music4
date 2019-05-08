function [output] = ringmod(constants,inSound,inputFreq,depth)
%RINGMOD applies ring modulator effect to inSound

L = length(inSound);
modulator = depth*sin(2*pi*inputFreq*(0:1/constants.fs:(L-1)/constants.fs) ).';
output = modulator.*inSound;
%It sounds kind of ass but that jusy makes it more HEAVY
end