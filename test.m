openstreetmap_filename = 'lcc.osm';

[parsed_osm, osm_xml] = parse_openstreetmap(openstreetmap_filename);

[osm_bounds, nodes, ways, ~] = assign_from_parsed(parsed_osm);

plot = true;

[adjacency_list, nodes, ways] = extract_adjacency_list(parsed_osm);

% Plot ways
if plot
	fig = figure;
	ax = axes('Parent', fig);
	hold(ax, 'on');
	plot_way(ax, osm_bounds, nodes, ways, '');
    %plot_nodes(ax, parsed_osm)
end

connected = connected_nds(7879, adjacency_list);

%S = nd_id_2_idx(sig_loc(1, 'black'), nodes);
%T = nd_id_2_idx(sig_loc(2, 'black'), nodes);

S = nd_id_2_idx(sig_loc(1, 'gold'), nodes);
T = nd_id_2_idx(sig_loc(1, 'hole'), nodes);

route = find_route(S, T, adjacency_list);

arr_2_json(route, 'test_route', 'test_route');

if plot
	connected_xy = nodes.xy(:, connected);
	arr_2_json(flip(transpose(flip(connected_xy))), 'test_routeXY', 'test_routeXY_T');

	%connected2_xy = nodes.xy(:, connected2);
	%plotmd(ax, connected_xy, 'ro');
	%plotmd(ax, connected2_xy, 'go');
	plot_route(ax, route, nodes, ways);
	hold(ax, 'off');
end

route = nodes.xy(:, route);

direction = route(2,:) - route(1,:);
direction_rad = atan2(direction(2), direction(1));

%obs_grid = zeros(round(maxY-minY), round(maxX-minX));
obs_grid = zeros(50, 50);
%obs_grid(25:26, 24:25) = 1;
%obs_grid(23:24, 22:23) = 1;

velocity_mps = 0;
acceleration_mpsq = 0;

optimal_path = path_planner(route, route(1,1), route(1,2), direction_rad, velocity_mps, acceleration_mpsq, obs_grid, true)

function [nd_idx] = nd_id_2_idx(nd_id, nodes)
%ND_ID_2_IDX Return a nodes index given its 
	nd_idx = find(nodes.id(1, :) == nd_id);
end % nd_id_2_idx

function [nd_id] = nd_idx_2_id(nd_idx, nodes)
%ND_IDX_2_ID Return a nodes ID given its index
	nd_id = nodes.id(1, nd_idx);
end % nd_idx_2_id