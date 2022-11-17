car = [-0.25 -0.5; 0.25 -0.5; 0.5 -0.25; 0.5 0.25;
       0.25 0.5; -0.25 0.5; -0.5 0.25; -0.5 -0.25] ; 
% track 
th = linspace(0,2*pi) ;
y = 3*sin(th) ; 
% move the object 
for i = 1:length(th)
  P = car+[th(i) y(i)] ;
  patch(P(:,1),P(:,2),'r');
  drawnow
end