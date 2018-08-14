# Hall A/C software
#
# A container for the latest root
#
FROM whit2333/root_base
LABEL maintainer "Whitney Armstrong <warmstrong@anl.gov>"

SHELL ["/bin/bash", "-c"]

#USER root
# Build root from the repo master
RUN cd /tmp && source /usr/local/bin/thisroot.sh \
      && git clone https://github.com/whit2333/cool_halls.git \
      && mkdir -p cool_halls/build \
      && cd cool_halls/build \
      && cmake ../. \
      && make \
      && cd /tmp && rm -rf /tmp/cool_halls 

RUN apt-get update && apt-get upgrade -y && apt-get install -y libcurl4-gnutls-dev && cd /tmp && git clone --depth=1 https://github.com/nlohmann/json.git \
    && mkdir json/build && cd json/build && cmake ../. -DBUILD_TESTING=OFF \
    && make -j3 install && cd /tmp && rm -rf json \
    && git clone --depth=1 https://github.com/ericniebler/range-v3.git \
    && mkdir range-v3/build && cd range-v3/build \
    && cmake ../. -DBUILD_TESTING=OFF -DRANGE_V3_PERF=OFF && make -j3 install \
    && cd /tmp && rm -r range-v3 && git clone https://github.com/fmtlib/fmt.git \
    && mkdir fmt/build && cd fmt/build && cmake ../. -DFMT_TEST=OFF && make -j4 install \
    && cd /tmp && rm -r fmt && git clone https://github.com/HowardHinnant/date.git \
    && mkdir date/build && cd date/build  && cmake ../. -DENABLE_DATE_TESTING=OFF && make -j4 install 

#RUN useradd -ms /bin/bash -d /opt/user user
#USER user
#WORKDIR /opt/bubble_user

##CMD ["-c" ]
ENTRYPOINT ["/bin/bash"]

#CMD ["-b" ]
#ENTRYPOINT ["root","-l"]

#RUN  cd /tmp \
#      && rm -r builds/clhep_build
#
#RUN ls -lrth /usr/local/lib/libRIO*
#RUN cd /tmp && pwd && ls -lrth
#RUN cd /tmp \
#      && wget http://geant4.web.cern.ch/geant4/support/source/geant4.10.04.tar.gz \
#      && tar -zxf geant4.10.04.tar.gz && rm geant4.10.04.tar.gz \
#      && mkdir -p builds/geant4_build \
#      && cd builds/geant4_build \
#      && cmake \
#        -DGEANT4_USE_GDML:BOOL=ON \
#        -DGEANT4_USE_QT:BOOL=ON \
#        -DGEANT4_USE_SYSTEM_CLHEP:BOOL=ON \
#        -DGEANT4_INSTALL_DATA=ON \
#        -DGEANT4_BUILD_CXXSTD:STRING=14 \
#        ../../geant4.10.04 \
#      && make -j37 install \
#      && cd /tmp && rm -rf /tmp/geant4.10.03.p02 && rm -rf /tmp/builds/geant4_build
#RUN cd /tmp \
#      && rm -r builds/geant4_build
#RUN cd /tmp && pwd && ls -lrth
#RUN source /usr/local/bin/thisroot.sh  \
#      && source /usr/local/bin/geant4.sh \
#RUN ["/bin/bash", "-c", "source /usr/local/bin/thisroot.sh \
#      && cd /tmp \
#      && ls -lrth \
#      && ls -lrth /usr/local/bin/* \
#      && git clone --depth=1 https://github.com/AIDASoft/DD4hep.git \
#      && mkdir -p builds/dd4hep_build \
#      && cd  builds/dd4hep_build \
#      && cmake ../../DD4hep/. -DCMAKE_INSTALL_PREFIX=/usr/local \
#      -DDD4HEP_USE_CXX14:BOOL=ON -DDD4HEP_USE_GEANT4:BOOL=ON  -DCMAKE_CXX_STANDARD:STRING=14 \
#      && make VERBOSE=1 -j38 install \
#      && cd /tmp && rm -rf /tmp/DD4hep && rm -rf /tmp/builds/dd4hep_build"]

#RUN cd /tmp  \
#      && git clone --depth=1 https://github.com/whit2333/CADMesh.git \
#      && cd CADMesh && mkdir -p build \
#      && cd build \
#      && cmake ../. \
#      && make -j34 install \
#      && cd /tmp && rm -rf /tmp/CADMesh 
#### Build root from the repo master
##RUN cd /tmp \
##      && pwd \
##      && git clone --depth=1 http://root.cern.ch/git/root.git root_master \
##      && mkdir -p builds/root_build \
##      && cd builds/root_build \
##      && cmake ../../root_master/. -Dcxx14:BOOL=ON -Dgdml:BOOL=ON -Dmathmore:BOOL=ON -Dminuit2:BOOL=ON \
##      && make -j38 install \
##      && cd /tmp && rm -rf /tmp/root_master && rm -rf /tmp/builds/root_build 
## 
##RUN cd /opt \
##      && mkdir -p sane08  \
##      && cd sane08  \
##      && git clone --depth=1 https://eicweb.phy.anl.gov/whit/insane.git insane \
##      && git clone --depth=1 https://eicweb.phy.anl.gov/whit/BETAG4
##
##RUN cd /tmp \
##      && mkdir -p build/insane \
##      && cd build/insane \
##      && cmake /opt/sane08/insane/. \
##      && make -j38 \
##      && make install \
##      && cd /tmp \
##      && rm -rf build
##RUN cd /tmp \
##      && mkdir -p build/betag4 \
##      && cd build/betag4 \
##      && cmake /opt/sane08/BETAG4/. \
##      && make -j38 \
##      && make install \
##      && cd /tmp \
##      && rm -rf build
##
###RUN cd /usr/local/lib \
###      && wget https://hallcweb.jlab.org/experiments/sane/whit/cernlib_2006.tar.gz -O - | tar -xvz 
##
##SHELL ["/bin/bash", "-c"]
##
##RUN useradd -ms /bin/bash -d /opt/saneuser saneuser \
##      && apt-get install  -y cernlib-* 
##
##ADD  saneuser_home_dir.tar /root/.
##ADD  saneuser_home_dir.tar /opt/saneuser/.
##
##RUN mkdir -p /opt/sane08 \
##      && cd /opt/sane08 \
##      && ls -lrth \
##      && git clone --depth=1 https://eicweb.phy.anl.gov/whit/Analyzer_new \
##      && git clone --depth=1 https://eicweb.phy.anl.gov/whit/sane_replay \ 
##      && cd /opt/sane08/Analyzer_new && make
##
##RUN mkdir -p /opt/saneuser/bin \
##      && cd /opt/saneuser/bin/ \
##      && wget https://hallcweb.jlab.org/experiments/sane/whit/sane08_farm_scripts.tar.gz -O - |  tar -xzv \
##      && chown -R saneuser:saneuser /opt/saneuser \
##      && chown -R saneuser:saneuser /opt/sane08 \
##      && cd /opt/sane08  \
##      && ln -s /opt/sane08/insane InSANE \
##      && cd /opt/saneuser \
##      && ln -s /opt/sane08  \
##      && ls -lrth
##
##
##USER saneuser
##WORKDIR /opt/saneuser

