function [a_quan]=u_pcm(a,n)
%U_PCM  	uniform PCM encoding of a sequence
%       	[A_QUAN]=U_PCM(A,N)
%       	a=input sequence.
%       	n=number of quantization levels (even).
%		a_quan=quantized output before encoding.

% todo: 
    up_bound = 1; %上界
    bottom_bound = -1; %下界
    arrange = up_bound - bottom_bound; %范围
    delta = arrange / n; % 量化区间长度，每一个都一样
    a_quan = ceil(a / delta) * delta;

end
