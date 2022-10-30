FROM rocker/verse
RUN R -e "install.packages('rnoaa',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN Rscript --no-restore --no-save -e "update.packages(ask = FALSE);"
