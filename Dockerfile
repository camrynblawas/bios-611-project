FROM rocker/verse
RUN R -e "install.packages('rnoaa',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('tinytex',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('rmarkdown',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('gridExtra',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN Rscript --no-restore --no-save -e "update.packages(ask = FALSE);"
