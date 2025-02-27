% INIT
tic
openstreetmap_filename = 'lcc.osm';
[parsed_osm, ~] = parse_openstreetmap(openstreetmap_filename);
[osm_bounds, nodes, ways, ~] = assign_from_parsed(parsed_osm);
[adjacency_list, nodes, ways] = extract_adjacency_list(parsed_osm);

% Plot ways
if plot
	fig = figure;
	ax = axes('Parent', fig);
	hold(ax, 'on');
	plot_way(ax, osm_bounds, nodes, ways, '');
    %plot_nodes(ax, parsed_osm)
end

plot = false
disp('Init')
toc
i = 0;
while true
	tic
	[lon, lat] = read_GPS();
	S = closest_node(lat, lon, node); % TODO
	T = get_goal_state(); % TODO: Read target state assigned in UI
	route = find_route(S, T, adjacency_list);

	arr_2_json(route, 'test_route', 'test_route'); % TODO: only write route if target has been updated?

	% Only plot if target has been updated (or not at all)
	if plot
		connected = connected_nds(7879, adjacency_list);
		connected_xy = nodes.xy(:, connected);
		arr_2_json(flip(transpose(flip(connected_xy))), 'test_routeXY', 'test_routeXY_T');
		plot_route(ax, route, nodes, ways);
		hold(ax, 'off');
	end % if

	route_xy = nodes.xy(:, route);

	% TODO: Determine obs_grid size
	% obs_grid = zeros(round(maxY-minY), round(maxX-minX));
	obs_grid = get_obstacles(); % TODO: Read obstacles identified by camera

	% TODO: Read from IMU and GPS
	[heading_deg, lin_acc_x, lin_acc_y, lin_acc_z] = read_imu('imu.txt');
	[lon, lat, speed_mps = read_gps('gps.txt');

	direction_rad = heading_deg*(pi/180);
	% TODO: Convert directional acceleration to single acceleration value (meters / second^2)

	%TODO: Will need to determine best way to convert lon, lat to cartesian meters
	optimal_path = path_planner(route, lon, lat, direction_rad, speed_mps, acceleration_mpsq, obs_grid, plot);

	% Give path to controller
	% Send commands to actuators
	disp([num2str(i), ') elapsed time:', num2str(toc)])
end % while