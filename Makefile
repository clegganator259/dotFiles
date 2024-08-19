setup:
	./setup.sh
scripts: delim-files

delim-files:
	go build -o=bin/delim-file scripts/delim-file.go 

