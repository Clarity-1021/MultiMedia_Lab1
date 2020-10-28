function [z]=ulaw(y,u)
%		u-law nonlinearity for nonuniform PCM
%		X=ULAW(Y,U).
%		Y=input vector.

    % u率公式
    z = (log(1 + u * y) / log(1 + u));

end