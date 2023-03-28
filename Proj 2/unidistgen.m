%Generates Random variables with a uniform distribution in the given range

function[out_dist] = unidistgen(bounds, rowparam, columnparam)
    out_dist = min(bounds, [], 'all') + (max(bounds, [], "all")-min(bounds, [], 'all'))*rand(rowparam, columnparam);
end