% clc
clear all   % clear all variables
global x1d x2d ii % does not work when not inits

% [filename1, pathname1] = uigetfile('*.bmp','Choose file 1');
% [filename2, pathname2] = uigetfile('*.bmp','Choose file 2');

[filename1,filename2, pathname2]=deal('hw03image10.bmp','hw03image20.bmp','E:\zfall2013\13 09\repivcode\');
pathname1=pathname2;
[x1,map]=imread(fullfile(pathname1,filename1));
[x2,map]=imread(fullfile(pathname2,filename2));
%they can be used for calculations
x1d=double(x1);
x2d=double(x2);
ii=0;

%%
minx=-31;miny=-31;
[maxx,maxy]=deal(32);
options = gaoptions([]);
wlb = [-31 -31];
wub = [32 32];	
bits =[6 6];	
t=tic;
[x,f_best,stats,f_eval,fgen,lgen,lfit,n_gen,xval]= GA550('gafunc',[ ],options,wlb,wub,bits);
toc(t)
x
f_best
f_eval
n_gen

[val,x]=gafunc(x,f_best);
toc(t)
x

% [mpeaksub,npeaksub]=peaksub(x(1),x(2),minx,miny,'Phi',gafunc(x));

%% plot mqd and daMovie
mqd=zeros(maxx-minx,maxy-miny);
for m=minx:maxx
	for n=miny:maxy
		mqd(m-minx+1,n-miny+1)=sum(sum((x1d(96:159,96:159)-x2d(96+m:159+m,96+n:159+n)).^2));
	end
end
% 
% movit(xval,mqd);

