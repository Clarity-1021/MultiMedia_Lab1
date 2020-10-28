function [a_quan]=ula_pcm(a,n,u)
%ULA_PCM 	u-law PCM encoding of a sequence
%       	[A_QUAN]=MULA_PCM(X,N,U).
%       	X=input sequence.
%       	n=number of quantization levels (even).     	
%		a_quan=quantized output before encoding.
%       U the parameter of the u-law

    a_quan = ulaw(abs(a), u); % 对正向化后的输入进行u率非线性变换
    a_quan = u_pcm(a_quan, n); % 对非线性变换的结果进行均匀量化
    % 把均匀量化的结果通过u率的反函数变换回输入的量化结果，并把符号还给它
    a_quan = inv_ulaw(a_quan, u) .* sign(a); 
    
end