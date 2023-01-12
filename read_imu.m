function [heading, lin_acc_x, lin_acc_y, lin_acc_z] = read_imu(imu_path)
%READ_GPS Read GPS data from text file with latitude as the first line of the file and longitude as the second.
	IMU_file = fopen(imu_path, 'r');
	reading = fscanf(IMU_file, '%f');
	fclose(IMU_file);

	heading = reading(1);
	lin_acc_x = reading(2);
	lin_acc_y = reading(3);
	lin_acc_z = reading(4);
end