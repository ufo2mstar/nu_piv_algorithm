function a=movit(xval,mqd)
check=1;
M=size(xval,1);
[xmesh,ymesh]=meshgrid(-31:32,-31:32);
if nargin>1
	mesh(xmesh',ymesh',mqd)                        % plot results
	axis([minx maxx miny maxy min(min(mqd)) max(max(mqd))])
	title('MqD')
	xlabel('m offset')
	ylabel('n offset')
	view([0 90])
end

%% 2d 
if nargin==1
mesh(xmesh',ymesh',zeros(size(xmesh)))
axis([-31 32 -31 32])
title('Population Distribution')
	xlabel('m offset')
	ylabel('n offset')
view([0 90])
end

%% png grab


n=size(xval,1)/xval(end,1);itr=0;
while (check<xval(end,1)+1)
	itr=itr+1;
	f=figure();
	 scatter(xval((itr-1)*n+1:(itr+1)*n,2),xval((itr-1)*n+1:(itr+1)*n,3));
	 axis([-31 32 -31 32]);
	 str=strcat('image',num2str(itr),'.png');
saveas(f,str);
end


%% movie
	set(gca,'NextPlot','replaceChildren');
% Preallocate the struct array for the struct returned by getframe
M(xval(end,1)) = struct('cdata',[],'colormap',[]);
% Record the movie

n=size(xval,1)/xval(end,1);itr=0;
while (check<xval(end,1)+1)
	itr=itr+1;
% 	i=itr*n
% 	 scatter(xval((itr-1)*n+1:(itr+1)*n,2),xval((itr-1)*n+1:(itr+1)*n,3),'DisplayName','xval(:,2) vs. xval(:,1)','YDataSource','xval(:,2)');
	 scatter(xval((itr-1)*n+1:(itr+1)*n,2),xval((itr-1)*n+1:(itr+1)*n,3));
	 axis([-31 32 -31 32])
% 	 figure(gcf)
% 	scatter3(xval(1:48,2),xval(1:48,3),xval(1:48,4),'DisplayName','xval');figure(gcf)
	% 	axis([0,2*pi,0,2*pi,-1,1])

% 	M(itr)=getframe;
% 	check=xval(itr*n+1);
end

% movie(M,2,10);
% movie2avi(M, 'ga_convg.avi', 'compression', 'none');
a=1;
end