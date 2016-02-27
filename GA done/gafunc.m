function val=gafunc(x,m,n)
global x1d x2d
% val=-sum(dot(x1d(96:159,96:159),x2d(96+x(1):159+x(1),96+x(2):159+x(2))));

val=sum(sum((x1d(96:159,96:159)-x2d(96+x(1):159+x(1),96+x(2):159+x(2))).^2));

if (nargin>1)
	for m=minx:maxx
		for n=miny:maxy
			mqd(m-minx+1,n-miny+1)=sum(sum((x1d(96:159,96:159)-x2d(96+m:159+m,96+n:159+n)).^2));
		end
	end
end