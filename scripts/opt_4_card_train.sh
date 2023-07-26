cfg_path="$1"
policy=$2

WORLD_SIZE=4
TENSOR_MP_SIZE=4
PIPELINE_MP_SIZE=1

DISTRIBUTED_ARGS="--nproc_per_node $WORLD_SIZE \
                  --nnodes 1 \
                  --node_rank 0 \
                  --master_addr localhost \
                  --master_port 6000"

CHECKPOINT_PATH="data/models/checkpoints/gpt2_13B"
VOCAB_FILE="data/models/gpt2-vocab.json"
MERGE_FILE="data/models/gpt2-merges.txt"
DATA_PATH="data/dataset/gpt2_wiki_text_document"
bs=8
g_bs=8
base_f=opt-13b_${policy}_${bs}
gpu_log="${gpu_logs}/${base_f}.qdrep"
cpu_log="${cpu_logs}/${base_f}.txt"


GPT_ARGS="--num-layers 40 --hidden-size 5120 --num-attention-heads 40  --seq-length 1024 \
	  --max-position-embeddings 1024 --micro-batch-size ${bs} --global-batch-size ${g_bs} \
	  --lr 0.00015 --train-iters 500000 --lr-decay-iters 320000 --lr-decay-style cosine \
	  --vocab-file $VOCAB_FILE --merge-file $MERGE_FILE --lr-warmup-fraction .01 --fp16 \
	  --tensor-model-parallel-size $TENSOR_MP_SIZE --no-pipeline-parallel "
          
OUTPUT_ARGS="--log-interval 10 \
             --save-interval 500 \
             --eval-interval 100 \
             --eval-iters 10 \
             --checkpoint-activations"
ds_args="--deepspeed --deepspeed_config ${cfg_path}"

python -m torch.distributed.launch ${DISTRIBUTED_ARGS} pretrain_gpt.py $GPT_ARGS $OUTPUT_ARGS --save $CHECKPOINT_PATH   --data-path $DATA_PATH ${ds_args}

