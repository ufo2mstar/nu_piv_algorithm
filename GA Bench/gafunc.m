function [val,x]=gafunc(x,minval)
global x1d x2d a b
% val=-sum(dot(x1d(96:159,96:159),x2d(96+x(1):159+x(1),96+x(2):159+x(2))));

% for 6 bits
val=sum(sum((x1d(a:b,a:b)-x2d(a+x(1):b+x(1),a+x(2):b+x(2))).^2));
x
% for 12 bits
% val=sum(sum((x1d(a:b,a:b)-x2d(a+floor(x(1)/2):b+floor(x(1)/2),a+floor(x(2)/2):b+floor(x(2)/2))).^2));
% val=sum(sum((x1d(a:b,a:b)-x2d(a+floor(x(1)/2):b+floor(x(1)/2),a+floor(x(2)/2):b+floor(x(2)/2))).^2));


% if (nargin>1)
% 	i=i+1
% 	xval(gen,i)=[x,val]
% end
mqd=zeros(5,5);
while (nargin>1)
	for m=-2:2
		for n=-2:2
			mqd(m+3,n+3)=sum(sum((x1d(a:b,a:b)...
				-x2d(a+x(1)+m:b+x(1)+m,a+x(2)+n:b+x(2)+n)).^2));
% 				-x2d(a+floor(x(1)/2)+m:b+floor(x(1)/2)+m,a+floor(x(2)/2)+n:b+floor(x(2)/2)+n)).^2));
							
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