
build:
	Rscript make_schedule.R ; \
	hugo

test:
	Rscript make_schedule.R ; \
	hugo serve --disableFastRender

