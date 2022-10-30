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
	
report.pdf: figures/beaufsstpoint.png figures/beaufsstglm.png figures/chsstpoint.png figures/chsstpoint.png figures/ducksstpoint.png figures/ducksstglm.png
	R -e "rmarkdown::render(\"writeup.Rmd\", output_format=\"pdf_document\")"

writeup.pdf: figures/beaufsstpoint.png figures/beaufsstglm.png figures/chsstpoint.png figures/chsstpoint.png figures/ducksstpoint.png figures/ducksstglm.png
	pdflatex writeup.tex