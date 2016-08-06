Convair B-58A, v.2.0, 30 Jul 2011, released under Creative Commons license CC-BY-NC-SA

OVERVIEW:

1.  LIVERY: 305th Bombardment Wing, circa early-60s, Bunker Hill AFB (now Grissom ARB), IN.

2.  NAV STATION: I have written Nasal programs for an astrotracker and navigation (great-circle course and distance) computer for accurate simulation. Using the nav computer by entering data one destination at a time from the nav station is cumbersome by contemporary standards, but that's the way it was done back in the day--and be thankful you don't have to do the calculations necessary for the astrotracker to acquire and lock on to a celestial body.  You will have to do some actual flight planning to make sure you have the data you need to enter for the route of flight. Information from these programs are displayed on the various panels at the navigator's station and the Pilot's Data Indicator (see below for both).

3.  TAKEOFF PITCH TRIM: In the real aircraft, the pilot set takeoff pitch trim nose-up but then held the nose wheel on the runway to reduce drag until achieving rotation speed.  Since this is a bit of a pain in the simulation, the takeoff trim automatically sets to zero during the takeoff roll and after rotating (landing gear down).  As the gear retracts during climb-out, pitch trim automatically adjusts to an accurate nose-up attitude and can be adjusted normally after the gear is fully retracted.

ACKNOWLEDGEMENTS:

1.  The 3-D model is converted and revised from J.R. Lucariny's Microsoft Flight Simulator B-58 (released with no restrictions).  I have relied extensively on the B-58A Flight Manual to be as technically accurate as possible.

5.  If you recognize your work in this model and I haven't acknowledged it, it's because of my oversight rather than intent.  Please e-mail me at k_esbenshade@hotmail.com and point out my error.  I'll attribute you here.

AIRSPEED INDICATOR: Carat on the speed scale indicates approach speed when gear is down and mach input to autopilot converted to indicated airspeed when the gear is up (did not exist in the actual aircraft).

ALTIMETER:

	Local Weather Fetch Enabled: Automatically sets local barometric pressure below 18,000 feet and 29.92, the standard datum plane for pressure altitude in the United States, above 18,000 feet (change-over altitude is different elsewhere in the world). Indicated altitude is local below 18,000 feet and pressure altitude above 18,000 feet. The autopilot uses indicated altitude for computations.

	Local Weather Fetch Disabled: Pilot sets manually, and autopilot uses indicated altitude for computations.

ATTITUDE-DIRECTOR INDICATOR (ADI):

	Horizon adjust: Click panels are on each side of the knob. Click the knob itself to reset to zero.

ANGLE OF ATTACK INDEXER (dash):

	-- Lights indicate deviation from desired angle of attack during landing approach (landing gear extended). Red light: well above desired angle of attack (lower nose/increase airspeed); red and green lights: slightly above desired angle of attack (slightly lower nose/increase airspeed);  green light: on desired angle of attack;  yellow and green lights: slightly below desired angle of attack (slightly raise nose/decrease airspeed); yellow light: well below desired angle of attack (raise nose/decrease airspeed).  Also cross-check desired approach speed displayed on airspeed indicator.

	-- Stall light illuminates when angle of attack exceeds 17 degrees.

AUTOPILOT (left console):  The far right switch toggles flight control system (autopilot) power (use ctrl-c for click panel locations for this and following switches).  

	Auto ILS (Ctrl-i): For the lazy among us, flies localizer, glide slope, and airspeed.  You need to be in the reasonable vicinity of all three before you activate the function.

	Autopilot Disconnect Switch (joystick): The joystick trigger (assuming a standard button 0 for trigger) will disengage the autopilot in all axes.

	Autopilot Roll and Pitch Engage switches:  These switches can only be toggled when flight control power is on and the aircraft is airborne.  Roll must be engaged for the heading hold function to work; likewise, Pitch must be engaged for the mach and altitude hold functions to work.  With Roll and no heading hold engaged, the aircraft will maintain the roll attitude it was in when the switch was engaged. With Pitch and no speed or altitude holds engaged, the aircraft will maintain the pitch attitude it was in when the switch was engaged.

	Autopilot Mach-Altitude: When the switch is set to this position, the aircraft will use throttle to hold the aircraft's mach and elevator trim to hold the aircraft's altitude at the time the setting was engaged. Mach may be adjusted from the initial setting with the Autopilot Speed increase/decrease switch on the trim panel at the base of the throttle quadrant.  Current mach is displayed in the window below the speed switch and by small dots on the outside of the mach indicator scales; current mach converted to indicated airspeed is displayed by the carat on the outside of the aispeed indicator scale (these indications are merely for simulation convenience and did not exist in the real aircraft). If you wish to adjust autopilot altitude, you'll have to go into the FlightGear autopilot menu (key F11) to do so.

	Autopilot Mach: When the switch is set to this position, the aircraft will use pitch to hold the aircraft's mach at the time the setting was engaged--useful for constant-mach climbs using throttles to control climb rate. See Autopilot Mach-Altitude above for mach adjustment and displays.

	Autopilot Heading-Nav: When the switch is set to this position, the aircraft will seek and maintain the nav computer's desired heading.

	Autopilot Const (constant heading): When the switch is set to this position, the aircraft will seek and maintain the heading selected on the pilot's BDHI (bearing distance heading indicator).

LIGHT PANEL (right console): Has only internal lighting.  The second-from-left knob controls the left side of the cockpit, and the third-from-left knob controls the right side of the cockpit.  Nav Station lighting is controlled automatically according to sun position.

MACH INDICATOR: Outer dots indicate mach input to autopilot (did not exist in the actual aircraft).

PILOT'S DATA INDICATOR (PDI): Displays ground track (magnetic) and nav computer steering error, time-to-go, and distance-to-go.  For the latter three functions to be accurate, a valid destination point must be entered into the nav computer from the Sighting and Test Panel at the navigator's station (see below).

RADAR ALTIMETER: Use the click panels (Ctrl-C) to set the desired warning altitude above the ground, which is displayed by the carat on the outer edge of the altitude scale.  When the aircraft is lower than the set altitude, the LOW light on the indicator and the RADAR ALT LOW warning light on the center panel will illuminate.

NAVIGATOR'S STATION:

	Astro Panel: Automatically selects and displays accurate astromonical information for one of three celestial bodies: the sun (when above the daytime horizon), Capella (when above the northern hemisphere's nighttime horizon), or Canopus (when above the southern hemisphere's nighttime horizon). If none of these bodies is available, the STAR LOST light will illuminate.

	Indicator Panel: Displays astronomical and aircraft information.

	Navigation Control Panel: Displays true present position.  Transverse (grid navigation) features are not modeled.

	Sighting and Test Panel: Destination Position provides input to the nav computer and, subsequently, to nav and pilot displays.  Use the click panels (Ctrl-C) to enter the position data.