function [a_quan]=ula_pcm(a,n,u)
%ULA_PCM 	u-law PCM encoding of a sequence
%       	[A_QUAN]=MULA_PCM(X,N,U).
%       	X=input sequence.
%       	n=number of quantization levels (even).     	
%		a_quan=quantized output before encoding.
%       U the parameter of the u-law

% todo:
    b = a * u;
    a_quan = zeros(size(a));
    len = size(a, 2);
    n = n / 16;
    for i = 1:len
        level = fix(my_log(b(1, i)));
        sum = 2 ^ (level);
        delta = sum / n;
        k = abs(b(1, i)) + 1 - sum;
        k = ceil(k / delta) * (1/8) * (1/n);
        a_quan(1, i) = (level * (1/8) + k) * sign(b(1, i));
    end
    
end