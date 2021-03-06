#!/bin/sh
env="mujoco"
scenario="HalfCheetah-v2"
agent_conf="6x1"
agent_obsk=1
algo="maa2c"
exp="mlp_ppo10_noshare_lr=1e-4_clr1e-3_mb=1"
running_max=1
kl_threshold=2e-4
echo "env is ${env}, scenario is ${scenario}, algo is ${algo}, exp is ${exp}, max seed is ${seed_max}"
for number in {6,42,7654,9876,12321}
do
    echo "the ${number}-th running:"
    CUDA_VISIBLE_DEVICES=1 python train/train_mujoco.py --env_name ${env} --algorithm_name ${algo} --experiment_name ${exp} --scenario ${scenario} --agent_conf ${agent_conf} --agent_obsk ${agent_obsk} --lr 1e-4 --critic_lr 1e-3 --std_x_coef 1 --std_y_coef 5e-1 --runing_id ${number} --n_training_threads 8 --n_rollout_threads 4 --num_mini_batch 1 --episode_length 1000 --num_env_steps 5000000 --ppo_epoch 10 --kl_threshold ${kl_threshold} --use_value_active_masks --use_eval --add_center_xy --use_state_agent --share_policy --seed_specify --cuda --use_global_id --same_critic &
done
