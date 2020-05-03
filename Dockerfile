FROM pytorch/pytorch:latest
RUN apt-get update && apt-get install git gcc clang g++ cmake libsndfile1-dev wget unzip curl -y
RUN pip install -q parallel_wavegan PyYaml unidecode ConfigArgparse g2p_en nltk cython chainer sndfile flask
RUN git clone -q https://github.com/espnet/espnet.git
RUN cd espnet && git fetch && git checkout -b v.0.6.1 1e8b6ce88d57b53d1b60cbb3f306652468b0ab63
RUN mkdir tools && cd tools && git clone https://github.com/r9y9/hts_engine_API.git
RUN cd tools/hts_engine_API/src/ && ./waf configure && ./waf build install
RUN cd tools/ && git clone https://github.com/r9y9/open_jtalk.git
RUN mkdir -p tools/open_jtalk/src/build && cd tools/open_jtalk/src/build && cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON .. && make install
RUN cp tools/open_jtalk/src/build/*.so* ../usr/lib
RUN cd tools && git clone https://github.com/r9y9/pyopenjtalk.git
RUN cd tools/pyopenjtalk && pip install .
RUN ./espnet/utils/download_from_google_drive.sh 'https://drive.google.com/open?id=1OwrUQzAmvjj1x9cDhnZPp6dqtsEqGEJM' 'downloads/jp/tacotron2' 'tar.gz'
RUN ./espnet/utils/download_from_google_drive.sh 'https://drive.google.com/open?id=1kp5M4VvmagDmYckFJa78WGqh1drb_P9t' 'downloads/jp/tacotron2' 'tar.gz' 
RUN mkdir /audio
EXPOSE 1337
COPY app.py .
CMD python app.py
#TODO: download the openjtalk dictionary so it doesn't get re-downloaded every init. Seems like you'll just need to download/untar and then set the env variable
#see https://github.com/r9y9/pyopenjtalk/blob/master/pyopenjtalk/__init__.py for relavant initialization code