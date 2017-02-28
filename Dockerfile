FROM dougmet/plumber

ENV PKG="maxholiday"

# Copy all files in
COPY . /${PKG}/

# Temp dep management
RUN . /etc/environment \
  && install2.r --error \
    --repos 'http://www.bioconductor.org/packages/release/bioc' \
    --repos $MRAN \ 
    lubridate

# Build the package (dependencies?)
RUN chgrp -R staff /$PKG \
  && R CMD build $PKG \
  && pkgtar=$(ls $PKG*.tar.gz) \
  && R CMD INSTALL $pkgtar

# Plumb your app into 8000
EXPOSE 8000

CMD ["/plumbapp.sh", "/maxholiday/R/api.R"]
