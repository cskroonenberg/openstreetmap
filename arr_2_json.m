function [adjacency_list, nodes, ways] = arr_2_json(arr, arr_name, json_name)
%EXTRACT_ADJACENCY_LIST Parse OSM file to extract adjacency list containing node connections

    for y=1:size(arr)
        current_dir = '/home/c699k482/eecs581/openstreetmap'; %TODO: Find path with pwd 
        filename= sprintf('%s/%s.json', current_dir, json_name);

        fid=fopen(filename,'w');
        s = struct(arr_name, arr); 
        encoded = jsonencode(s); 
        fprintf(fid, encoded); 
        fclose(fid);
    end

end