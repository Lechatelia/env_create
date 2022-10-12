

if ! [ -x "$(command -v conda)" ]; then
  echo nvcc is not available
else
  echo nvcc is available
fi