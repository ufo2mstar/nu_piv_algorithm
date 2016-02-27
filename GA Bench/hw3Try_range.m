clc
clear all   % clear all variables
global x1d x2d no
no=1;
% [filename1, pathname1] = uigetfile('*.bmp','Choose file 1');
% [filename2, pathname2] = uigetfile('*.bmp','Choose file 2');

[filename1,filename2, pathname2]=deal('hw03image10.bmp','hw03image20.bmp','E:\zfall2013\13 09\repivcode\');
pathname1=pathname2;
[x1,map]=imread(fullfile(pathname1,filename1));
[x2,map]=imread(fullfile(pathname2,filename2));
%they can be used for calculations
x1d=double(x1);
x2d=double(x2);
% sample wire mesh plot command
% figure(1)
% subplot(121),mesh(x1d(96:159,96:159))
% hold on
% subplot(122),mesh(x2d(96:159,96:159))
% % command to display the images
% figure(2)
% subplot(121),image(x1)
% colormap(gray(256))
% axis('equal')
% axis('off')
% hold on
% subplot(122),image(x2)
% colormap(gray(256))
% axis('equal')
% axis('off')
%%
% options = gaoptions([]);
% wlb = [-31 -31];	%Lower bound of each gene - all variables
% wub = [32 32];	%Upper bound of each gene - all variables
% bits =[6 6];	%number of bits describing each gene - all variables
% tic;
% [x,fbest,stats,nfit,fgen,lgen,lfit]= GA550('gaTest',[ ],options,wlb,wub,bits);
% toc
% [mpeaksub,npeaksub]=peaksub(mpeakint,npeakint,minx,miny,'Phi',phi);

%% iteration
tableCorr=zeros(25,9);
tableMQD=tableCorr;
itr=0;
for i=1:5
	for j=1:5
		a=31+i;b=a+63;
%% Correlation
minx=-31;miny=-31;
[maxx,maxy]=deal(32);
t=tic;
phi=zeros(maxx-minx,maxy-miny);
[xmesh,ymesh]=meshgrid(minx:maxx,miny:maxy);

for m=minx:maxx
	for n=miny:maxy
		phi(m-minx+1,n-miny+1)=sum(dot(x1d(a:b,a:b),x2d(a+m:b+m,a+n:b+n)));
	end
end
% disp(sprintf('Correlation CPU time: %10.5f sec',toc(t)))
[xin,yin]=find(max(max(phi))==phi);
[x,y]=peaksub(xin,yin,minx,miny,'Phi',phi);
%% table
itr=itr+1
tableCorr (itr,:)=[itr,i,j,xin-32,yin-32,max(max(phi)),x,y,toc(t)];

%% MQD
t=tic;
mqd=zeros(maxx-minx,maxy-miny);
for m=minx:maxx
	for n=miny:maxy
		mqd(m-minx+1,n-miny+1)=sum(sum((x1d(a:b,a:b)-x2d(a+m:b+m,a+n:b+n)).^2));
	end
end
% disp(sprintf('MqD CPU time: %10.5f sec',toc(t)))
[xin,yin]=find(min(min(mqd))==mqd);
[x,y]=peaksub(xin,yin,minx,miny,'MqD',mqd);
%% table 
tableMQD(itr,:)=[itr,i,j,xin-32,yin-32,max(max(mqd)),x,y,toc(t)];
%% iteration end
resplot(phi,mqd);
	end
end

%% Disp Both
figure(3)
subplot(121),mesh(xmesh',ymesh',phi)
axis([minx maxx miny maxy min(min(phi)) max(max(phi))])
title('Correlation')
xlabel('m offset')
ylabel('n offset')
view([0,90])

% figure(3)
subplot(122),mesh(xmesh',ymesh',mqd)
axis([minx maxx miny maxy min(min(mqd)) max(max(mqd))])
title('MqD')
xlabel('m offset')
ylabel('n offset')
view([0,90])

%% Find Peaks - 3pt gaussian
% find correlation peak locations
[mpeakint,npeakint]=find(max(max(phi))==phi);
[mpeaksub,npeaksub]=peaksub(mpeakint,npeakint,minx,miny,'Phi',phi);
% find mqd peak locations
[mpeakint,npeakint]=find(min(min(mqd))==mqd);
[mpeaksub,npeaksub]=peaksub(mpeakint,npeakint,minx,miny,'MqD',mqd);