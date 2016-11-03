REPrmd = report/report.rmd
REPpdf = report/report.pdf
REGdata = data/*.RData
IMAGES = images/*.png
DATAraw = data/Credit.csv
DATAscaled = data/scaled-credit.csv

MODscript = code/scripts/pre-modeling-script.R

EDAscript = code/scripts/eda-script.R

SESscript = code/scripts/session-info-script.R

.phony: all data tests eda ols ridge lasso pcr plsr regression report slides session clean cleanall

all: eda regressions report

eda: $(EDAscript) $(DATAraw)
	Rscript $(EDAscript) $(DATAraw)
	
premodeling: $(MODscript) $(DATAraw)
	Rscript $(MODscript) $(DATA)

$(IMAGES):

regressions:
	make ols
	make ridge
	make lasso
	make pcr
	make pslr

ols: code/functions/lm-model.R $(DATAscaled)
	Rscript code/functions/lm-model.R $(DATAscaled)

ridge: code/functions/ridge-model.R $(DATAscaled)
	Rscript code/functions/ridge-model.R $(DATAscaled)

lasso: code/functions/lasso-model.R $(DATAscaled)
	Rscript code/functions/lasso-model.R $(DATAscaled)

pcr: code/functions/pcr-model.R $(DATAscaled)
	Rscript code/functions/pcr-model.R $(DATAscaled)

pslr: code/functions/pslr-model.R $(DATAscaled)
	Rscript code/functions/pslr-model.R $(DATAscaled)

data:
	curl http://www-bcf.usc.edu/~gareth/ISL/Credit.csv > $(DATAraw)

session: $(SESscript) 
	Rscript $(SESscript)
	bash session.sh

$(REPpdf): $(REPrmd) $(REGdata) $(IMAGES) 
	Rscript -e "library(rmarkdown);render('$(REPrmd)')"

tests: code/functions/regression-functions.R code/tests/test-regression.R
	Rscript code/test-that.r

clean: 
	rm $(REPpdf)

cleanall:
	rm -rf $(REPpdf)
	rm -rf $(IMAGES)
	rm -rf data/*.RData
	rm -rf data/*.txt

