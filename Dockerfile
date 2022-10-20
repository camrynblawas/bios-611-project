FROM rocker/verse
RUN Rscript --no-restore --no-save -e "install.packages('ncdf4')"
RUN Rscript --no-restore --no-save -e "install.packages('rnoaa')"