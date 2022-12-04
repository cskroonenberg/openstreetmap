function [adjacency_list, nodes, ways] = arr_2_json(arr, arr_name, json_filename)
%EXTRACT_ADJACENCY_LIST Parse OSM file to extract adjacency list containing node connections

    for y=1:size(arr)
        fid=fopen(json_filename,'w');
        s = struct(arr_name, arr); 
        encoded = jsonencode(s); 
        fprintf(fid, encoded); 
        fclose(fid);
    end

end