;====================== Set to XL mode =========================================
ocnSetXLMode()
ocnxlProjectDir( "./Sim" )
ocnxlTargetCellView( "CHARACTERIZATION" "NOISE_NMOS" "adexl" )
ocnxlResultsLocation( "" )
ocnxlSimResultsLocation( "" )
ocnxlMaxJobFail( 20 )

;====================== Tests setup ============================================

;---------- Test "CHARACTERIZATION:NOISE_NMOS:1" ------------- 
ocnxlBeginTest("CHARACTERIZATION:NOISE_NMOS:1")
simulator( 'spectre )
design( "CHARACTERIZATION" "NOISE_NMOS" "schematic")
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
analysis('noise ?start "0.01"  ?stop "100G"  ?dec "10"  
		?oprobe "/IPRB1"  ?iprobe "/V2"  )
desVar(	  "IDS" 10u	)
desVar(	  "L" 1u	)
desVar(	  "NF" 1	)
desVar(	  "VDS" 1	)
desVar(	  "WF" 10u	)
envOption(
	'firstRun  t 
	'analysisOrder  list("dc" "noise" "pz" "dcmatch" "stb" "tran" "envlp" "ac" "lf" "xf" "sp" "pss" "pac" "pstb" "pnoise" "pxf" "psp" "qpss" "qpac" "qpnoise" "qpxf" "qpsp" "hb" "hbac" "hbstb" "hbnoise" "hbxf" "sens" "acmatch") 
)
temp( 27 ) 
ocnxlOutputExpr( "getData(\"in\" ?result \"noise\")" ?name "input noise; A / sqrt(Hz)" ?plot t)
ocnxlEndTest() ; "CHARACTERIZATION:NOISE_NMOS:1"

;---------- Test "CHARACTERIZATION:NOISE_NMOS:2" ------------- 
ocnxlBeginTest("CHARACTERIZATION:NOISE_NMOS:2")
simulator( 'spectre )
design( "CHARACTERIZATION" "NOISE_NMOS" "schematic")
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
analysis('noise ?start "0.01"  ?stop "100G"  ?dec "10"  
		?oprobe "/IPRB0"  ?iprobe "/I6"  )
desVar(	  "IDS" 10u	)
desVar(	  "L" 1u	)
desVar(	  "NF" 1	)
desVar(	  "VDS" 1	)
desVar(	  "WF" 10u	)
envOption(
	'firstRun  t 
	'analysisOrder  list("dc" "noise" "pz" "dcmatch" "stb" "tran" "envlp" "ac" "lf" "xf" "sp" "pss" "pac" "pstb" "pnoise" "pxf" "psp" "qpss" "qpac" "qpnoise" "qpxf" "qpsp" "hb" "hbac" "hbstb" "hbnoise" "hbxf" "sens" "acmatch") 
)
temp( 27 ) 
ocnxlOutputExpr( "getData(\"in\" ?result \"noise\")" ?name "input noise; A / sqrt(Hz)" ?plot t)
ocnxlEndTest() ; "CHARACTERIZATION:NOISE_NMOS:2"

;====================== Sweeps setup ===========================================
ocnxlSweepVar("IDS" "10u")
ocnxlSweepVar("L" "1u")
ocnxlSweepVar("NF" "1")
ocnxlSweepVar("VDS" "1")
ocnxlSweepVar("WF" "10u")

;====================== Model Group setup ==========================================

;====================== Corners setup ==========================================

;====================== Checks and Asserts setup ============================================
ocnxlPutChecksAsserts(?netlist nil)

;====================== Job setup ==============================================
ocnxlJobSetup( '(
	"blockemail" "1"
	"configuretimeout" "300"
	"distributionmethod" "Local"
	"jobruntype" "ICRP"
	"estimatememoryvalue" ""
	"lingertimeout" "300"
	"maxjobs" "1"
	"name" "ADE XL Default"
	"preemptivestart" "1"
	"reconfigureimmediately" "1"
	"runtimeout" "-1"
	"showerrorwhenretrying" "1"
	"showoutputlogerror" "0"
	"startmaxjobsimmed" "1"
	"starttimeout" "300"
	"usesameprocess" "1"
) )

;====================== Disabled items =========================================

;====================== Run Mode Options ======================================

;====================== Starting Point Info ======================================

;====================== Run command ============================================
ocnxlRun( ?mode 'sweepsAndCorners ?nominalCornerEnabled t ?allCornersEnabled t ?allSweepsEnabled t)
ocnxlOutputSummary(?exprSummary t ?specSummary t ?detailed t ?wave t)
ocnxlOpenResults()

ocnxlOpenResults(?testName "CHARACTERIZATION:NOISE_NMOS:1")
selectResults('noise)

vn_in = getData("in" ?result "noise")
vn_in_dB = dB20(vn_in)

;====================== End XL Mode command ===================================
ocnxlEndXLMode()





