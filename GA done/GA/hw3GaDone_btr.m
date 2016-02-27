% clc
clear all   % clear all variables
global x1d x2d

% [filename1, pathname1] = uigetfile('*.bmp','Choose file 1');
% [filename2, pathname2] = uigetfile('*.bmp','Choose file 2');

[filename1,filename2, pathname2]=deal('hw03image10.bmp','hw03image20.bmp','E:\zfall2013\13 09\repivcode\');
pathname1=pathname2;
[x1,map]=imread(fullfile(pathname1,filename1));
[x2,map]=imread(fullfile(pathname2,filename2));
%they can be used for calculations
x1d=double(x1);
x2d=double(x2);

%%
minx=-31;miny=-31;
[maxx,maxy]=deal(32);
options = gaoptions([]);
wlb = [-31 -31];
wub = [32 32];	
bits =[6 6];	
tic;
[x,f_best,stats,f_eval,fgen,lgen,lfit,n_gen]= GA550('gafunc',[ ],options,wlb,wub,bits);
toc
x
f_best
f_eval
n_gen

[val,x]=gafunc(x,f_best)

% [mpeaksub,npeaksub]=peaksub(x(1),x(2),minx,miny,'Phi',gafunc(x));

