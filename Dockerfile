####################################################################
# PROGRAMMER: Pierre-Antoine Ksinant                               #
# DATE CREATED: 18/03/2020                                         #
# REVISED DATE: -                                                  #
# PURPOSE: Dockerfile for Flowers Taxonomic Classification web app #
####################################################################

# Reference: https://hub.docker.com/r/continuumio/miniconda3
FROM continuumio/miniconda3

# Metadata associated to the image:
MAINTAINER Pierre-Antoine Ksinant
LABEL description="Flowers Taxonomic Classification Web App, with Streamlit"
LABEL version="1.0"

# Create app architecture:
COPY app_streamlit.py /home/app_streamlit.py
COPY utils.py /home/utils.py
COPY images/web_app_logo.jpg /home/images/web_app_logo.jpg
COPY data/cat_to_name.json /home/data/cat_to_name.json
COPY data/class_to_idx.json /home/data/class_to_idx.json
COPY models/best-model_CUDA.pth /home/models/best-model_CUDA.pth
COPY models/best-model_CPU.pth /home/models/best-model_CPU.pth
COPY inference/ /home/inference/

# Install required packages:
RUN conda install -c anaconda python==3.6.10
RUN conda install pytorch==1.0.0 torchvision==0.2.1 -c pytorch
RUN conda install matplotlib==3.1.3 -c conda-forge
RUN pip install streamlit==0.56.0
RUN pip install pillow==6.2.1

# Run Web App:
EXPOSE 8501
WORKDIR home/
CMD streamlit run app_streamlit.py