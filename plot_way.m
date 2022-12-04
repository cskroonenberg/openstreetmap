function [] = plot_way(ax, bounds, node, way, map_img_filename)
%PLOT_WAY   plot parsed OpenStreetMap file
%
% usage
%   PLOT_WAY(ax, parsed_osm)
%
% input
%   ax = axes object handle
%   parsed_osm = parsed OpenStreetMap (.osm) XML file,
%                as returned by function parse_openstreetmap
%   map_img_filename = map image filename to load and plot under the
%                      transportation network
%                    = string (optional)
%
% 2010.11.06 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also PARSE_OPENSTREETMAP, EXTRACT_CONNECTIVITY.

% ToDo
%   add double way roads

%if nargin < 3
map_img_filename = [];
%end

%[bounds, node, way, ~] = assign_from_parsed(parsed_osm);

disp_info(bounds, size(node.id, 2), size(way.id, 2))
show_ways(ax, bounds, node, way, map_img_filename);

function [] = show_ways(hax, bounds, node, way, map_img_filename)
show_map(hax, bounds, map_img_filename)

node_xys = node.xy;
nodes_to_plot = [];
%plot(node.xy(1,:), node.xy(2,:), '.')
key_catalog = {};
golf_key_values = {};
for i=1:size(way.id, 2)
    [key, val] = get_way_tag_key(way.tag{1,i} );
    
    % find unique way types
    if isempty(key)
        %
    elseif isempty( find(ismember(key_catalog, key) == 1, 1) )
        key_catalog(1, end+1) = {key};
    end
    
    % way = highway or amenity ?
    flag = 0;
    switch key
        case 'highway'
            flag = 1;
        case 'amenity'
            flag = 2;
        case 'golf'
            flag = 3;
            if isempty( find(ismember(golf_key_values, val) == 1, 1) )
                golf_key_values(1, end+1) = {val};
            end
        case 'bridge'
            flag = 4;
        otherwise
            %disp('way without tag.')
    end
    
    way_nd_ids = way.nd{1, i};
    num_nd = size(way_nd_ids, 2);
    nd_coor = zeros(2, num_nd);
    nd_ids = node.id;

    for j=1:num_nd
        cur_nd_id = way_nd_ids(1, j);
        if ~isempty(node.xy(:, cur_nd_id == nd_ids))
             nd_coor(:, j) = node.xy(:, cur_nd_id == nd_ids);
        end
    end
    
    % remove zeros
    nd_coor(any(nd_coor==0,2),:)=[];
    
    if (strcmp(key, 'golf') && strcmp(val, 'cartpath')) || strcmp(key, 'bridge')
        % Plot and label first and last nodes in a way
        idx_1 = find(nd_ids(1, :) == way_nd_ids(1, 1));
        idx_n = find(nd_ids(1, :) == way_nd_ids(1, num_nd));

        id_1 = nd_ids(1, idx_1);
        id_n = nd_ids(1, idx_n);

        curtxt = {['way=', num2str(way.id(i)) ], ['id_1=', num2str(id_1)], }.';
        textmd(node_xys(:, idx_1), curtxt, 'Parent', hax)

        curtxt = {['way=', num2str(way.id(i)) ], ['id_n=', num2str(id_n)], }.';
        textmd(node_xys(:, idx_n), curtxt, 'Parent', hax)

        nodes_to_plot = [nodes_to_plot, idx_1, idx_n];

        % Plot all other nodes (no label)
        for j=2:(num_nd-1)
            idx_j = find(nd_ids(1, :) == way_nd_ids(1, j));
            nodes_to_plot = [nodes_to_plot, idx_j];
            if way.id(i) == 867486969 %772145420% || way.id(i) == 772700736
                id_j = nd_ids(1, idx_j);
                %curtxt = {['way=', num2str(way.id(i)) ], ['id_', num2str(j), '=', num2str(id_j)], }.';
                curtxt = {['id_', num2str(j), '=', num2str(id_j)]}.';
                textmd(node_xys(:, idx_j), curtxt, 'Parent', hax)
            end
        end

        % disp(['way ID = ', num2str(way.id(i))]);
        % disp(['add node ', num2str(way_nd_ids(1, 1)), 'idx: ',  num2str(idx_1), ' to plot']);
        % disp(['add node ', num2str(way_nd_ids(1, num_nd)), 'idx: ',  num2str(idx_n), ' to plot']);
    end

    if ~isempty(nd_coor)
        % plot golf ways
        if flag == 1
            %plot(hax, nd_coor(1,:), nd_coor(2,:), 'b-')
        elseif flag == 2
            %plot(hax, nd_coor(1,:), nd_coor(2,:), 'r-')
        elseif flag == 3
            if strcmp(val, 'fairway') || strcmp(val, 'green')
                plot(hax, nd_coor(1,:), nd_coor(2,:), '-', 'color', '#77AC30')
            elseif strcmp(val, 'bunker')
                plot(hax, nd_coor(1,:), nd_coor(2,:), '-', 'color', '#EDB120')
            elseif strcmp(val, 'cartpath')
                plot(hax, nd_coor(1,:), nd_coor(2,:), 'k-')
            elseif strcmp(val, 'water_hazard')
                plot(hax, nd_coor(1,:), nd_coor(2,:), 'b-')
            else
                plot(hax, nd_coor(1,:), nd_coor(2,:), 'm-')
            end
        elseif flag == 4
            plot(hax, nd_coor(1,:), nd_coor(2,:), '-', 'color', '#FF0000')
        else
            plot(hax, nd_coor(1,:), nd_coor(2,:), 'g--')
        end
    end
    
    %waitforbuttonpress
end

%xy = node_xys(:, nodes_to_plot);
%plotmd(hax, xy, 'yo')

disp(key_catalog.')
disp(golf_key_values.')

function [] = disp_info(bounds, Nnode, Nway)
disp( ['Bounds: xmin = ' num2str(bounds(1,1)),...
    ', xmax = ', num2str(bounds(1,2)),...
    ', ymin = ', num2str(bounds(2,1)),...
    ', ymax = ', num2str(bounds(2,2)) ] )
disp( ['Number of nodes: ' num2str(Nnode)] )
disp( ['Number of ways: ' num2str(Nway)] )
