var instruments = func {

# ACCELEROMETER

var z_accel = getprop("/accelerations/pilot/z-accel-fps_sec");
var G = z_accel / -32.174;
setprop("/instrumentation/accelerometer/G", G);
var G_min = getprop("/instrumentation/accelerometer/G-min");
var G_max = getprop("/instrumentation/accelerometer/G-max");
if (G < 1 and G < G_min){
	setprop("/instrumentation/accelerometer/G-min", G);
	} else {
	if (G > G_max){
		setprop("/instrumentation/accelerometert/G-max", G);
		}
	}
var reset = getprop("/instrumentation/accelerometer/reset");
if (reset == 1) {
	setprop("/instrumentation/accelerometer/G-min", 1.0);
	setprop("/instrumentation/accelerometert/G-max", 1.0);
	setprop("/instrumentation/accelerometer/reset", 0);
	}

# ALTIMETER UPDATE FOR 18000-FT TRANSITION

var valid = getprop("/environment/metar/valid");
var metar = getprop("/environment/metar/pressure-inhg");
var alt = getprop("/position/altitude-ft");
var press_alt = getprop("/instrumentation/altimeter/pressure-alt-ft");
var set = getprop("/instrumentation/altimeter/setting-inhg");
if (valid == 1 and alt <= 18000) {
		setprop("/instrumentation/altimeter/setting-inhg", metar);
		}
if (valid == 1 and alt > 18000) {
		setprop("/instrumentation/altimeter/setting-inhg", 29.92);
		setprop("/instrumentation/altimeter/indicated-altitude-ft", press_alt);
		}
if (valid == 0) {
		setprop("/environment/pressure-sea-level-inhg", set);
		}

# APPROACH SPEED COMPUTATION

var gross = getprop("/fdm/jsbsim/inertia/weight-lbs");
var apch_spd = ((gross/1000) + 110);
setprop("/velocities/approach-speed-kt", apch_spd);

# CDI POINTER

heading = getprop("/orientation/heading-magnetic-deg");
course = getprop("/instrumentation/cdi/course-set");

pointer = (heading - course);
while (pointer < 0)
	pointer += 360;
while (pointer > 360)
	pointer -= 360;
while (pointer > 45 and pointer < 90)
	pointer = 45;
while (pointer < 135 and pointer >= 90)
	pointer = 135;
while (pointer > 225 and pointer <= 270)
	pointer = 225;
while (pointer < 315 and pointer > 270)
	pointer = 315;
setprop("/instrumentation/cdi/pointer", pointer);

#CG AS PERCENTAGE OF MEAN AERODYNAMIC CHORD

var cg = getprop("/fdm/jsbsim/inertia/cg-x-in");
var percent = ((cg - 462) / 434);
setprop("/fdm/jsbsim/inertia/cg-percent-mac", percent);

# CLOCK

	# OFFSET TO LOCAL TIME

var offset = getprop("/sim[0]/time/local-offset");
setprop("/instrumentation/clock/offset-sec", offset);

	# MINUTES TIMER
var time = getprop("/sim[0]/time/elapsed-sec");
var min_reset = getprop("/instrumentation/clock/timer/min-reset");
var sequence = getprop("/instrumentation/clock/timer/sequence");
if (min_reset == 1 and sequence == 1) {
		setprop("/instrumentation/clock/timer/start-minutes", time);
		}
var start_minutes = getprop("/instrumentation/clock/timer/start-minutes");
var elapsed_minutes = (time - start_minutes);
setprop("/instrumentation/clock/timer/elapsed-minutes", elapsed_minutes);

	# ELAPSED TIMER
var run = getprop("/instrumentation/clock/timer/run");
var rt_reset = getprop("/instrumentation/clock/timer/rt-reset");
if (rt_reset == 1 and run == 1) {
		setprop("/instrumentation/clock/timer/start-time", time);
		}
var start_time = getprop("/instrumentation/clock/timer/start-time");
var run_time = (time - start_time);
setprop("/instrumentation/clock/timer/run-time", run_time);
var st_set = getprop("/instrumentation/clock/timer/st-set");
var elapsed_time = getprop("/instrumentation/clock/timer/elapsed-time");
var set_time = getprop("/instrumentation/clock/timer/set-time");
if (run == 1) {
	var elapsed_time = (run_time + set_time);
	setprop("/instrumentation/clock/timer/elapsed-time", elapsed_time);
	}
if (st_set == 1 and run == 0) {
	setprop("/instrumentation/clock/timer/set-time", elapsed_time);
	}
	
# EGT CONVERSION, FAHRENHEIT TO CENTIGRADE

var F0 = getprop("/engines/engine[0]/egt-degf");
var F1 = getprop("/engines/engine[1]/egt-degf");
var F2 = getprop("/engines/engine[2]/egt-degf");
var F3 = getprop("/engines/engine[3]/egt-degf");
var C0 = (F0 - 32) * 5/9;
var C1 = (F1 - 32) * 5/9;
var C2 = (F2 - 32) * 5/9;
var C3 = (F3 - 32) * 5/9;
setprop("/engines/engine[0]/egt-degc", C0);
setprop("/engines/engine[1]/egt-degc", C1);
setprop("/engines/engine[2]/egt-degc", C2);
setprop("/engines/engine[3]/egt-degc", C3);

# FLIGHT CONTROL AND AUTOPILOT SWITCH LOGIC

var ils = getprop("/autopilot/locks/auto-ils");
var agl = getprop("/position/altitude-agl-ft");
var fcp = getprop("/autopilot/settings/flight-control-power");
var pitch_hld = getprop("/autopilot/locks/pitch-hold");
var pitch_buffer = getprop("/autopilot/settings/pitch-buffer");
var roll_hld = getprop("/autopilot/locks/roll-hold");
var roll_buffer = getprop("/autopilot/settings/roll-buffer");
var mach_alt_hld = getprop("/autopilot/locks/mach-alt-hold");
var mach_hld = getprop("/autopilot/locks/mach-hold");
var mach_hld_off = getprop("/autopilot/locks/mach-hold-off");
var alt_hld = getprop("/autopilot/locks/altitude-hold");
var hdg_con_hld = getprop("/autopilot/locks/heading-constant-hold");
var hdg_hld_off = getprop("/autopilot/locks/heading-hold-off");
var hdg_nav_hld = getprop("/autopilot/locks/heading-nav-hold");
var mach = getprop("/autopilot/settings/target-mach");
var tgt_mach_kias = getprop("/autopilot/settings/target-mach-kias");
var pa = getprop("/instrumentation/altimeter/pressure-alt-ft");
var x = math.pow(1-(6.8755856e-6*pa),5.2558797);
var tgt_mach_kias = 661.4786*math.pow(5*(math.pow(1+(x*(math.pow(1+(mach*mach/5),3.5)-1)),2/7)-1),0.5);
setprop("/autopilot/settings/target-mach-kias", tgt_mach_kias);

	# AUTOPILOT DISENGAGE BELOW 50 FEET AGL
	if (fcp == 0 or (fcp == 1 and agl <= 50)) {
	setprop("/autopilot/locks/auto-ils", 0);
	setprop("/autopilot/locks/pitch-hold", 0);
	setprop("/autopilot/locks/roll-hold", 0);
	setprop("/autopilot/locks/speed", "");
	setprop("/autopilot/settings/target-speed-kt", 0);
	}
	# AUTO ILS ENGAGE
	if (ils == 1) {
	setprop("/autopilot/locks/pitch-hold", 0);
	setprop("/autopilot/locks/roll-hold", 0);
	setprop("/autopilot/locks/mach-hold-off", 1);
	setprop("/autopilot/locks/heading-hold-off", 1);
	setprop("/autopilot/locks/speed", "speed-with-throttle");
	setprop("/autopilot/settings/target-speed-kt", apch_spd);
	setprop("/autopilot/locks/altitude", "gs1-hold");
	setprop("/autopilot/locks/heading", "nav1-hold");
	}
	# FLIGHT CONTROL PITCH AXIS OFF
	if (pitch_hld == 0 and ils == 0) {
	setprop("/autopilot/locks/mach-hold-off", 1);
	setprop("/autopilot/locks/mach-alt-hold", 0);
	setprop("/autopilot/locks/mach-hold", 0);
	setprop("/autopilot/locks/altitude", "");
	setprop("/autopilot/locks/speed", "");
	}
	# FLIGHT CONTROL PITCH AXIS ON AND ALL AUTOPILOT MACH HOLDS OFF
	if (pitch_hld == 1 and mach_hld_off == 1) {
	setprop("/autopilot/locks/auto-ils", 0);
	setprop("/autopilot/locks/altitude", "pitch-hold");
	setprop("/autopilot/settings/target-pitch-deg", pitch_buffer);
	setprop("/autopilot/locks/speed", "");
	}
	# FLIGHT CONTROL PITCH AXIS ON AND AUTOPILOT MACH-ALTITUDE HOLD ON
	if (mach_alt_hld == 1 and ils == 0) {
	setprop("/autopilot/locks/speed", "speed-with-throttle");
	setprop("/autopilot/settings/target-speed-kt", tgt_mach_kias);
	setprop("/autopilot/locks/altitude", "altitude-hold");
	}
	# FLIGHT CONTROL PITCH AXIS ON AND AUTOPILOT MACH HOLD ON
	if (mach_hld == 1 and ils == 0) {
	setprop("/autopilot/locks/speed", "speed-with-pitch-trim");
	setprop("/autopilot/settings/target-speed-kt", tgt_mach_kias);
	setprop("/autopilot/locks/altitude", "");
	}
	# FLIGHT CONTROL ROLL AXIS OFF
	if (roll_hld == 0 and ils == 0) {
	setprop("/autopilot/locks/heading-hold-off", 1);
	setprop("/autopilot/locks/heading-nav-hold", 0);
	setprop("/autopilot/locks/heading-constant-hold", 0);
	setprop("/autopilot/locks/heading", "");
	setprop("/autopilot/locks/roll", "");
	}
	# FLIGHT CONTROL ROLL AXIS ON AND ALL AUTOPILOT HEADING HOLDS OFF
	if (roll_hld == 1 and hdg_hld_off == 1) {
	setprop("/autopilot/locks/auto-ils", 0);
	setprop("/autopilot/locks/roll", "roll-hold");
	setprop("/autopilot/settings/target-roll-deg", roll_buffer);
	setprop("/autopilot/locks/heading", "");
	}
	# FLIGHT CONTROL ROLL AXIS ON AND AUTOPILOT HEADING-NAV HOLD ON
	if (hdg_nav_hld == 1 and ils == 0) {
	setprop("/autopilot/locks/heading", "true-heading-hold");
	setprop("/autopilot/locks/roll", "");
	}
	# FLIGHT CONTROL ROLL AXIS ON AND AUTOPILOT HEADING-CONSTANT HOLD ON
	if (hdg_con_hld == 1 and ils == 0) {
	setprop("/autopilot/locks/heading", "dg-heading-hold");
	setprop("/autopilot/locks/roll", "");
	}

# MACH INDICATOR

var tgt_mach = getprop("/autopilot/settings/target-mach");
var tgt_mach1 = tgt_mach - int(tgt_mach);
setprop("/autopilot/settings/target-mach-decimal", tgt_mach1);

# NAV PANEL LIGHTING

var sun = getprop("/sim/time/sun-angle-rad");
	if (sun <= 1.40) {
	setprop("/controls/lighting/panel", 0);
	}
	if ((sun > 1.40) and (sun <= 1.56)) {
	setprop("/controls/lighting/panel", .5);
	}
	if (sun > 1.56) {
	setprop("/controls/lighting/panel", 1);
	}

# REFERENCE SPEED

#var gear = getprop("/gear/gear[1]/position-norm");

#if (gear < 1) {
#	setprop("/velocities/reference-airspeed-kt", tgt_mach_kias);
#	}
#if (gear == 1) {
#	setprop("/velocities/reference-airspeed-kt", apch_spd);
#	}

# TRUE AIRSPEED

var tfps = getprop("fdm/jsbsim/velocities/vt-fps");
var tas = .592483801296 * tfps;
setprop("/velocities/true-airspeed-kt", tas);

# VERTICAL SPEED IN FEET PER MINUTE

var v_fps = getprop("/velocities/vertical-speed-fps");
var v_fpm = v_fps * 60;
setprop("/velocities/vertical-speed-fpm", v_fpm);

# VIEW ADJUST--TAKEOFF AND LANDING APPROACH

var gear = getprop("/gear/gear[1]/position-norm");
var factor = getprop("/fdm/jsbsim/systems/view/factor");
var transit = getprop("/fdm/jsbsim/systems/view/transit");
if (gear == 0) {
	setprop("/fdm/jsbsim/systems/view/initialize", 1);
	}
var x_adjust = factor * -.108571;
var y_adjust = .75 + (factor * .15);
var pitch_adjust = -13 - (factor * 3.5);
	if (transit == 1) {
	setprop("sim/current-view/x-offset-m", x_adjust);
	setprop("sim/current-view/y-offset-m", y_adjust);
	setprop("sim/current-view/pitch-offset-deg", pitch_adjust);
	}

settimer(instruments, 0.1);
}
setlistener("sim/signals/fdm-initialized", instruments);