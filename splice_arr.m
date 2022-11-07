function [arr] = splice_arr(arr, value, idx)
%SPLICE_ARR Return an array with the value param inserted into index idx
	%a = [1,2,4,5];
    %b = [a(1:2) 3 a(3:end)];
    arr = [arr(1:idx), value, arr(idx+1:end)];
end