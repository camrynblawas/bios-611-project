FROM rocker/verse
RUN R -e "install.packages('tinytex',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('rmarkdown',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('gridExtra',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('ggmap',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('devtools',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('osmdata',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('OpenStreetMap',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('ggOceanMaps',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('ggspatial',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('ggpubr',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('tseries',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('lubridate',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('trend',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('ggpmisc',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('factoextra',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN Rscript --no-restore --no-save -e "update.packages(ask = FALSE);"
