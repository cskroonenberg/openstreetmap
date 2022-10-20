function [adjacency_list] = extract_adjacency_list(parsed_osm)
%EXTRACT_ADJACENCY_LIST Parse OSM file to extract adjacency list containing node connections

[~, node, way, ~] = assign_from_parsed(parsed_osm);

% TODO: Could futher parse to only handle relevant nodes
ways_num = size(way.id, 2);
nodes_num = size(node.id, 2);
ways_node_sets = way.nd;

disp(node.id(1, 1));

adjacency_list = {};

% Map node ids to i=1...n values for adjacency list indices
keySet = 1:nodes_num;
%valueSet = node.id

M = containers.Map(keySet, node.id);

disp('M(1):');
disp(M(1));

disp('M(2):');
disp(M(2));


for i=1:nodes_num
	node_id = M(i); 
	% add edges from node at node_id to adjacency_list{i}
	% a{i} = [{[ID,edge_weight], [ID2,edge_weight2]}];
	% adjacency_list{i} = [{}];
end

for i=1:ways_num
	nodeset = ways_node_sets{1, curway};
	for i=1:nodes_num-1
        a = nodeset{1, i}
        b = nodeset{1, i+1}
        % calculate dist from a to b
        % connect a to b
    end
end

% edges connected to node_ID X:
% adjacency_list{M(X)}

end % extract_adjacency_list