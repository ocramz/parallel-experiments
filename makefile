main:
	stack build --ghc-options -threaded --ghc-options -O2

run:
	stack exec parallel-experiments -- +RTS -N1
	stack exec parallel-experiments -- +RTS -N2
