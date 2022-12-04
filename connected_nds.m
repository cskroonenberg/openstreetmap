function [connected] = connected_nds(node_idx, adjacency_list)
%CONNECTED_NDS Return a list of all nodes reachable from a given node
    connected = [];

    % DFS
    S=[node_idx]; % Initialize S to be a stack with one element s

    while size(S, 2) > 0 % While S is not empty
        % pop u
        u = S(1);
        S = S([2:size(S,2)]);
        if ~ismember(u, connected) % If Explored[u] = false then explore u
            connected = [connected, u];
            e = adjacency_list{u};
            for i=1:size(e) % Add u's adjacent nodes to S
                v = e{i}(1);
                S = [v, S];
            end % for
        end % if
    end % while

end % connected_nds