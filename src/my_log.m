function [result]=my_log(x)
    if abs(x) <= 1
        result = 0;
    else
        result = fix(log2(abs(x)));
    end
end