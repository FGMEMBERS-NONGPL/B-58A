# B-58A wheel & tire rotations
# FDM wheel speed is in feet-per-second (assuming linear distance), but
# we need revolutions-per-minute (rotational distance) for the spin animation, so
# we need to convert fps to rpm in the following manner:
# 1. find model's tire circumference in feet (C = pi*D)
#	NOTE: Distances in AC3D (.ac file) are in meters, so first,
#	we must convert meters to feet USING THE SCALE OF THIS MODEL
#	(that is, we can't automatically assume that the model is placed
#	in the AC3D frame of reference so that 1 foot = 0.3048 meters or 1 meter = 3.281 ft):
#	Measure the model's wing span in meters in the .ac file and
#	obtain the model's wing span in feet from the metrics section of the FDM;
#	divide wing-span-meters by wing-span-feet for a conversion factor.
#	Multiply the conversion factor times the tire's circumference in meters to
#	get the tire's circumference in feet.
# 2. Since 1 fps linear = 60 feet per minute linear,
#    distance covered by the tire in one revolution in one minute (rpm) = 60 / C.
# 3. Use this number in the calculations following.

rotate = func {
var nose = getprop("/fdm/jsbsim/gear/unit[0]/wheel-speed-fps");
var left = getprop("/fdm/jsbsim/gear/unit[1]/wheel-speed-fps");
var right = getprop("/fdm/jsbsim/gear/unit[2]/wheel-speed-fps"); 
var nose_rpm = (nose * 11.239125);
setprop("/fdm/jsbsim/gear/unit[0]/RPM", nose_rpm);
var left_rpm = (left * 8.819380);
setprop("/fdm/jsbsim/gear/unit[1]/RPM", left_rpm);
var right_rpm = (right * 8.819380);
setprop("/fdm/jsbsim/gear/unit[2]/RPM", right_rpm);
settimer(rotate, 0.1);
}
setlistener("sim/signals/fdm-initialized", rotate);