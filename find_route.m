function [route] = find_route(S, T, adjacency_list)
%FIND_ROUTE Returns the shortest route between nodes S and T (according to Dijkstra's algorithm)
	route = [];

	N = size(adjacency_list, 2);

	dist = zeros(N,1) + Inf;	% Initial distance from S to node at index
	prev = zeros(N,1) - 1;		% Previous node in optimal path from source

	dist(S) = 0;				% Dist from S to S is 0

	Q = java.util.PriorityQueue(N);

	Q.add(encode(S, 0));  % Value, weight

	while ~Q.isEmpty()
		u = decode(Q.poll()); % u = node in Q with min distance

		if u == T
			break;
		end % if

		%for e=adjacency_list{u} 
		e = adjacency_list{u};
        for i=1:size(e) % For all edges from u
	        v = e{i}(1);		% v = connected node
	        w = e{i}(2);		% w = edge weight

	        if dist(v) > dist(u) + w 	% If there is a short path to v from u
	        	dist(v) = dist(u) + w;	% Update dist(v)
	        	Q.add(encode(v, weight_as_int(dist(v)))); % Add v to Q with weight expressed as int (for encoding)
	        	prev(v) = u; % Update previous node
	        end % if
	    end % for
	end  %while

	u = T;
	if prev(u) ~= -1 || u == S
		while u
			route = [u, route];
			if u == S
				break;
			end  %if
			u = prev(u);
		end % while
	end % if

end % find_route

function u = encode(value,index)
	% value should be non-negative
	% index should be an integer
	u = sprintf('%010d,%d',uint64(java.lang.Float.floatToIntBits(value)),index);
end % encode

function [value,index] = decode(u)
	value_index = sscanf(u,'%d,%d',2);
	value = java.lang.Float.intBitsToFloat(value_index(1));
	index = value_index(2);
end % decode

function weight = weight_as_int(weight)
	weight = int32(weight*power(10,13));
end % weight_as_int