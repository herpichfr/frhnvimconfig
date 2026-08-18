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
      # nvtop will print GPU utilization for all cards available. Pick the one
      # identified as Intel in the "device_name" field.
      # The output of nvtop -s is the following JSON structure:
      # {
      #    "device_name": "Arrow Lake-S (Intel Graphics)",
      #    "gpu_clock": "1000MHz",
      #    "mem_clock": null,
      #    "temp": null,
      #    "fan_speed": "CPU Fan",
      #    "power_draw": null,
      #    "gpu_util": null,
      #    "mem_util": null
      #   },
      #   {
      #    "device_name": "NVIDIA RTX A1000",
      #    "gpu_clock": "495MHz",
      #    "mem_clock": "810MHz",
      #    "temp": "43C",
      #    "fan_speed": "30%",
      #    "power_draw": null,
      #    "gpu_util": "41%",
      #    "mem_util": "15%"
      #   }
      GPU_LOAD=$(nvtop -s json | jq -r '.[] | select(.device_name | test("Intel"; "i")) | .gpu_util' | tr -d '%')
  elif command -v amd_gpu_top &> /dev/null; then
      # Check for AMD GPU
      # TODO: To be implemented
      # GPU_LOAD=$(amd_gpu_top --json | jq '.gpus[0].load' | head -n 1)
      GPU_LOAD="0"
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
