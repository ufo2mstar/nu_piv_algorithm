%DaKyu :)
clear all;clc;

n=16;
x=linspace(0,2*pi,n+1);
y=x;
u_init=sin(x)'*cos(y);
h=x(2)-x(1);

%i;ll
u=u_init;                       % Assign u_init from initialized u
u_gs=zeros(n+1,n+1);		% Initialize GS matrix

% BCs
u_gs(1,:)=0;			% f3 left
u_gs(n+1,:)=0;		% f4 right
u_gs(:,1)=-sin(x)/2;		% f1 bottom
u_gs(:,n+1)=-sin(x)/2;	% f2 top
l2=zeros(1,n+1);

itr=0
ind=[];

% Gauss Seidel process
% while ((norm>1e-5)&&(itr<100))
while (itr<100)
    for (i=2:n)
        for (j=2:n)
            u_gs(i,j)=(((u_gs(i-1,j)+u(i+1,j)+u_gs(i,j-1)+u(i,j+1)))-((h^2)*u_init(i,j)))/4;
        end
    end
    itr=itr+1;
%     surf(u_gs)
%        norm=sqrt(sum((u_gs-u)^2));
    norm = sqrt(sum((u_gs-u)^2))/sqrt(sum(u_gs^2));
%     l2(itr)=norm;
    ind(itr)=itr;
    u=u_gs;
    if(norm<1e-5)break
    end
%     fprintf('i=%d ,  norm = %f\n',itr,norm)
    % Exit conditions
    surf(x,x,u_gs);
axis([0,2*pi,0,2*pi,-1,1])
    M(itr+1)=getframe;
end
u_exac=-(sin(x)'*cos(y))/2;
figure
surf(x,x,u_gs)
axis([0,2*pi,0,2*pi,-1,1])
figure
surf(x,x,u_exac)
 axis([0,2*pi,0,2*pi,-1,1])
figure
surf(u_gs-u_exac)
%  axis([0,2*pi,0,2*pi,-1,1])

movie(M,2,10);
movie2avi(M, 'gs_solution.avi', 'compression', 'none');

if (norm<1e-5)
    fprintf('GS Succ. convg at i=%d , norm= %f',itr, norm)
elseif (itr>500)
    fprintf('Max iter reached i= %d',itr)
end