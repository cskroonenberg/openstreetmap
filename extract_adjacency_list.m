function [adjacency_list] = extract_adjacency_list(parsed_osm)
%EXTRACT_ADJACENCY_LIST Parse OSM file to extract adjacency list containing node connections
	%disp('extract_adjacency_list');

	% TODO: Could futher parse to only handle relevant nodes
	[~, nodes, ways, ~] = assign_from_parsed(parsed_osm);

	n = size(nodes.id, 2);
	adjacency_list = cell(1, n);

	golf_ways = []; % Golf cart ways with nodes added in 1...n order
	golf_ways = [golf_ways, 772145420]; % Start
	golf_ways = [golf_ways, 773682303]; % Hole 1
	golf_ways = [golf_ways, 783638177]; % Hole 2, 3
	golf_ways = [golf_ways, 867486266]; % Bridge
	golf_ways = [golf_ways, 777884654]; % Loop 2
	golf_ways = [golf_ways, 777884652]; % Loop 3
	golf_ways = [golf_ways, 867486264]; % Loop 4
	golf_ways = [golf_ways, 772700736]; % Hole 4
	golf_ways = [golf_ways, 772737413]; % Hole 5
	golf_ways = [golf_ways, 775243251]; % Hole 6
	golf_ways = [golf_ways, 773154737]; % Practice Green
	golf_ways = [golf_ways, 773166141]; % Hole 7, 8, 9

	rev_golf_ways = []; % Golf cart ways with nodes added in n...1 order
	rev_golf_ways = [rev_golf_ways, 867486266]; % Bridge
	rev_golf_ways = [rev_golf_ways, 867486263]; % Loop 1

	for w_id=golf_ways
		adjacency_list = connect_way(w_id, parsed_osm, adjacency_list, false);
	end

	for w_id=rev_golf_ways
		adjacency_list = connect_way(w_id, parsed_osm, adjacency_list, true);
	end

	% Connect Start to Hole 1
	nd_1_id = way_end_nd_id(772145420, ways); % Final node of Start
	nd_1_idx = nd_id_2_idx(nd_1_id, nodes);

	nd_2_id = way_start_nd_id(773682303, ways); % First node of Hole 1
	nd_2_idx = nd_id_2_idx(nd_2_id, nodes);

	adjacency_list = add_edge(nd_1_idx, nd_2_idx, nodes, adjacency_list);

	% Connect Hole 1 to Hole 2, 3
	nd_1_id = way_end_nd_id(773682303, ways); % Final node of Hole 1
	nd_1_idx = nd_id_2_idx(nd_1_id, nodes);

	nd_2_id = way_start_nd_id(783638177, ways); % First node of Hole 2, 3
	nd_2_idx = nd_id_2_idx(nd_2_id, nodes);

	adjacency_list = add_edge(nd_1_idx, nd_2_idx, nodes, adjacency_list);

	% Connect Hole 2, 3 to Bridge
	% Hole 2, 3 Final Node = Bridge First Node

	% Connect Bridge to Loop 1
	nd_1_id = way_end_nd_id(867486266, ways); % Final node of Bridge
	nd_1_idx = nd_id_2_idx(nd_1_id, nodes);

	nd_2_id = way_end_nd_id(867486263, ways); % Final node of Loop 1 (Loop 1 nodes added in reverse order)
	nd_2_idx = nd_id_2_idx(nd_2_id, nodes);

	adjacency_list = add_edge(nd_1_idx, nd_2_idx, nodes, adjacency_list);

	% Connect Loop 1 to Loop 2
	% Loop 1 First Node = Loop 2 First Node

	% Connect Loop 2 to midpoint node to Loop 3
	nd_1_id = way_end_nd_id(777884654, ways); % Final node of Loop 2
	nd_1_idx = nd_id_2_idx(nd_1_id, nodes);

	mid_nd_id = 8085848420;
	mid_nd_idx = nd_id_2_idx(mid_nd_id, nodes);

	adjacency_list = add_edge(nd_1_idx, mid_nd_idx, nodes, adjacency_list);

	nd_2_id = way_start_nd_id(777884652, ways); % First node of Loop 3
	nd_2_idx = nd_id_2_idx(nd_2_id, nodes);

	adjacency_list = add_edge(mid_nd_idx, nd_2_idx, nodes, adjacency_list);

	% Connect Loop 3 to Loop 4
	% Loop 3 Final Node = Loop 4 First Node

	% Connect Loop 4 to Bridge
	nd_1_id = way_end_nd_id(867486264, ways); % Final node of Loop 4
	nd_1_idx = nd_id_2_idx(nd_1_id, nodes);

	nd_2_id = way_end_nd_id(867486266, ways); % Final node of Bridge (Going reverse order now)
	nd_2_idx = nd_id_2_idx(nd_2_id, nodes);

	adjacency_list = add_edge(nd_1_idx, nd_2_idx, nodes, adjacency_list);

	% Connect Bridge to Hole 4
	nd_1_id = way_start_nd_id(867486266, ways); % First node of Bridge
	nd_1_idx = nd_id_2_idx(nd_1_id, nodes);

	nd_2_id = way_start_nd_id(772700736, ways); % First node of Hole 4
	nd_2_idx = nd_id_2_idx(nd_2_id, nodes);

	adjacency_list = add_edge(nd_1_idx, nd_2_idx, nodes, adjacency_list);

	% Connect Hole 4 to Hole 5
	% Hole 4 Final Node = Hole 5 First Node

	% Connect Hole 5 to Hole 6
	nd_1_id = way_end_nd_id(772737413, ways); % Final node of Hole 5
	nd_1_idx = nd_id_2_idx(nd_1_id, nodes);

	nd_2_id = way_start_nd_id(775243251, ways); % First node of Hole 6
	nd_2_idx = nd_id_2_idx(nd_2_id, nodes);

	adjacency_list = add_edge(nd_1_idx, nd_2_idx, nodes, adjacency_list);

	% Connect Hole 6 to Practice Green
	nd_1_id = way_end_nd_id(775243251, ways); % Final node of Hole 6
	nd_1_idx = nd_id_2_idx(nd_1_id, nodes);

	nd_2_id = way_start_nd_id(773154737, ways); % First node of Practice Green
	nd_2_idx = nd_id_2_idx(nd_2_id, nodes);

	adjacency_list = add_edge(nd_1_idx, nd_2_idx, nodes, adjacency_list);

	% Connect Practice Green to Hole 7, 8, 9
	nd_1_id = way_end_nd_id(773154737, ways); % Final node of Practice Green
	nd_1_idx = nd_id_2_idx(nd_1_id, nodes);

	nd_2_id = way_start_nd_id(773166141, ways); % First node of Hole 7, 8, 9
	nd_2_idx = nd_id_2_idx(nd_2_id, nodes);

	adjacency_list = add_edge(nd_1_idx, nd_2_idx, nodes, adjacency_list);

end % extract_adjacency_list

function [adjacency_list] = connect_way(way_id, parsed_osm, adjacency_list, reverse)
%EXTRACT_ADJACENCY_LIST Add edges between a way's adjacent nodes to the adjacency list in 1...n order
	%disp('connect_way');
	ways = parsed_osm.way;
	nodes = parsed_osm.node;

	way_idx = way_id_2_idx(way_id, ways);
	way_nd_ids = ways.nd(way_idx);
	way_nd_ids = way_nd_ids{:};
    num_nd = size(way_nd_ids, 2);

    if reverse
    	nd_range = flip(2:num_nd);
    else
    	nd_range = 1:num_nd-1;
    end

	for i=nd_range
        nd_1_id = way_nd_ids(i);
        if reverse
        	nd_2_id = way_nd_ids(i-1);
        else
	        nd_2_id = way_nd_ids(i+1);
	    end

        nd_1_idx = nd_id_2_idx(nd_1_id, nodes);
        nd_2_idx = nd_id_2_idx(nd_2_id, nodes);
        adjacency_list = add_edge(nd_1_idx, nd_2_idx, nodes, adjacency_list);
    end
end % connect_way

function [adjacency_list] = add_edge(nd_1_idx, nd_2_idx, nodes, adjacency_list)
%ADD_EDGE Add a weighted edge from nd_1 to nd_2 in the adjacency list
	%disp('add_edge');
	if ~(nd_1_idx == nd_2_idx)
		[dist, d_x, d_y] = edge_weight(nd_1_idx, nd_2_idx, nodes);
		adjacency_list{nd_1_idx} = [adjacency_list{nd_1_idx}, {[nd_2_idx, dist, d_x, d_y]}];
	end
end % add_edge

%%%%% NODE FUNCTIONS %%%%%
function [nd_id] = nd_idx_2_id(nd_idx, nodes)
%ND_IDX_2_ID Return a nodes ID given its index
	%disp('nd_idx_2_id');
	nd_id = nodes.id(1, nd_idx);
end % nd_idx_2_id

function [nd_idx] = nd_id_2_idx(nd_id, nodes)
%ND_ID_2_IDX Return a nodes index given its 
	%disp('nd_id_2_idx');
	nd_idx = find(nodes.id(1, :) == nd_id);
end % nd_id_2_idx

function [dist, d_x, d_y] = edge_weight(nd_1_idx, nd_2_idx, nodes)
%ND_EDGE Calculate straight line distance and change in lat, lon from nd_1 to nd_2
	%disp('edge_weight');
	[nd_1_x, nd_1_y] = nd_xy(nd_1_idx, nodes);
	[nd_2_x, nd_2_y] = nd_xy(nd_2_idx, nodes);

	d_x = nd_1_x - nd_2_x;
	d_y = nd_1_y - nd_2_y;
	dist = sqrt(d_x.^2 + d_y.^2);
end % edge_weight

function [nd_x, nd_y] = nd_xy(nd_idx, nodes)
%ND_XY Return a nodes x, y values based on its idx
	%disp('nd_xy');
	nd_xy = nodes.xy(:, nd_idx);
	nd_x = nd_xy(1);
	nd_y = nd_xy(2);
	%disp(['node ', num2str(nd_idx), ' [x, y] = [', num2str(nd_x), ', ', num2str(nd_y), ']'])
end % nd_xy

%%%%% WAY FUNCTIONS %%%%%%
function [way_id] = way_idx_2_id(way_idx, ways)
%WAY_IDX_2_ID Return a ways ID given its index
	%disp('way_idx_2_id');
	way_id = ways.id(way_idx);
end % way_idx_2_id

function [way_idx] = way_id_2_idx(way_id, ways)
%WAY_ID_2_IDX Return a ways index given its
	%disp('way_id_2_idx');
	way_idx = find(ways.id(:) == way_id);
end % way_id_2_idx

function [start_nd_id] = way_start_nd_id(way_id, ways)
%WAY_START_ND_ID Return a way's first node ID
	%dist('way_start_nd')
	way_idx = way_id_2_idx(way_id, ways);
	way_nd_ids = ways.nd(way_idx);
	way_nd_ids = way_nd_ids{:};
	start_nd_id = way_nd_ids(1);
end % way_start_nd_id

function [end_nd_id] = way_end_nd_id(way_id, ways)
%WAY_END_ND_ID Return a way's final node ID
	%dist('way_start_nd')
	way_idx = way_id_2_idx(way_id, ways);
	way_nd_ids = ways.nd(way_idx);
	way_nd_ids = way_nd_ids{:};
	num_nd = size(way_nd_ids, 2);
	end_nd_id = way_nd_ids(num_nd);
end % way_end_nd_id