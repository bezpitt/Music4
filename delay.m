function [output]=delay(constants,inSound,depth,delay_time,feedback)
    %DELAY applies a delay effect to inSound which is delayed by delay_time 
    % then added to the original signal according to depth and passed back as
    % feedback with the feedback gain specified
    L = length(inSound);
    samplenum = delay_time*constants.fs;%Amount of samples
    padded_back = [inSound; zeros(samplenum,1)];%Pad back with zeros so all right lengths
    
    echo = zeros(L+samplenum,1);%Preallocate for speed
    in = zeros(L+samplenum,1);
    for k = 1:L
        in(k) = inSound(k) + feedback*echo(k);%input signal + old feedback
        echo(k+samplenum) = in(k);%Echo references a delayed "In"  
    end
    output = padded_back + depth*echo;%Add echo and padded signal
end