FROM rocker/verse
RUN R -e "install.packages('ncdf4',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('rnoaa',dependencies=TRUE, repos='http://cran.rstudio.com/')"