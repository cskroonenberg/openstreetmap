function [lon, lat] = read_gps(gps_path)
%READ_GPS Read GPS data from text file with latitude as the first line of the file and longitude as the second.
	GPS_file = fopen(gps_path, 'r');
	reading = fscanf(GPS_file, '%f');
	fclose(GPS_file);

	lat = reading(1);
	lon = reading(2);
end