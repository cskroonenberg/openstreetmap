function [nd_id] = sig_loc(hole, loc)
%SIG_LOC Return the node ID of a significant location based on the hole # and type of location ('black', 'bronze', 'silver', 'gold' for tee boxes and 'hole' for the hole)
	nd_id = 0;
	switch hole
		case 1
			if strcmp(loc, 'black')
				nd_id = 7208400605;
			elseif strcmp(loc, 'bronze')
				nd_id = 7208400608;
			elseif strcmp(loc, 'silver')
				nd_id = 7208400617;
			elseif strcmp(loc, 'gold')
				nd_id = 7208400631;
			elseif strcmp(loc, 'hole')
				nd_id = 7208400684;
			else
				disp('Invalid loc argument given to sig_loc. Value must be ''black'', ''bronze'', ''silver'', ''gold'' or ''hole''');
			end
		case 2
			if strcmp(loc, 'black')
				nd_id = 7212354780;
			elseif strcmp(loc, 'bronze')
				nd_id = 7212354777;
			elseif strcmp(loc, 'silver')
				nd_id = 7212354772;
			elseif strcmp(loc, 'gold')
				nd_id = 7212354767;
			elseif strcmp(loc, 'hole')
				nd_id = 7212354742;
			else
				disp('Invalid loc argument given to sig_loc. Value must be ''black'', ''bronze'', ''silver'', ''gold'' or ''hole''');
			end
		case 3
			if strcmp(loc, 'black')
				nd_id = 7212365140;
			elseif strcmp(loc, 'bronze')
				nd_id = 7212365144;
			elseif strcmp(loc, 'silver')
				nd_id = 7212365158;
			elseif strcmp(loc, 'gold')
				nd_id = 7212365180;
			elseif strcmp(loc, 'hole')
				nd_id = 7212365300;
			else
				disp('Invalid loc argument given to sig_loc. Value must be ''black'', ''bronze'', ''silver'', ''gold'' or ''hole''');
			end
		case 4
			if strcmp(loc, 'black')
				nd_id = 8085848420;
			elseif strcmp(loc, 'bronze')
				nd_id = 7212365294;
			elseif strcmp(loc, 'silver')
				nd_id = 8085841248;
			elseif strcmp(loc, 'gold')
				nd_id = 7214033518;
			elseif strcmp(loc, 'hole')
				nd_id = 7214033415;
			else
				disp('Invalid loc argument given to sig_loc. Value must be ''black'', ''bronze'', ''silver'', ''gold'' or ''hole''');
			end
		case 5
			if strcmp(loc, 'black')
				nd_id = 7214451284;
			elseif strcmp(loc, 'bronze')
				nd_id = 7214451287;
			elseif strcmp(loc, 'silver')
				nd_id = 7214451291;
			elseif strcmp(loc, 'gold')
				nd_id = 7214451305;
			elseif strcmp(loc, 'hole')
				nd_id = 7214451415;
			else
				disp('Invalid loc argument given to sig_loc. Value must be ''black'', ''bronze'', ''silver'', ''gold'' or ''hole''');
			end
		case 6
			if strcmp(loc, 'black')
				nd_id = 7215346106;
			elseif strcmp(loc, 'bronze')
				nd_id = 7215346127;
			elseif strcmp(loc, 'silver')
				nd_id = 7215346151;
			elseif strcmp(loc, 'gold')
				nd_id = 7215346160;
			elseif strcmp(loc, 'hole')
				nd_id = 7218855978;
			else
				disp('Invalid loc argument given to sig_loc. Value must be ''black'', ''bronze'', ''silver'', ''gold'' or ''hole''');
			end
		case 7
			if strcmp(loc, 'black')
				nd_id = 7218921089;
			elseif strcmp(loc, 'bronze')
				nd_id = 7218921094;
			elseif strcmp(loc, 'silver')
				nd_id = 7218921104;
			elseif strcmp(loc, 'gold')
				nd_id = 7218921112;
			elseif strcmp(loc, 'hole')
				nd_id = 7218921175;
			else
				disp('Invalid loc argument given to sig_loc. Value must be ''black'', ''bronze'', ''silver'', ''gold'' or ''hole''');
			end
		case 8
			if strcmp(loc, 'black')
				nd_id = 7218922995;
			elseif strcmp(loc, 'bronze')
				nd_id = 7218923001;
			elseif strcmp(loc, 'silver')
				nd_id = 7218923008;
			elseif strcmp(loc, 'gold')
				nd_id = 7218923027;
			elseif strcmp(loc, 'hole')
				nd_id = 7218923137;
			else
				disp('Invalid loc argument given to sig_loc. Value must be ''black'', ''bronze'', ''silver'', ''gold'' or ''hole''');
			end
		case 9
			if strcmp(loc, 'black')
				nd_id = 7218923162;
			elseif strcmp(loc, 'bronze')
				nd_id = 7218923167;
			elseif strcmp(loc, 'silver')
				nd_id = 7218923179;
			elseif strcmp(loc, 'gold')
				nd_id = 7220557139;
			elseif strcmp(loc, 'hole')
				nd_id = 7220557245;
			else
				disp('Invalid loc argument given to sig_loc. Value must be ''black'', ''bronze'', ''silver'', ''gold'' or ''hole''');
			end
		otherwise
			disp(['Attempted to find a significant location of an invalid hole ''', num2str(hole), '''', '. Value must be in range [1,9]']);
	end
end