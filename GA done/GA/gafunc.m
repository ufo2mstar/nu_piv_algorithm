function [val,x]=gafunc(x,minval)
global x1d x2d
% val=-sum(dot(x1d(96:159,96:159),x2d(96+x(1):159+x(1),96+x(2):159+x(2))));
val=sum(sum((x1d(96:159,96:159)-x2d(96+x(1):159+x(1),96+x(2):159+x(2))).^2));

% if (nargin>1)
% 	i=i+1
% 	xval(gen,i)=[x,val]
% end

while (nargin>1)
	for m=-2:2
		for n=-2:2
			mqd(m+3,n+3)=sum(sum((x1d(96:159,96:159)...
				-x2d(96+x(1)+m:159+x(1)+m,96+x(2)+n:159+x(2)+n)).^2));
		end
	end
		[m,n]=find(min(min(mqd))==mqd);
		x=[x(1)+m-3,x(2)+n-3];
	if min(min(mqd))==minval
		val=minval;
		break
	else
		minval=min(min(mqd));
	end
end
end