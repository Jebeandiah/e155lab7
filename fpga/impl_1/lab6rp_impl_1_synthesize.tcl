if {[catch {

# define run engine funtion
source [file join {C:/lscc/radiant/2026.1} scripts tcl flow run_engine.tcl]
# define global variables
global para
set para(gui_mode) "1"
set para(prj_dir) "C:/Users/blertwachara/Documents/GitHub/e155lab7/fpga"
if {![file exists {C:/Users/blertwachara/Documents/GitHub/e155lab7/fpga/impl_1}]} {
  file mkdir {C:/Users/blertwachara/Documents/GitHub/e155lab7/fpga/impl_1}
}
cd {C:/Users/blertwachara/Documents/GitHub/e155lab7/fpga/impl_1}
# synthesize IPs
# synthesize VMs
# propgate constraints
file delete -force -- lab6rp_impl_1_cpe.ldc
::radiant::runengine::run_engine_newmsg cpe -syn lse -f "lab6rp_impl_1.cprj" -a "iCE40UP"  -o lab6rp_impl_1_cpe.ldc
# synthesize top design
file delete -force -- lab6rp_impl_1.vm lab6rp_impl_1.ldc
::radiant::runengine::run_engine_newmsg synthesis -f "C:/Users/blertwachara/Documents/GitHub/e155lab7/fpga/impl_1/lab6rp_impl_1_lattice.synproj" -logfile "lab6rp_impl_1_lattice.srp"
::radiant::runengine::run_postsyn [list -a iCE40UP -p iCE40UP5K -t UWG30 -sp High-Performance_1.2V -oc Industrial -top -w -o lab6rp_impl_1_syn.udb lab6rp_impl_1.vm] [list lab6rp_impl_1.ldc]

} out]} {
   ::radiant::runengine::runtime_log $out
   exit 1
}
