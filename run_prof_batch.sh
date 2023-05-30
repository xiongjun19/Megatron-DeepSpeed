set -x

sh run_opt_prof.sh  ds_config/ds_config_cpu.json  'cpu' 
sh run_opt_prof.sh  ds_config/ds_config_disk.json 'cpu'

