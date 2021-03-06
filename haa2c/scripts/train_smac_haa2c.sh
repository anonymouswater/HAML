#!/bin/sh
env="StarCraft2"
map="3s_vs_5z"
algo="haa2c"
exp="mlp"
echo "env is ${env}, map is ${map}, algo is ${algo}, exp is ${exp}, max seed is ${seed_max}"
for number in {6,42,7654,9876,12321}
do
    echo "the ${number}-th running:"
    CUDA_VISIBLE_DEVICES=0 python train/train_smac.py --env_name ${env} --algorithm_name ${algo} --experiment_name ${exp} --map_name ${map} --runing_id ${number} --n_training_threads 64 --n_rollout_threads 8 --num_mini_batch 1 --episode_length 400 --num_env_steps 5000000 --ppo_epoch 5 --stacked_frames 1 --use_value_active_masks --use_eval --add_center_xy --seed_specify --share_policy --same_critic &
done
