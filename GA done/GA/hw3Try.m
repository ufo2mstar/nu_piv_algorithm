clc
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

%% Correlation
minx=-31;miny=-31;
[maxx,maxy]=deal(32);
t=tic;
phi=zeros(maxx-minx,maxy-miny);
[xmesh,ymesh]=meshgrid(minx:maxx,miny:maxy);

for m=minx:maxx
	for n=miny:maxy
		phi(m-minx+1,n-miny+1)=sum(dot(x1d(96:159,96:159),x2d(96+m:159+m,96+n:159+n)));
% 		phi(m,n)=sum(sum(dot(x1d(96:159,96:159),x1d(96:159,96:159))));
	end
end
disp(sprintf('Correlation CPU time: %10.5f sec',toc(t)))    % record stop time

%% MQD
t=tic;
mqd=zeros(maxx-minx,maxy-miny);
for m=minx:maxx
	for n=miny:maxy
		mqd(m-minx+1,n-miny+1)=sum(sum((x1d(96:159,96:159)-x2d(96+m:159+m,96+n:159+n)).^2));
	end
end

%% Disp Both
figure(3)
subplot(121),mesh(xmesh',ymesh',phi)                        % plot results
axis([minx maxx miny maxy min(min(phi)) max(max(phi))])
title('Correlation')
xlabel('m offset')
ylabel('n offset')
view([0,90])
disp(sprintf('MqD CPU time: %10.5f sec',toc(t)))    % record stop time
% figure(3)
subplot(122),mesh(xmesh',ymesh',mqd)                        % plot results
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