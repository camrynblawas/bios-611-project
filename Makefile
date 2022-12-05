.PHONY: clean

clean:
	rm -rf figures
	rm -rf deriveddata
	rm -rf .created-dirs
	rm -f writeup.pdf

.created-dirs:
	mkdir -p figures
	mkdir -p deriveddata
	touch .created-dirs

deriveddata/beaufprocessed.csv: .created-dirs formatdata.R sourcedata/beaufraw.csv
	Rscript formatdata.R

deriveddata/chprocessed.csv: .created-dirs formatdata.R sourcedata/chraw.csv
	Rscript formatdata.R
	
deriveddata/duckprocessed.csv: .created-dirs formatdata.R sourcedata/duckraw.csv
	Rscript formatdata.R

figures/beaufsstpoint.png:
figures/beaufsstglm.png: .created-dirs\
preliminaryplots.R\
deriveddata/beaufprocessed.csv
	Rscript preliminaryplots.R

figures/chsstpoint.png:
figures/chsstglm.png: .created-dirs\
preliminaryplots.R\
deriveddata/beaufprocessed.csv
	Rscript preliminaryplots.R

figures/ducksstpoint.png:
figures/ducksstglm.png: .created-dirs\
preliminaryplots.R\
deriveddata/beaufprocessed.csv
	Rscript preliminaryplots.R

figures/beaufyearlytrend.png: .created-dirs\
yearlywtemp.R\
deriveddata/beaufprocessed.csv
	Rscript yearlywtemp.R

figures/chyearlytrend.png: .created-dirs\
yearlywtemp.R\
deriveddata/chprocessed.csv
	Rscript yearlywtemp.R

figures/duckyearlytrend.png: .created-dirs\
yearlywtemp.R\
deriveddata/duckprocessed.csv
	Rscript yearlywtemp.R

figures/2017trend.png: .created-dirs\
yearlywtemp.R\
deriveddata/duckprocessed.csv deriveddata/chprocessed.csv deriveddata/beaufprocessed.csv
	Rscript yearlywtemp.R

figures/beaufpca.png: .created-dirs\
pca.R\
deriveddata/beaufprocessed.csv
	Rscript pca.R

figures/chpca.png: .created-dirs\
pca.R\
deriveddata/chprocessed.csv
	Rscript pca.R
	
figures/duckpca.png: .created-dirs\
pca.R\
deriveddata/duckprocessed.csv
	Rscript pca.R

figures/sitemap.png: .created-dirs\
map.R\
deriveddata/duckprocessed.csv deriveddata/chprocessed.csv deriveddata/beaufprocessed.csv
	Rscript map.R

figures/beaufapriltrends.png: .created-dirs\
wcr.R\
deriveddata/beaufprocessed.csv
	Rscript wcr.R

figures/chapriltrends.png: .created-dirs\
wcr.R\
deriveddata/chprocessed.csv
	Rscript wcr.R

figures/duckapriltrends.png: .created-dirs\
wcr.R\
deriveddata/duckprocessed.csv
	Rscript wcr.R
	
figures/beaufseasonaltrend.png: .created-dirs\
timeseries.R\
deriveddata/beaufprocessed.csv
	Rscript timeseries.R

figures/chseasonaltrend.png: .created-dirs\
timeseries.R\
deriveddata/chprocessed.csv
	Rscript timeseries.R
	
figures/duckseasonaltrend.png: .created-dirs\
timeseries.R\
deriveddata/duckprocessed.csv
	Rscript timeseries.R

warmcoreringdayscompared.png: .created-dirs\
wcr.R\
deriveddata/duckprocessed.csv deriveddata/chprocessed.csv deriveddata/beaufprocessed.csv
	Rscript wcr.R

alldatapca.png: .created-dirs\
pca.R\
deriveddata/duckprocessed.csv deriveddata/chprocessed.csv deriveddata/beaufprocessed.csv
	Rscript pca.R
	
clustering.jpg: .created-dirs\
pca.R\
deriveddata/duckprocessed.csv deriveddata/chprocessed.csv deriveddata/beaufprocessed.csv
	Rscript pca.R

report.pdf: figures/beaufsstpoint.png figures/beaufsstglm.png figures/chsstpoint.png figures/chsstpoint.png figures/ducksstpoint.png figures/ducksstglm.png
	R -e "rmarkdown::render(\"report.Rmd\", output_format=\"pdf_document\")"

#writeup.pdf: figures/beaufsstpoint.png figures/beaufsstglm.png figures/chsstpoint.png figures/chsstpoint.png figures/ducksstpoint.png figures/ducksstglm.png
	#pdflatex writeup.tex