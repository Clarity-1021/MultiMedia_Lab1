function [a_quan]=u_pcm(a,n)
%U_PCM  	uniform PCM encoding of a sequence
%       	[A_QUAN]=U_PCM(A,N)
%       	a=input sequence.
%       	n=number of quantization levels (even).
%		a_quan=quantized output before encoding.

    up_bound = 1; %上界
    bottom_bound = -1; %下界
    arrange = up_bound - bottom_bound; %范围
    delta = arrange / n; % 量化间隔，每一个都一样
    % 对输入取正向化后的量化输出等级，向上取整，需要再减去0.5个delta
    a_quan = ceil(abs(a) / delta) * delta - 0.5 * delta;
    % 把输入的符号乘回去
    a_quan = a_quan .* sign(a);

end
