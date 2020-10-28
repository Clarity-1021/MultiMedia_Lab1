function x=inv_ulaw(y,u)
%INV_ULAW		the inverse of u-law nonlinearity
%X=INV_ULAW(Y,U)	X=normalized output of the u-law nonlinearity.

	% u率反函数公式
    m = (1 + u) .^ y;
    x = (m - 1) / u;
    
end