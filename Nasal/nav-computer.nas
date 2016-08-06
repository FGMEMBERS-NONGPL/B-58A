#COPYRIGHT 2011 BY KENT ESBENSHADE

var nav = func {

#CONVERT PRESENT POSITION FROM DECIMAL TO DEGREES AND MINUTES

var lat = getprop("/position/latitude-deg");
var lon = getprop("/position/longitude-deg");

var lat_d = int(lat);
setprop("/systems/nav-computer/position/latitude-deg", lat_d);
var lat_m = 60 * (lat - int(lat));
setprop("/systems/nav-computer/position/latitude-min", lat_m);

var lat_d1 = lat_d * -1;
var lat_m1 = lat_m * -1;
if (lat < 0) {
		setprop("/systems/nav-computer/position/latitude-degrees", lat_d1);
		setprop("/systems/nav-computer/position/latitude-minutes", lat_m1);
		} else {
		setprop("/systems/nav-computer/position/latitude-degrees", lat_d);
		setprop("/systems/nav-computer/position/latitude-minutes", lat_m);
		}

var lon_d = int(lon);
setprop("/systems/nav-computer/position/longitude-deg", lon_d);
var lon_m = 60 * (lon - int(lon));
setprop("/systems/nav-computer/position/longitude-min", lon_m);

var lon_d1 = lon_d * -1;
var lon_m1 = lon_m * -1;
if (lon < 0) {
		setprop("/systems/nav-computer/position/longitude-degrees", lon_d1);
		setprop("/systems/nav-computer/position/longitude-minutes", lon_m1);
		} else {
		setprop("/systems/nav-computer/position/longitude-degrees", lon_d);
		setprop("/systems/nav-computer/position/longitude-minutes", lon_m);
		}

#CONVERT DESTINATION POSITION FROM DEGREES AND MINUTES TO DECIMAL

var dest_lat_d = getprop("/systems/nav-computer/destination/latitude-deg");
var dest_lat_m = getprop("/systems/nav-computer/destination/latitude-min");
var dest_lon_d = getprop("/systems/nav-computer/destination/longitude-deg");
var dest_lon_m = getprop("/systems/nav-computer/destination/longitude-min");

var dest_lat = dest_lat_d + (dest_lat_m / 60);

var dest_lat_d1 = dest_lat_d * -1;
var dest_lat_m1 = dest_lat_m * -1;
if (dest_lat < 0) {
		setprop("/systems/nav-computer/destination/latitude-degrees", dest_lat_d1);
		setprop("/systems/nav-computer/destination/latitude-minutes", dest_lat_m1);
		} else {
		setprop("/systems/nav-computer/destination/latitude-degrees", dest_lat_d);
		setprop("/systems/nav-computer/destination/latitude-minutes", dest_lat_m);
		}

var dest_lon = dest_lon_d + (dest_lon_m / 60);

var dest_lon_d1 = dest_lon_d * -1;
var dest_lon_m1 = dest_lon_m * -1;
if (dest_lon < 0) {
		setprop("/systems/nav-computer/destination/longitude-degrees", dest_lon_d1);
		setprop("/systems/nav-computer/destination/longitude-minutes", dest_lon_m1);
		} else {
		setprop("/systems/nav-computer/destination/longitude-degrees", dest_lon_d);
		setprop("/systems/nav-computer/destination/longitude-minutes", dest_lon_m);
		}

#GREAT CIRCLE DESIRED TRUE TRACK IN DEGREES, PRESENT POSITION TO DESTINATION

var lat_rad = lat * D2R;
var lon_rad = lon * D2R;
var dest_lat_rad = dest_lat * D2R;
var dest_lon_rad = dest_lon * D2R;

var dtt = R2D * math.mod(math.atan2(math.sin(dest_lon_rad - lon_rad) * math.cos(dest_lat_rad),(math.cos(lat_rad) * math.sin(dest_lat_rad)) - (math.sin(lat_rad) * math.cos(dest_lat_rad) * math.cos(dest_lon_rad - lon_rad))),2 * math.pi);
	while (dtt < 0)
		dtt += 360;
	while (dtt > 360)
		dtt -= 360;
setprop("/systems/nav-computer/desired-track-deg", dtt);

#GREAT CIRCLE DISTANCE IN NAUTICAL MILES, PRESENT POSITION TO DESTINATION

var dist = 3437.7467707849 * math.acos((math.sin(lat_rad) * math.sin(dest_lat_rad)) + (math.cos(lat_rad) * math.cos(dest_lat_rad) * math.cos(lon_rad - dest_lon_rad)));
setprop("/systems/nav-computer/distance-nm", dist);

#TIME TO GO

var gs = getprop("/velocities/groundspeed-kt");

var ttg_m = dist / (gs / 60);
setprop("/systems/nav-computer/time-to-go-min", ttg_m);

var ttg_s = ttg_m * 60;
	while (ttg_s > 300)
	ttg_s = 300;
setprop("/systems/nav-computer/time-to-go-sec", ttg_s);

settimer(nav, 0.1);
}
setlistener("sim/signals/fdm-initialized", nav);