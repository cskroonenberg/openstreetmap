C = {1, 2, 3};

if find([[C{:}] == 1])
    disp('success');
else
    disp('failure');
end

if find([[C{:}] == 4])
    disp('success');
else
    disp('failure');
end