var takeoff_trim = func {

var cmd = getprop("/fdm/jsbsim/gear/gear-cmd-norm");
var gear = getprop("/gear/gear[1]/position-norm");
var trim = getprop("/fdm/jsbsim/systems/takeoff-trim/elevator-trim");

if (cmd == 0 and gear < 1 and gear > 0) {
	setprop("/controls/flight/elevator-trim", trim);
	}

settimer(takeoff_trim, 0.1);
}
setlistener("sim/signals/fdm-initialized", takeoff_trim);