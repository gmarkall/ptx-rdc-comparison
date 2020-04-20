all:
	@rm -rf rdc
	@rm -rf nordc
	@mkdir rdc
	@mkdir nordc
	@echo "\nNo RDC\n"
	@nvcc --dryrun -c test.cu -o nordc/test.o 2>&1 | tee nordc/dryrun.txt
	@nvcc --ptx test.cu -o nordc/test.ptx
	@echo "\nWith RDC\n"
	@nvcc --dryrun --device-c test.cu -o rdc/test.o 2>&1 | tee rdc/dryrun.txt
	@nvcc --ptx --device-c test.cu -o rdc/test.ptx
	@diff -u nordc/test.ptx rdc/test.ptx \
	  && echo "\nPTX is the same in both cases\n" \
	  || echo "\nPTX differs with -rdc flag\n"


