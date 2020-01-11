simulator( 'spectre )

;design(	 "/home/saul/Sim/S3_PI/spectre/schematic/netlist/netlist")
design(	 "EXERCISE1" "S2_PI" "schematic")
createNetlist()

resultsDir( "/home/saul/Sim/S2_PI/spectre/schematic" )
modelFile( 
    '("/pkg/xfab/XKIT/xh018/cadence/v8_0/spectre/v8_0_1/lpmos/config.scs" "default")
    '("/pkg/xfab/XKIT/xh018/cadence/v8_0/spectre/v8_0_1/lpmos/param.scs" "3s")
    '("/pkg/xfab/XKIT/xh018/cadence/v8_0/spectre/v8_0_1/lpmos/bip.scs" "tm")
    '("/pkg/xfab/XKIT/xh018/cadence/v8_0/spectre/v8_0_1/lpmos/cap.scs" "tm")
    '("/pkg/xfab/XKIT/xh018/cadence/v8_0/spectre/v8_0_1/lpmos/dio.scs" "tm")
    '("/pkg/xfab/XKIT/xh018/cadence/v8_0/spectre/v8_0_1/lpmos/mos.scs" "tm")
    '("/pkg/xfab/XKIT/xh018/cadence/v8_0/spectre/v8_0_1/lpmos/photo.scs" "tm")
    '("/pkg/xfab/XKIT/xh018/cadence/v8_0/spectre/v8_0_1/lpmos/res.scs" "tm")
)

load("OS/CHARACTERIZATION/global.il")

;NMOS1: W1_tot = 800.00um  L1 = 0.35um  IDS1 = 0.8000mA  VDS1 = 1.00V
  gm1 = 14.299m
  rds1 = 15551.16
  cgs1 = 912.96f
  cgd1 = 262.49f
  cds1 = 0.45f
  cdb1 = 648.32f
  vgs1 = 0.6572
  Gain1 = 222.37
  gm_id1 = 17.87
;  Ft1 = 1936.11 MHz 

; PMOS1: W4_tot = 100.00um  L4 = 0.18um  IDS4 = 1.3000mA  VDS4 = 0.50V
  gm4 = 8.714m
  rds4 = 4208.45
  cgs4 = 139.95f
  cgd4 = 31.92f
  cds4 = 0.32f
  cdb4 = 83.04f
  vgs4 = -0.9090
  Gain4 = 36.67
  gm_id4 = 6.70
;  Ft4 = 8070.01 MHz 

IT = 0;
IS = 1;

desVar(	  "cdb1" cdb1	)
desVar(	  "cdb4" cdb4	)
desVar(	  "cds1" cds1	)
desVar(	  "cds4" cds4	)
desVar(	  "cgd1" cgd1	)
desVar(	  "cgd4" cgd4	)
desVar(	  "cgs1" cgs1	)
desVar(	  "cgs4" cgs4	)
desVar(	  "gm1" gm1	)
desVar(	  "gm4" gm4	)
desVar(	  "rds1" rds1	)
desVar(	  "rds4" rds4	)

desVar(	  "R1" 100k	)
desVar(	  "R2" 400	)

desVar(	  "IT" IT )
desVar(	  "IS" IS )

/***************************************************/
/* Closed loop Gain                                */
/* The source must be active, and the loop closed  */
/* Set the IS = 1, gm = gm1, and IT = 0            */  
/***************************************************/

desVar(	  "IS" 1	)
desVar(	  "IT" 0	)
desVar(	  "gm1" gm1	)

analysis('pz ?p ""  ?n ""  ?oprobe "/IPRB0" ?iprobe "/I5"  ?porti "1"  )
analysis('ac ?start "100"  ?stop "300M"  )

envOption(
	'analysisOrder  list("ac" "pz")  
)
save( 'i "/R0/PLUS" )
temp( 27 ) 

run()
selectResult( 'ac )

Gain = i("/R0/PLUS" ?result "ac")
Gain_phase = phaseDeg(Gain)
newWindow()
plot(Gain)
addSubwindowTitle("Gain Magnitude")
addSubwindow
plot(Gain_phase)
addSubwindowTitle("Gain Phase")
addSubwindow
pzPlot( ?result "pz")
addSubwindowTitle("Pole-Zero Gain")

/*****************************************************/
/* Asymptotic Gain                                   */
/* the source must be active (IS=1), the loop closed */
/* with gm -> INF and the test source inactive       */
/*****************************************************/

analysis('ac ?start "100"  ?stop "300M"  ?dec "10"  )
analysis('pz ?p ""  ?n ""  ?oprobe "/IPRB0" ?iprobe "/I5"  ?porti "1"  )

envOption(
        'analysisOrder  list("ac" "pz")
)

desVar(   "IS"  1      )
desVar(   "IT"  0      )
desVar(   "gm1" 1000   )

save( 'i "/R0/PLUS" )

run()

selectResult( 'ac )

Gain = i("/R0/PLUS" ?result "ac")
Gain_phase = phaseDeg(Gain)
newWindow()
plot(Gain)
addSubwindowTitle("Asymtotic Gain Magnitude")
addSubwindow
plot(Gain_phase)
addSubwindowTitle("AsymptoticGain Phase")
addSubwindow
pzPlot( ?result "pz")
addSubwindowTitle("Pole-Zero Asymptotic Gain")

/**********************************************************/
/* Open loop gain                                         */
/* The source must be inactive (IS=0), the loop open      */
/* gm=0, and the a test source inserted IT = 1.           */
/* The returning Vgs is sensed. and Beta (B)is calculated:*/
/* B = Vgs/Itest = Vgs (Itest = 1). Finally the loop gain */
/* is found: AB = B*gm                                    */
/**********************************************************/

analysis('ac ?start "100"  ?stop "300M"  ?dec "10"  )
analysis('pz ?p "/VB"  ?n "" ?iprobe "/I9"  ?porti "1"  )

envOption(
        'analysisOrder  list("ac" "pz")
)

desVar(   "IS"  0      )
desVar(   "IT"  1      )
desVar(   "gm1" 0      )

save( 'v "/VB" )

run()

selectResult( 'ac )

B = v("/VB" ?result "ac")
AB = B*gm1
AB_phase = phaseDeg(AB)

newWindow
plot(AB)
addSubwindowTitle("AB")
addSubwindow
plot(AB_phase)
addSubwindowTitle("AB Phase")
addSubwindow
pzPlot( ?result "pz" )  
addSubwindowTitle("Pole-Zero AB")

/***********************************************/
/* Root-locus                                  */
/* pole-zero of gain is analyzed when          */
/* gm1 is swept from 0 to its nominal value    */
/***********************************************/

analysis('pz ?p ""  ?n ""  ?oprobe "/IPRB0" ?iprobe "/I5"  ?porti "1" ?param "gm1" ?start "0.0"  ?stop gm1  ?step "0.5m" )

envOption(
        'analysisOrder  list("pz")
)

desVar(   "IS"  1      )
desVar(   "IT"  0      )

run()

newWindow
pzPlot( ?result "pz" )  
addSubwindowTitle("Root locus")

; Note: The new Visualization and analysis tool do not display correctly this sweep (it plots Mag, vs quality factor Q). 
; A Workaraound is to open the data manually following these steps:
; 1) Create a new window in the vis. and an. tool
; 2) Go to the menu and select Browser->Results->Open Results. Select the results directory for the sim
; 3) A file three appears in the browser at the left. Select "pz". Under the Signals Tab it should appear 
;    the data saved during the pz simualtion. select both "poles" and "zeros" using Ctrl+click
; 4) Right-click on the selected items and select "Plot Signal"
; 5) The data should be plotted con the window, but it is connecting the points with lines. Right click on
;    the display window and select Type->Scatter Plot

