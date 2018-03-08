function t=tictoc(func,n)
tic
for ii=1:n
	func();
end
t = toc;
toc