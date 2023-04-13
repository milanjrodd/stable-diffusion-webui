#!/bin/bash

# Accept model directory as a command-line argument
model_dir="${1:-./models/Stable-diffusion}"

# Define model download URLs and corresponding config URLs

  # "https://huggingface.co/stabilityai/stable-diffusion-2/resolve/main/768-v-ema.ckpt"
  # "https://huggingface.co/stabilityai/stable-diffusion-2-inpainting/resolve/main/512-inpainting-ema.ckpt"

  # "https://raw.githubusercontent.com/Stability-AI/stablediffusion/main/configs/stable-diffusion/v2-inference-v.yaml"
  # "https://raw.githubusercontent.com/Stability-AI/stablediffusion/main/configs/stable-diffusion/v2-inference-v.yaml"
models=(
  "https://huggingface.co/runwayml/stable-diffusion-inpainting/resolve/main/sd-v1-5-inpainting.ckpt"
  "https://huggingface.co/stabilityai/stable-diffusion-2-1/resolve/main/v2-1_768-ema-pruned.ckpt"
)

configs=(
  ""
  "https://raw.githubusercontent.com/Stability-AI/stablediffusion/main/configs/stable-diffusion/v2-inference-v.yaml"
)

# Create model directory if it doesn't exist
mkdir -p "$model_dir"

# Download models and configs
for i in "${!models[@]}"; do
  model_url="${models[$i]}"
  config_url="${configs[$i]}"
  model_filename=$(basename "$model_url")
  config_filename="${model_filename%.*}.yaml"

  # Download model
  echo "Downloading model: $model_filename"
  curl -L "$model_url" --create-dirs -o "$model_dir/$model_filename"

  # Download config if available
  if [ -n "$config_url" ]; then
    echo "Downloading config: $config_filename"
    curl -L "$config_url" --create-dirs -o "$model_dir/$config_filename"
  fi
done
