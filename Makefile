
build:
	Rscript make_schedule.R ; \
	hugo --disableFastRender

test:
	Rscript make_schedule.R ; \
	hugo serve --disableFastRender

