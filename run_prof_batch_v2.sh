set -x
sync; echo 3 | tee /proc/sys/vm/drop_caches
CUDA_VISIBLE_DEVICES=0,1,2,3,5,6,7,8 sh run_opt_prof.sh  ds_config/ds_config_cpu.json  'cpu_0' 

sync; echo 3 | tee /proc/sys/vm/drop_caches
CUDA_VISIBLE_DEVICES=0,1,2,4,5,6,7,9 sh run_opt_prof.sh  ds_config/ds_config_cpu.json  'cpu_2' 

sync; echo 3 | tee /proc/sys/vm/drop_caches
CUDA_VISIBLE_DEVICES=0,1,2,3,5,6,7,8 sh run_opt_prof_dp2.sh  ds_config/ds_config_cpu_dp2.json  'cpu_0' 

sync; echo 3 | tee /proc/sys/vm/drop_caches
CUDA_VISIBLE_DEVICES=0,1,2,4,5,6,7,9 sh run_opt_prof_dp2.sh  ds_config/ds_config_cpu_dp2.json  'cpu_2' 

# sync; echo 3 | tee /proc/sys/vm/drop_caches
# sh run_opt_prof_dp2.sh  ds_config/ds_config_disk_dp2.json 'disk'

