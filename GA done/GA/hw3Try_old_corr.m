% clc
clear all   % clear all variables
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

sprintf('Correlation CPU time: %10.5f sec',toc(t))    % record stop time
figure(3)
subplot(121),mesh(xmesh',ymesh',phi)                        % plot results
axis([minx maxx miny maxy min(min(phi)) max(max(phi))])
title('Correlation')
xlabel('m offset')
ylabel('n offset')

% t=tic;
% mqd=zeros(maxx-minx,maxy-miny);
% for m=minx:maxx
% 	for n=miny:maxy
% 		mqd(m-minx+1,n-miny+1)=sum(sum(x1d(96:159,96:159)-x2d(96+m:159+m,96+n:159+n)).^2);
% 	end
% end
% 
% sprintf('MqD CPU time: %10.5f sec',toc(t))    % record stop time
% % figure(3)
% subplot(122),mesh(xmesh',ymesh',phi)                        % plot results
% axis([minx maxx miny maxy min(min(phi)) max(max(mqd))])
% title('MqD')
% xlabel('m offset')
% ylabel('n offset')


% find correlation peak locations
[mpeakint,npeakint]=find(max(max(phi))==phi);
mpeaksub=(log(phi(mpeakint+1,npeakint))-log(phi(mpeakint-1,npeakint)))...
    /(-2*log(phi(mpeakint-1,npeakint))+4*log(phi(mpeakint-0,npeakint))...
    -2*log(phi(mpeakint+1,npeakint)))+mpeakint+minx-1
npeaksub=(log(phi(mpeakint,npeakint+1))-log(phi(mpeakint,npeakint-1)))...
    /(-2*log(phi(mpeakint,npeakint-1))+4*log(phi(mpeakint,npeakint-0))...
    -2*log(phi(mpeakint,npeakint+1)))+npeakint+miny-1
% % find mqd peak locations
% [mpeakint,npeakint]=find(min(min(mqd))==mqd);
% mpeaksub=(log(mqd(mpeakint+1,npeakint))-log(mqd(mpeakint-1,npeakint)))...
%     /(-2*log(mqd(mpeakint-1,npeakint))+4*log(mqd(mpeakint-0,npeakint))...
%     -2*log(mqd(mpeakint+1,npeakint)))+mpeakint+minx-1
% npeaksub=(log(mqd(mpeakint,npeakint+1))-log(mqd(mpeakint,npeakint-1)))...
%     /(-2*log(mqd(mpeakint,npeakint-1))+4*log(mqd(mpeakint,npeakint-0))...
%     -2*log(mqd(mpeakint,npeakint+1)))+npeakint+miny-1