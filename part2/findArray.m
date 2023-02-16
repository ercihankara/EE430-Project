% Ercihan Kara / 2375160
function [start, finish] = findArray(main_arr, sub_arr)
    start = strfind(main_arr, sub_arr);
    if isempty(start)
        start = -1;
        finish = -1;
    else
        finish = start + length(sub_arr) - 1;
    end
end