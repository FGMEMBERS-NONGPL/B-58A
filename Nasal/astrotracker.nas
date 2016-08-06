#COPYRIGHT 2011 BY KENT ESBENSHADE

var astro = func {

#****TIME*****

	#DAYS SINCE 0000UT, 1 JAN 2000

var y = getprop("/sim/time/utc/year");
var m = getprop("/sim/time/utc/month");
var d = getprop("/sim/time/utc/day");
var hr = getprop("/sim/time/utc/hour");
var min = getprop("/sim/time/utc/minute");
var sec = getprop("/sim/time/utc/second");

var hour = hr + (min / 60) + (sec / 3600);

var days = (int((1461 * (y + 4800 + int((m -14) / 12))) / 4) + int((367 * (m -2 - (12 * int((m -14) / 12)))) / 12) - int((3 * int((y + 4900 + int((m - 14) / 12)) / 100)) / 4) + d - 32075 - 0.5 + hour/24) - 2451545;
#setprop("/systems/astrotracker/time/days", days);

#*****SUN*****

	#SUN: OMEGA (RADIANS)

var omega = 2.1429 - (0.0010394594 * days);

	#SUN: MEAN ANOMALY

var M1 = 357.52911 + ((0.0000273785 * days) * (35999.05029 - (0.0000000042080767 * days)));
	while (M1 < 0)
		M1 += 360;
	while (M1 > 360)
		M1 -= 360;
#setprop("/systems/astrotracker/sun/mean-anomaly-deg", M1);
var M = M1 * D2R;
#setprop("/systems/astrotracker/sun/mean-anomaly-rad", M);

	#SUN: OBLIQUITY OF THE ECLIPTIC

var oblecl1 = 23.4393 - (.0000003563 * days);
#setprop("/systems/astrotracker/sun/obliquity-of-ecliptic-deg", oblecl1);
var oblecl = oblecl1 * D2R;
#setprop("/systems/astrotracker/sun/obliquity-of-ecliptic-rad", oblecl);

	#SUN: MEAN LONGITUDE

var L = 4.8950630 + (0.017202791698 * days);
#setprop("/systems/astrotracker/sun/mean-longitude-rad", L);
var L1 = L * R2D;
	while (L1 < 0)
		L1 += 360;
	while (L1 > 360)
		L1 -= 360;
#setprop("/systems/astrotracker/sun/mean-longitude-deg", L1);

	#SUN: LONGITUDE

var lon = L + (0.03341607 * math.sin(M)) + (0.00034894 * math.sin(2 * M)) - 0.0001134 - (0.0000203 * math.sin(omega));
#setprop("/systems/astrotracker/sun/longitude-rad", lon);
var lon1 = lon * R2D;
	while (lon1 < 0)
		lon1 += 360;
	while (lon1 > 360)
		lon1 -= 360;
#setprop("/systems/astrotracker/sun/longitude-deg", lon1);

	#SUN: RIGHT ASCENSION

var ra = math.atan2(math.sin(lon) * math.cos(oblecl),math.cos(lon));
#setprop("/systems/astrotracker/sun/right-ascension-rad", ra);
var ra1 = ra * R2D;
	while (ra1 < 0)
		ra1 += 360;
	while (ra1 > 360)
		ra1 -= 360;
#setprop("/systems/astrotracker/sun/right-ascension", ra1);

	#SUN: DECLINATION

var dec = math.asin(math.sin(lon) * math.sin(oblecl));
#setprop("/systems/astrotracker/sun/declination-rad", dec);
var dec1 = dec * R2D;
#setprop("/systems/astrotracker/sun/declination", dec1);

	#GREENWICH MEAN SIDEREAL TIME AT 0000UT (DEGREES)

var gmst0 = L1 + 180;
	while (gmst0 < 0)
		gmst0 += 360;
	while (gmst0 > 360)
		gmst0 -= 360;
#setprop("/systems/astrotracker/time/GMST0", gmst0);

	#GREENWICH MEAN SIDEREAL TIME NOW (HOURS)

var gmst = (gmst0 / 15) + hour;
	while (gmst < 0)
		gmst += 24;
	while (gmst > 24)
		gmst -= 24;
#setprop("/systems/astrotracker/time/GMST", gmst);

	#LOCAL SIDEREAL TIME

var longitude = getprop("/position/longitude-deg");
var lst = gmst0 + (hour * 15) + longitude;
	while (lst < 0)
		lst += 360;
	while (lst > 360)
		lst -= 360;
#setprop("/systems/astrotracker/time/LST", lst);

	#SUN: GHA

var gha = gmst - ra1;
	while (gha < 0)
		gha += 360;
	while (gha > 360)
		gha -= 360;
#setprop("/systems/astrotracker/sun/GHA", gha);

	#SUN: SHA

var sha = 360 - ra1;
	while (sha < 0)
		sha += 360;
	while (sha > 360)
		sha -= 360;
#setprop("/systems/astrotracker/sun/SHA", sha);

	#SUN: HOUR ANGLE (DEGREES)

var ha = lst - ra1;
	while (ha < 0)
		ha += 360;
	while (ha > 360)
		ha -= 360;
#setprop("/systems/astrotracker/sun/hour-angle-deg", ha);
var ha1 = ha * D2R;
#setprop("/systems/astrotracker/sun/hour-angle-rad", ha1);

	#SUN: AZIMUTH

var lat = getprop("/position/latitude-deg");

var x1 = math.cos(ha1) * math.cos(dec);
var y1 = math.sin(ha1) * math.cos(dec);
var z1 = math.sin(dec);

var xhor = (x1 * math.sin(lat * D2R)) - (z1 * math.cos(lat * D2R));
var yhor = y1;
var zhor = (x1 * math.cos(lat * D2R)) + (z1 * math.sin(lat * D2R));
var az = (math.atan2(yhor,xhor) * R2D) + 180;
	while (az < 0)
		az += 360;
	while (az > 360)
		az -= 360;
#setprop("/systems/astrotracker/sun/azimuth", az);

	#SUN: ALTITUDE

var alt_den = math.sqrt((xhor * xhor) + (yhor * yhor));
var alt1 = math.atan2(zhor,alt_den);
var alt = alt1 * R2D;
#setprop("/systems/astrotracker/sun/altitude", alt);

#*****CAPELLA*****

var cap_dec = 46.129911;
#setprop("/systems/astrotracker/capella/declination", cap_dec);
var cap_ra = 80.723296;

	#CAPELLA: GHA

var cap_gha = gmst - cap_ra;
	while (cap_gha < 0)
		cap_gha += 360;
	while (cap_gha > 360)
		cap_gha -= 360;
#setprop("/systems/astrotracker/capella/GHA", cap_gha);

	#CAPELLA: SHA

var cap_sha = 360 - cap_ra;
	while (cap_sha < 0)
		cap_sha += 360;
	while (cap_sha > 360)
		cap_sha -= 360;
#setprop("/systems/astrotracker/capella/SHA", cap_sha);

	#CAPELLA: HOUR ANGLE (DEGREES)

var cap_ha = lst - cap_ra;
	while (cap_ha < 0)
		cap_ha += 360;
	while (cap_ha > 360)
		cap_ha -= 360;

	#CAPELLA: AZIMUTH

var cap_x1 = math.cos(cap_ha * D2R) * math.cos(cap_dec * D2R);
var cap_y1 = math.sin(cap_ha * D2R) * math.cos(cap_dec * D2R);
var cap_z1 = math.sin(cap_dec * D2R);

var cap_xhor = (cap_x1 * math.sin(lat * D2R)) - (cap_z1 * math.cos(lat * D2R));
var cap_yhor = cap_y1;
var cap_zhor = (cap_x1 * math.cos(lat * D2R)) + (cap_z1 * math.sin(lat * D2R));
var cap_az = (math.atan2(cap_yhor,cap_xhor) * R2D) + 180;
#setprop("/systems/astrotracker/capella/azimuth", cap_az);

	#CAPELLA: ALTITUDE

var cap_den = math.sqrt((cap_xhor * cap_xhor) + (cap_yhor * cap_yhor));
var cap_alt = math.atan2(cap_zhor,cap_den) * R2D;
#setprop("/systems/astrotracker/capella/altitude", cap_alt);

#*****CANOPUS*****

var can_dec = -52.806605;
#setprop("/systems/astrotracker/canopus/declination", can_dec);
var can_ra = 98.1295785;

	#CANOPUS: GHA

var can_gha = gmst - can_ra;
	while (can_gha < 0)
		can_gha += 360;
	while (can_gha > 360)
		can_gha -= 360;
#setprop("/systems/astrotracker/canopus/GHA", can_gha);

	#CANOPUS: SHA

var can_sha = 360 - can_ra;
	while (can_sha < 0)
		can_sha += 360;
	while (can_sha > 360)
		can_sha -= 360;
#setprop("/systems/astrotracker/canopus/SHA", can_sha);

	#CANOPUS: HOUR ANGLE (DEGREES)

var can_ha = lst - can_ra;
	while (can_ha < 0)
		can_ha += 360;
	while (can_ha > 360)
		can_ha -= 360;

	#CANOPUS: AZIMUTH

var can_x1 = math.cos(can_ha * D2R) * math.cos(can_dec * D2R);
var can_y1 = math.sin(can_ha * D2R) * math.cos(can_dec * D2R);
var can_z1 = math.sin(can_dec * D2R);

var can_xhor = (can_x1 * math.sin(lat * D2R)) - (can_z1 * math.cos(lat * D2R));
var can_yhor = can_y1;
var can_zhor = (can_x1 * math.cos(lat * D2R)) + (can_z1 * math.sin(lat * D2R));
var can_az = (math.atan2(can_yhor,can_xhor) * R2D) + 180;
#setprop("/systems/astrotracker/canopus/azimuth", can_az);

	#CANOPUS: ALTITUDE

var can_den = math.sqrt((can_xhor * can_xhor) + (can_yhor * can_yhor));
var can_alt = math.atan2(can_zhor,can_den) * R2D;
#setprop("/systems/astrotracker/canopus/altitude", can_alt);

#*****TRACKING*****

	#SELECT STAR

var star = props.globals.getNode("/systems/astrotracker/star", 1);

if (alt > 0) {
	star.setValue("Sun");
	var star_num = 1;
	} elsif (cap_alt > 0) {
	star.setValue("Capella");
	var star_num = 2;
	} elsif (can_alt > 0) {
	star.setValue("Canopus");
	var star_num = 3;
	} else {
	star.setValue("Star Lost");
	var star_num = 0;
	}

setprop("/systems/astrotracker/star-number", star_num);

	#SET TRACKING VALUES

if (star_num == 0) {
	var GHA = 0;
	var SHA = 0;
	var altitude = 0;
	var azimuth = 0;
	var declination_dec = 0;
	} elsif (star_num == 1) {
	var GHA = gha;
	var SHA = sha;
	var altitude = alt;
	var azimuth = az;
	var declination_dec = dec1;
	} elsif (star_num == 2) {
	var GHA = cap_gha;
	var SHA = cap_sha;
	var altitude = cap_alt;
	var azimuth = cap_az;
	var declination_dec = cap_dec;
	} elsif (star_num == 3) {
	var GHA = can_gha;
	var SHA = can_sha;
	var altitude = can_alt;
	var azimuth = can_az;
	var declination_dec = can_dec;
	}

var GHA_deg = int(GHA);
setprop("/systems/astrotracker/GHA-deg", GHA_deg);
var GHA_min = 60 * (GHA - GHA_deg);
setprop("/systems/astrotracker/GHA-min", GHA_min);

var SHA_deg = int(SHA);
setprop("/systems/astrotracker/SHA-deg", SHA_deg);
var SHA_min = 60 * (SHA - SHA_deg);
setprop("/systems/astrotracker/SHA-min", SHA_min);

var altitude_deg = int(altitude);
setprop("/systems/astrotracker/altitude-deg", altitude_deg);
var altitude_min = 60 * (altitude - altitude_deg);
setprop("/systems/astrotracker/altitude-min", altitude_min);

setprop("/systems/astrotracker/azimuth-deg", azimuth);

setprop("/systems/astrotracker/declination-dec", declination_dec);
var declination = declination_dec;
	if (declination < 0) {
		declination = declination * -1;
		}
var declination_deg = int(declination);
setprop("/systems/astrotracker/declination-deg", declination_deg);
var declination_min = 60 * (declination - declination_deg);
setprop("/systems/astrotracker/declination-min", declination_min);

settimer(astro, 0.1);
}
setlistener("sim/signals/fdm-initialized", astro);