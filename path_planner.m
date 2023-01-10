function [path] = path_planner(route, longitude, latitude, theta_rad, velocity_mps, acceleration_mpsq, obstacle_grid, show_path)
%PATH_PLANNER Return the node ID of a significant location based on the hole # and type of location ('black', 'bronze', 'silver', 'gold' for tee boxes and 'hole'
	% Transform route for path planning
	route = transpose(route);
	route = abs(route);

	% Convert to meters
	route(:,1) = route(:,1) * 111139
	route(:,2) = route(:,2) * 111139

	% Find route bounds
	routeX = route(:,1);
	routeY = route(:,2);
	[minX, maxX] = bounds(routeX);
	[minY, maxY] = bounds(routeY);

	% Normalize
	%longitude = longitude*111139 - minX
	%latitude = latitude*111139 - minY
	route(:,1) = route(:,1) - minX;
	route(:,2) = route(:,2) - minY;

	% Filter waypoints more than 50 meters away from origin
	% TODO: Could leave this up to function caller to decide
	routeX = route(:,1);
	routeY = route(:,2);

	X_idxs = find(routeX < 50);
	Y_idxs = find(routeY < 50);

	idxs = intersect(X_idxs,Y_idxs)

	route = [routeX(idxs) routeY(idxs)]

	routeX = route(:,1);
	routeY = route(:,2);

	[minX, maxX] = bounds(routeX);
	[minY, maxY] = bounds(routeY);

	% Find route bounds
	routeX = route(:,1);
	routeY = route(:,2);
	[minX, maxX] = bounds(routeX);
	[minY, maxY] = bounds(routeY);

	refPath = referencePathFrenet(route); % TODO: What does this do

	% Create obstacle grid map % TODO: SET FROM FN ARGUMENT
	obstacle_grid = zeros(round(maxY-minY), round(maxX-minX));
	%obs_grid(25:26, 24:25) = 1;
	%obs_grid(23:24, 22:23) = 1;

	map = binaryOccupancyMap(obstacle_grid);

	% State validator init
	stateValidator = validatorOccupancyMap;
	stateValidator.Map = map;
	stateValidator.StateSpace.StateBounds(1:2,:) = [map.XWorldLimits; map.YWorldLimits];

	planner = trajectoryOptimalFrenet(refPath, stateValidator);

	% Set terminal states for generated paths
	planner.TerminalStates.Longitudinal = route(end, 1);
	planner.TerminalStates.Lateral = -1:0.5:1 %routeY(end)-1:0.1:routeY(end)+1

	planner.Weights.LateralSmoothness = 1;
	planner.Weights.LongitudinalSmoothness = 1;

	% TODO: Set params according to vehicle
	planner.FeasibilityParameters.MaxCurvature = 0.5; % Maximum curvature that the vehicle can execute
	planner.FeasibilityParameters.MaxAcceleration = 4; % ~10 meters / second
	planner.DeviationOffset = 0;

	%% Trajectory Planning
	% init cartesian state: x, y, theta (orientation angle in radians), kappa (curvature in m^-1), speed (m/s), acceleration (m/s^2)
	disp('lon, lat:')
	disp(longitude)
	disp(latitude)

	theta_deg = route(2,:) - route(1,:);
	theta_rad = atan2(theta_deg(2), theta_deg(1))

	initCartState = [route(1,1) route(1,2), theta_rad, 0, velocity_mps, acceleration_mpsq];

	% Convert cartesian state of vehicle to Frenet state.
	initFrenetState = cart2frenet(planner,initCartState);

	% Plan a trajectory from initial Frenet state.
	[path, index, cost, flag] = plan(planner,initFrenetState);

	if show_path
		show(map)
		hold on
		show(planner, 'Trajectory', 'all')
	end
end

%% Helper functions
function [nd_idx] = nd_id_2_idx(nd_id, nodes)
%ND_ID_2_IDX Return a nodes index given its 
	nd_idx = find(nodes.id(1, :) == nd_id);
end % nd_id_2_idx

function [nd_id] = nd_idx_2_id(nd_idx, nodes)
%ND_IDX_2_ID Return a nodes ID given its index
	nd_id = nodes.id(1, nd_idx);
end % nd_idx_2_id

function [nd_x, nd_y] = nd_idx_2_xy(nd_idx, nodes)
%%ND_IDX_2_XY Return a node's coordinates given its index
	[nd_x, nd_y] = nodes(nd_idx)
end % nd_idx_2_xy