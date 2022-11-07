openstreetmap_filename = 'lcc.osm';

[parsed_osm, osm_xml] = parse_openstreetmap(openstreetmap_filename);

[bounds, nodes, ways, ~] = assign_from_parsed(parsed_osm);

plot = true;

[adjacency_list, nodes, ways] = extract_adjacency_list(parsed_osm);

% Plot ways
if plot
	fig = figure;
	ax = axes('Parent', fig);
	hold(ax, 'on');
	plot_way(ax, bounds, nodes, ways, '');
    %plot_nodes(ax, parsed_osm)
end

connected = connected_nds(7879, adjacency_list);

%S = nd_id_2_idx(sig_loc(2, 'black'), nodes);
%T = nd_id_2_idx(sig_loc(4, 'black'), nodes);

%route = find_route(S, T, adjacency_list);

if plot
	% xy = nodes.xy(:, connected);
	% plotmd(ax, xy, 'ro');
	%plot_route(ax, route, parsed_osm);
	hold(ax, 'off');
end

function [nd_idx] = nd_id_2_idx(nd_id, nodes)
%ND_ID_2_IDX Return a nodes index given its 
	nd_idx = find(nodes.id(1, :) == nd_id);
end % nd_id_2_idx

function [nd_id] = nd_idx_2_id(nd_idx, nodes)
%ND_IDX_2_ID Return a nodes ID given its index
	nd_id = nodes.id(1, nd_idx);
end % nd_idx_2_id