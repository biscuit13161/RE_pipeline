#Download base image Centos 7
FROM centos:7

# Update Centos
#RUN yum update
RUN yum -y install yum-utils make wget xz-devel unzip epel-release gcc-gfortran libXt-devel libcurl-devel 
RUN yum-builddep -y python

# Install Python 3 and pysam
RUN wget https://www.python.org/ftp/python/3.5.0/Python-3.5.0.tgz && \
    tar xf Python-3.5.0.tgz && \
    cd Python-3.5.0 && \
    ./configure && \
    make && \
    make install && \
    cd ..

RUN pip3 install --upgrade pip && \
    pip3 install pysam

# Install Bowtie2
RUN wget https://excellmedia.dl.sourceforge.net/project/bowtie-bio/bowtie2/2.3.4.1/bowtie2-2.3.4.1-linux-x86_64.zip && \
    unzip bowtie2-2.3.4.1-linux-x86_64.zip && \
    cp bowtie2-2.3.4.1-linux-x86_64/bowtie2* /usr/local/bin/.

# Install OpenJDK 9
RUN yum -y install java-1.8.0-openjdk-headless java-1.8.0-openjdk-devel

# Install Samtools
#RUN wget  https://github.com/samtools/htslib/releases/download/1.8/htslib-1.8.tar.bz2 https://github.com/samtools/samtools/releases/download/1.8/samtools-1.8.tar.bz2 && \
#    tar -jxf samtools-1.8.tar.bz2 && \
#    tar -jxf htslib-1.8.tar.bz2 && \
#    cd htslib-1.8 && \
#   ./configure && \
#    make && \
#    make install && \
#    cd ../samtools-1.8 && \
#    ./configure && \
#    make && \
#    make install && \
#    cd ..

RUN wget https://excellmedia.dl.sourceforge.net/project/samtools/samtools/0.1.18/samtools-0.1.18.tar.bz2 && \
    tar -jxf samtools-0.1.18.tar.bz2 && \
    cd samtools-0.1.18 && \
    make && \
    find . -perm -111 -type f -exec cp '{}' /usr/local/bin/. \;

# Install R

RUN yum-builddep -y R
#RUN yum -y install texlive-latex-bin-bin texinfo texinfo-tex which


RUN wget https://cloud.r-project.org/src/base/R-3/R-3.5.0.tar.gz && \
tar -zxf R-3.5.0.tar.gz && \
cd R-3.5.0 && \
./configure && \
make && \
cd ..

# Install Bedtools
RUN wget https://github.com/arq5x/bedtools2/releases/download/v2.25.0/bedtools-2.25.0.tar.gz && \
    tar -zxvf bedtools-2.25.0.tar.gz && \
    cd bedtools2 && \
    make && \
    cp bin/* /usr/local/bin/. && \
    cd ..

# Install Cufflinks
RUN wget http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz && \
    tar -zxf cufflinks-2.2.1.Linux_x86_64.tar.gz && \
    cd cufflinks-2.2.1.Linux_x86_64 && \
    find . -perm -111 -type f -exec cp '{}' /usr/local/bin/. \; && \
    cd ..

# Get LIONS
RUN wget https://github.com/mmkarimi1/RE_pipeline/archive/master.zip && \
    unzip master.zip
#git clone https://github.com/mmkarimi1/RE_pipeline.git

WORKDIR RE_pipeline-master/