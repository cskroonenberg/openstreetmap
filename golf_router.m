openstreetmap_filename = 'lcc.osm';

%% convert XML -> MATLAB struct
[parsed_osm, osm_xml] = parse_openstreetmap(openstreetmap_filename);

[bounds, node, way, ~] = assign_from_parsed(parsed_osm);

[connectivity_matrix, intersection_node_indices] = extract_cartpath_connectivity(parsed_osm);

disp(connectivity_matrix(1,1));

intersection_nodes = get_unique_node_xy(parsed_osm, intersection_node_indices);

%% plan a route

% try with the assumption of one-way roads (ways in OSM)

start = 8275; % index
%start = 7232770463; % id
target = 8500; % index
%target = 7232770688; % id
start=2775;
target=2750;
%dg = connectivity_matrix; % directed graph
[route, dist] = route_planner(connectivity_matrix, start, target); %start, target are indices

% try without the assumption of one-way roads
%{
%start = 1; % node global index
%target = 9;
%start = 8275; % node global index
%target = 8500;
start = 2775;
target = 2750;
dg = or(connectivity_matrix, connectivity_matrix.'); % make symmetric
[route, dist] = route_planner(dg, start, target);
%}

%% plot
fig = figure;
ax = axes('Parent', fig);
hold(ax, 'on')

% plot the network, optionally a raster image can also be provided for the
% map under the vector graphics of the network
%plot_way(ax, parsed_osm)
%plot_way(ax, parsed_osm, map_img_filename) % if you also have a raster image

%plot_route(ax, route, parsed_osm)
%only_nodes = 1:10:1000; % not all nodes, to reduce graphics memory & clutter
only_nodes = 1:10000; % not all nodes, to reduce graphics memory & clutter
%plot_nodes(ax, parsed_osm, only_nodes, 1)

plot_road_network(ax,connectivity_matrix,parsed_osm)

% show intersection nodes (unseful, but may result into a cluttered plot)
%plot_nodes(ax, parsed_osm, intersection_node_indices)

hold(ax, 'off')
