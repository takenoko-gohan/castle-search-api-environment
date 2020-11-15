ARG ELASTIC_VER=7.8.1
ARG SUDACHI_PLUGIN_VER=2.0.3

FROM ibmjava:8-jre-alpine as dict_builder

ARG ELASTIC_VER
ARG SUDACHI_PLUGIN_VER

COPY es/dic/castle_dic.csv /home

WORKDIR /home

RUN wget https://github.com/WorksApplications/elasticsearch-sudachi/releases/download/v${ELASTIC_VER}-${SUDACHI_PLUGIN_VER}/analysis-sudachi-${ELASTIC_VER}-${SUDACHI_PLUGIN_VER}.zip && \
    unzip analysis-sudachi-${ELASTIC_VER}-${SUDACHI_PLUGIN_VER}.zip && \
    wget https://object-storage.tyo2.conoha.io/v1/nc_2520839e1f9641b08211a5c85243124a/sudachi/sudachi-dictionary-20200722-core.zip && \
    unzip sudachi-dictionary-20200722-core.zip && \
    java -Dfile.encoding=UTF-8 -cp /home/sudachi-0.4.3.jar com.worksap.nlp.sudachi.dictionary.UserDictionaryBuilder -o /home/castle.dic -s /home/sudachi-dictionary-20200722/system_core.dic /home/castle_dic.csv

FROM docker.elastic.co/elasticsearch/elasticsearch:${ELASTIC_VER}

ARG ELASTIC_VER
ARG SUDACHI_PLUGIN_VER

COPY es/sudachi/sudachi.json /usr/share/elasticsearch/config/sudachi/

COPY --from=dict_builder /home/sudachi-dictionary-20200722/system_core.dic /usr/share/elasticsearch/config/sudachi/

COPY --from=dict_builder /home/castle.dic /usr/share/elasticsearch/config/sudachi/

COPY --from=dict_builder /home/analysis-sudachi-${ELASTIC_VER}-${SUDACHI_PLUGIN_VER}.zip /usr/share/elasticsearch/

RUN curl -OL https://object-storage.tyo2.conoha.io/v1/nc_2520839e1f9641b08211a5c85243124a/sudachi/sudachi-dictionary-20200722-full.zip &&  \
    unzip -o -d config/sudachi -j  'sudachi-dictionary*.zip'  && \
    rm -f sudachi-dictionary*.zip && \
    bin/elasticsearch-plugin install file:///usr/share/elasticsearch/analysis-sudachi-${ELASTIC_VER}-${SUDACHI_PLUGIN_VER}.zip && \
    rm /usr/share/elasticsearch/analysis-sudachi-${ELASTIC_VER}-${SUDACHI_PLUGIN_VER}.zip
    