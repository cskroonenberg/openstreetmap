openstreetmap_filename = 'lcc.osm';

%% convert XML -> MATLAB struct
[parsed_osm, osm_xml] = parse_openstreetmap(openstreetmap_filename);

[bounds, node, way, ~] = assign_from_parsed(parsed_osm);

fields = fieldnames(way);

i = 2;

w1_id = way.id(i);
w1_tag = way.tag(i);
w1_nd = way.nd(i);

%{
disp('id:');
disp(w1_id);
disp('tag:');
disp(w1_tag{1});
disp('nd:');
disp(w1_nd{1,1});

id = 768899840;
index = find([w1_nd{:} == id]);

disp('index of 768899840:')
disp(index);

id2 = 768899850;
index2 = find([w1_nd{:} == id2]);

disp('index of 768899840:')
disp(index2);

id3 = 11;
index3 = find([w1_nd{:} == id3]);

disp('index of 11:')
disp(index3);
%}

% we're searching for the way containing this node
q_id = 7214033075;

for i=1:size(way.id, 2)
    wi_id = way.id(i);
    wi_tag = way.tag(i);
    wi_nd = way.nd(i);
    disp(wi_id);
    if find([w1_nd{:} == q_id])
        disp(wi_id);
        disp(w1_nd{:});
    end
end