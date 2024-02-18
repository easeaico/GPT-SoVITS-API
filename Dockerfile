# Base CUDA image
FROM cnstark/pytorch:2.0.1-py3.9.17-cuda11.8.0-ubuntu20.04

LABEL maintainer="breakstring@hotmail.com"
LABEL version="dev-20240127"
LABEL description="Docker image for GPT-SoVITS-API"


# Install 3rd party apps
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

ARG port
ARG gpt_weights
ARG sovits_weights

RUN apt-get update && \
  apt-get install -y --no-install-recommends tzdata ffmpeg libsox-dev parallel aria2 git git-lfs && \
  rm -rf /var/lib/apt/lists/* && \
  git lfs install

# Copy application
WORKDIR /workspace
COPY . /workspace

# Install python packages
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && pip install --no-cache-dir -r requirements.txt

# Download nltk realted
RUN python -m nltk.downloader averaged_perceptron_tagger
RUN python -m nltk.downloader cmudict

EXPOSE ${port}

VOLUME /workspace/output
VOLUME /workspace/logs
VOLUME /workspace/SoVITS_weights
VOLUME /workspace/GPT_weights

CMD python api.py -a 0.0.0.0 -p ${port} -s ${sovits_weights} -g ${gpt_weights}
