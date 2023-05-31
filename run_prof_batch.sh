set -x
sync; echo 3 | tee /proc/sys/vm/drop_caches
#sh run_opt_prof.sh  ds_config/ds_config_cpu.json  'cpu' 
sh run_opt_prof_dp2.sh  ds_config/ds_config_cpu_dp2.json  'cpu' 

sync; echo 3 | tee /proc/sys/vm/drop_caches
sh run_opt_prof_dp2.sh  ds_config/ds_config_disk_dp2.json 'disk'

