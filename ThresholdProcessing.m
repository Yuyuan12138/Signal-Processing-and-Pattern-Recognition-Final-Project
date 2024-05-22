function y = ThresholdProcessing(A,t,a )
tmp=abs(A)-a*t;
tnp=abs(A)>=t;
y=(sign(A).*tmp).*tnp;
end
