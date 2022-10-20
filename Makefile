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