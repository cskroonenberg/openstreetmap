openstreetmap_filename = 'lcc.osm';

[parsed_osm, osm_xml] = parse_openstreetmap(openstreetmap_filename);

% Plot ways
fig = figure;
ax = axes('Parent', fig);
hold(ax, 'on');
plot_way(ax, parsed_osm);

adjacency_list = extract_adjacency_list(parsed_osm);

nodes_to_plot = connected_nds(7879, adjacency_list);

node = parsed_osm.node;
xy = node.xy(:, nodes_to_plot);
plotmd(ax, xy, 'go');

hold(ax, 'off');