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

report.pdf: figures/beaufsstpoint.png figures/beaufsstglm.png figures/chsstpoint.png figures/chsstpoint.png figures/ducksstpoint.png figures/ducksstglm.png
	R -e "rmarkdown::render(\"report.Rmd\", output_format=\"pdf_document\")"

#writeup.pdf: figures/beaufsstpoint.png figures/beaufsstglm.png figures/chsstpoint.png figures/chsstpoint.png figures/ducksstpoint.png figures/ducksstglm.png
	#pdflatex writeup.tex