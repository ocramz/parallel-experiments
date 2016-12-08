N = 1000000

all:
	make build
	make run

build:
	stack build --ghc-options -threaded --ghc-options -O2

run:
	stack exec parallel-experiments -- +RTS -N1 -RTS $N
	stack exec parallel-experiments -- +RTS -N2 -RTS $N
