set -x
sync; echo 3 | tee /proc/sys/vm/drop_caches
sh run_opt_prof.sh  ds_config/ds_config_cpu.json  'cpu' 

sync; echo 3 | tee /proc/sys/vm/drop_caches
sh run_opt_prof.sh  ds_config/ds_config_disk.json 'cpu'

