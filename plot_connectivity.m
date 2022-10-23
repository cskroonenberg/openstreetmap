function [] = plot_connectivity(S, ax, parsed_osm, adjacency_list)
%PLOT_CONNECTIVITY Plot all nodes reachable from node with ID=S
	node = parsed_osm.node;

	% Find nodes reachable from start node, S
	nodes_to_plot = connected_nds(S, adjacency_list);

	% Annotate start node
	curtxt = {['Start node ', num2str(S)]}.';
	textmd(node.xy(:, S), curtxt, 'Parent', ax);

	% Plot connected nodes
	xy = node.xy(:, nodes_to_plot);
	plotmd(ax, xy, 'go');
end