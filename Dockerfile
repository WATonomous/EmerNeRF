FROM nvcr.io/nvidia/cuda:11.7.1-devel-ubuntu22.04
ARG CUDA_ARCHITECTURES=90;89;86;80;75;70;61;52;37
# ARG DEBIAN_FRONTEND noninteractive

RUN apt update -y
RUN apt install -y libgl1-mesa-glx

# Install python pip
RUN apt install -y software-properties-common && add-apt-repository ppa:deadsnakes/ppa && apt update -y && apt install -y \
    python3-pip \
    git \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Install pip dependencies
ADD ./ /home/docker/EmerNeRF
COPY ../wato_dense_prediction/data-included/waymo-processed/ /home/docker/EmerNeRF/data/waymo/processed
RUN pip3 install --no-cache-dir -r /home/docker/EmerNeRF/requirements.txt 
RUN pip3 install nerfacc
ENV TCNN_CUDA_ARCHITECTURES=${CUDA_ARCHITECTURES}
RUN pip3 install git+https://github.com/NVlabs/tiny-cuda-nn/#subdirectory=bindings/torch

RUN pip3 install "opencv-python==4.8.0.74"
RUN pip3 install nerfstudio

# Install waymo waymo-open-dataset-tf-2-11-0==1.5.2 later

# CMD ["sleep", "inf"]
CMD ["bash"]