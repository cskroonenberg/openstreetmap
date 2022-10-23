openstreetmap_filename = 'lcc.osm';

[parsed_osm, osm_xml] = parse_openstreetmap(openstreetmap_filename);

% Plot ways
fig = figure;
ax = axes('Parent', fig);
hold(ax, 'on');
plot_way(ax, parsed_osm);

sig_loc_idxs = [];
node = parsed_osm.node;

% Iterate through hole 1-9
for i=1:9
	% Iterate through significant location types
	for j=["black", "bronze", "silver", "gold", "hole"]
		% Find location ID
		loc_id = sig_loc(i,j);
		% Convert ID to idx
		loc_idx = nd_id_2_idx(loc_id, parsed_osm.node);
		% Append idx to list of idxs
		sig_loc_idxs = [sig_loc_idxs, loc_idx];

		% Annotation
		if j == "hole"
			curtxt = {['Hole ', num2str(i), ' Green' ], ['ID=', num2str(loc_id)]}.';
		else
			curtxt = {['Hole ', num2str(i), ' ', num2str(j), ' Tee Box' ], ['ID=', num2str(loc_id)]}.';
		end
		% Plot annotation
        textmd(node.xy(:, loc_idx), curtxt, 'Parent', ax);
	end
end

% Plot significant locations
xy = node.xy(:, sig_loc_idxs);
plotmd(ax, xy, 'ro');

hold(ax, 'off');

function [nd_idx] = nd_id_2_idx(nd_id, nodes)
%ND_ID_2_IDX Return a nodes index given its 
	nd_idx = find(nodes.id(1, :) == nd_id);
end % nd_id_2_idx