function [] = plot_way(ax, parsed_osm, map_img_filename)
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

if nargin < 3
    map_img_filename = [];
end

[bounds, node, way, ~] = assign_from_parsed(parsed_osm);

disp_info(bounds, size(node.id, 2), size(way.id, 2))
show_ways(ax, bounds, node, way, map_img_filename);

function [] = show_ways(hax, bounds, node, way, map_img_filename)
show_map(hax, bounds, map_img_filename)

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

            % bus stop ?
            if strcmp(val, 'bus_stop')
                disp('Bus stop found')
            end
        case 'amenity'
            flag = 2;
            % bus station ?
            if strcmp(val, 'bus_station')
                disp('Bus station found')
            end
        case 'golf'
            flag = 3;
            if isempty( find(ismember(golf_key_values, val) == 1, 1) )
                golf_key_values(1, end+1) = {val};
            end
        otherwise
            %disp('way without tag.')
    end
    
    % plot highway
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
        else
            plot(hax, nd_coor(1,:), nd_coor(2,:), 'g--')
        end
    end
    
    %waitforbuttonpress
end
disp(key_catalog.')
disp(golf_key_values.')

function [] = disp_info(bounds, Nnode, Nway)
disp( ['Bounds: xmin = ' num2str(bounds(1,1)),...
    ', xmax = ', num2str(bounds(1,2)),...
    ', ymin = ', num2str(bounds(2,1)),...
    ', ymax = ', num2str(bounds(2,2)) ] )
disp( ['Number of nodes: ' num2str(Nnode)] )
disp( ['Number of ways: ' num2str(Nway)] )
