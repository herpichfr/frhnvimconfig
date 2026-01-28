#!/bin/bash

# This script retrieves the current GPU load percentage using
# nvidia-smi for NVIDIA GPUs or nvtop for intel gpus or
# amd_gpu_top for AMD GPUs.

function get_gpu_load() {
  # Check for NVIDIA GPU
  if command -v nvidia-smi &> /dev/null; then
      GPU_LOAD=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
  elif command -v nvtop &> /dev/null; then
      # Check for Intel GPU
      GPU_LOAD=$(nvtop --query-gpu=utilization.gpu --format=csv,noheader,nounits)
  elif command -v amd_gpu_top &> /dev/null; then
      # Check for AMD GPU
      GPU_LOAD=$(amd_gpu_top --json | jq '.gpus[0].load' | head -n 1)
  else
      GPU_LOAD="0"
  fi
}

function define_colours() {
  # return background and forwground colours based on GPU load
  if [ "$GPU_LOAD" -ge 80 ]; then
      BG_COLOR="#[bg=red]#[fg=white]"
  elif [ "$GPU_LOAD" -ge 50 ]; then
      BG_COLOR="#[bg=yellow]#[fg=black]"
  # elif [ "$GPU_LOAD" -ge 20 ]; then
      # BG_COLOR="#[bg=green]#[fg=black]"
  else
      BG_COLOR="#[bg=default]#[fg=default]"
  fi
}

get_gpu_load
define_colours
echo "$BG_COLOR GPU: $GPU_LOAD% #[fg=default]#[bg=default]"
