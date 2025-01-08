# !/bin/bash

DATE=`date '+%m%d'`

scene_idx=700
start_timestep=1
end_timestep=100
# reduce num_iters to 8000 for debugging
num_iters=8000

output_root="/home/output"
project=scene_reconstruction

# use default_config.yaml for static scenes
# for novel view synthesis, change test_image_stride to 10
# with flow field
python3 train_emernerf.py \
    --config_file configs/default_flow.yaml \
    --output_root $output_root \
    --project $project \
    --run_name ${scene_idx}_flow \
    data.scene_idx=$scene_idx \
    data.start_timestep=$start_timestep \
    data.end_timestep=$end_timestep \
    logging.saveckpt_freq=$num_iters \
    optim.num_iters=$num_iters