FROM pytorch/pytorch:1.13.1-cuda11.6-cudnn8-devel
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul

# set working directory 
RUN mkdir -p /workspace/EasyCV
WORKDIR /workspace

# set userinfo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# copy EasyCV to workspace
COPY ./ /workspace/EasyCV

# install denpendies
RUN apt-get update && apt-get install -y fish
RUN pip install mmcv-full==1.7.1 -f https://download.openmmlab.com/mmcv/dist/cu116/torch1.13/index.html
RUN pip install https://developer.download.nvidia.com/compute/redist/nvidia-dali-cuda100/nvidia_dali_cuda100-0.25.0-1535750-py3-none-manylinux2014_x86_64.whl

WORKDIR /workspace/EasyCV
RUN pip install -r ./requirements/runtime.txt 
RUN python setup.py develop
# RUN pip install torch==1.13.1+cu116 torchvision==0.14.1+cu116 torchaudio==0.13.1 --extra-index-url https://download.pytorch.org/whl/cu116

# # # install sapeon sdk
# RUN dpkg -i /workspace/sapeon-sdk_1.5.4.deb


# others
# install onnx and pai_nni
RUN pip install onnx
RUN pip install https://pai-nni.oss-cn-zhangjiakou.aliyuncs.com/release/2.5/pai_nni-2.5-py3-none-manylinux1_x86_64.whl

# install blade_compression
RUN pip install http://pai-vision-data-hz.oss-cn-zhangjiakou.aliyuncs.com/third_party/blade_compression-0.0.1-py3-none-any.whl
