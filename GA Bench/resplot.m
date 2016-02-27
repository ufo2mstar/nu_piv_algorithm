function resplot(phi,mqd)
global no
%% png grab
hold off

minx=-31;miny=-31;
[maxx,maxy]=deal(32);
[xmesh,ymesh]=meshgrid(minx:maxx,miny:maxy);

f=figure(1);
% subplot(121),mesh(xmesh',ymesh',phi)
% axis([minx maxx miny maxy min(min(phi)) max(max(phi))])
% title('Correlation')
% xlabel('m offset')
% ylabel('n offset')
% view([0,90])

% figure(3)
subplot(121),mesh(xmesh',ymesh',mqd)
axis([minx maxx miny maxy min(min(mqd)) max(max(mqd))])
title('MqD')
xlabel('m offset')
ylabel('n offset')
view([0,0])

subplot(122),mesh(xmesh',ymesh',mqd)
axis([minx maxx miny maxy min(min(mqd)) max(max(mqd))])
title('MqD')
xlabel('m offset')
ylabel('n offset')
view([90,0])



% contour(-31:32,-31:32,mqd'); axis('equal')
% title('MqD : GA Convg')
% xlabel('m offset')
% ylabel('n offset')
% view([0 90])
% hold on
% i=(itr-1)*n+1;
% scatter(xval(i:i+n-1,2),xval(i:i+n-1,3),'b','*');
% axis([-31 32 -31 32]);axis('equal');
str=strcat('image',num2str(no),'.png');
saveas(f,str);no=no+1;
end
