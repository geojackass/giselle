# Anaconda image
FROM continuumio/anaconda3:2023.09-0

LABEL MAINTAINER SHOICHI OTOMO <geojackass.shoichi0129@gmail.com>

# 日本語フォントとライブラリをインストール
RUN pip install --upgrade pip && \
    pip install graphviz pydotplus

RUN apt-get update && \
    apt-get install -y fonts-takao-gothic graphviz

# Cのブリッジが必要なのでcythonのinstall
RUN pip install cython

# git setting up
RUN apt install git -y
RUN cd

# docker image作成時にcontainer内でエディター外使用できるように設定
RUN ["apt-get", "install", "-y", "vim"]

# githubからjageocoder2023/11/04 時点のjageocoderをcloneする
# jageocoderにPATHの設定を行う
RUN git clone https://github.com/geojackass/jageocoder.git && \
    cd jageocoder && \
    pip install jageocoder && \
    export PATH="$PATH:/home/shoichi/.local/bin" 

# 作業ディレクトリを作成
WORKDIR /workdir

# jageocoder用の辞書データの取得，解凍，及びDB化用 shell 2023/11/04
# 帳の中で実行
COPY act-1.sh /workdir

# コンテナ側のリッスンポート
EXPOSE 8888

ENTRYPOINT ["jupyter-lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
CMD ["--notebook-dir=/workdir"] 