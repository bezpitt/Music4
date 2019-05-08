function [output]=distortion(constants,inSound,gain,tone)
%DISTORTION applies the specified gain to inSound, then applies clipping
%according to internal parameters and filtering according to the specified
%tone parameter
    Thresh = 1.7;%Make this higher to make less distorted
    range = .5;%How wide the badn of the badnpass filter is
    In = gain*inSound;
    Log = (In < Thresh) & (In > -1*Thresh);%Threshhold chops on both sides you could just chop on one
    chopped = In .* Log;%makes values beyond threshhold zero, while leaving the others unchanged
    scale = tone*(1-range);%Keeps filter between 0 and pi radians
    [b,a] = cheby2(4,10,[scale scale+range],'bandpass');%Makes bandpass cheby of .2 radians width that shifts based on tone
    %You don't have to use cheby
    output = filter(b,a,chopped);
end