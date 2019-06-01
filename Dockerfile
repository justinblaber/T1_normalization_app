FROM ubuntu:18.04

# Update
RUN apt-get -y update

# Install git
RUN apt-get -y install git

# Download stuff from repo
RUN mkdir /extra && \
    cd /extra && \
    git clone https://github.com/justinblaber/T1_normalization_app.git && \
    mv T1_normalization_app/extra/* . && \
    rm -rf T1_normalization_app

# Install stuff
RUN mkdir /INPUTS && \
    mkdir /OUTPUTS && \
    apt-get -y install libgomp1 && \
    apt-get -y install tcsh && \
    apt-get -y install bc && \
    apt-get -y install perl 

# Set CMD
CMD /extra/pipeline.sh
