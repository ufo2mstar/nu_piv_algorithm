function [mpeaksub,npeaksub]=peaksub(mpeakint,npeakint,minx,miny,name,func)
mpeaksub=(log(func(mpeakint+1,npeakint))-log(func(mpeakint-1,npeakint)))...
    /(-2*log(func(mpeakint-1,npeakint))+4*log(func(mpeakint-0,npeakint))-2*log(func(mpeakint+1,npeakint)))+mpeakint+minx-1;
npeaksub=(log(func(mpeakint,npeakint+1))-log(func(mpeakint,npeakint-1)))...
    /(-2*log(func(mpeakint,npeakint-1))+4*log(func(mpeakint,npeakint-0))-2*log(func(mpeakint,npeakint+1)))+npeakint+miny-1;
disp(name)
str=sprintf('-------> M peak= %f , N peak= %f ',mpeaksub,npeaksub);
disp(str)
end