simulator( 'spectre )
design(	 "/home/saul/projects/test_xfab1/Sim/FAST_BIAS/spectre/schematic/netlist/netlist")
resultsDir( "/home/saul/projects/test_xfab1/Sim/FAST_BIAS/spectre/schematic" )

load("OS/CHARACTERIZATION/global.il")

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
analysis('dc ?saveOppoint t  )
desVar(	  "WF1" WF1	)
desVar(	  "L1" L1	)
desVar(	  "NF1" NF1	)
desVar(	  "IDS1" IDS1	)
desVar(	  "VDS1" VDS1	)
envOption(
	'analysisOrder  list("dc") 
)
temp( 27 ) 
run()


selectResults('dcOpInfo)

gm1 = getData("I0.M0.m1")->gm
gm1 = getData("I0.M0.m1")->gm
rds1 = 1/getData("I0.M0.m1")->gds
cgd1 = 1e15*mag(getData("I0.M0.m1")->cgd)
cgs1 = 1e15*mag(getData("I0.M0.m1")->cgs)
cds1 = 1e15*mag(getData("I0.M0.m1")->cds)
cdb1 = 1e15*mag(getData("I0.M0.m1")->cdb)
vgs1 = getData("I0.M0.m1")->vgs
G1 = gm1*rds1
gm_id1 = gm1/IDS1
Ft1 = gm1/(2*3.1415927*(cgs1+cgd1))*1e15/1e6 ;Ft in MHz

;****** Printing Results on the CIW log ********

printf("\n\n\n***********************\n")
printf("* FAST BIASING RESULTS *  \n")
printf("***********************\n\n")

printf("NMOS1: W1_tot = %4.2fum  L1 = %4.2fum  IDS1 = %4.4fmA  VDS1 = %4.2fV\n" 1e6*(WF1*NF1) 1e6*L1 1e3*IDS1 VDS1)
printf("  gm1 = %4.3fm\n  rds1 = %4.2f\n  cgs1 = %4.2ff\n  cgd1 = %4.2ff\n  cds1 = %4.2ff\n  cdb1 = %4.2ff\n  vgs1 = %5.4f\n  Gain1 = %4.2f\n" 1e3*gm1 rds1 cgs1 cgd1 cds1 cdb1 vgs1 G1)
printf("  gm_id1 = %4.2f\n  Ft1 = %4.2f MHz \n\n" gm_id1 Ft1)
