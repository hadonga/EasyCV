docker build -t easycv_${1} .

docker run -itd \
        --gpus all \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v /data:/data \
        --privileged \
        --network=host \
        easycv_${1}