# Make python package

LIBS="
  base core_kernel base_bigstring base/base_internalhash_types
  ppx_expect/collector time_now bin_prot pyml stdcompat"

OPAM_LIBS="$HOME/.opam/default/lib"

for lib in $LIBS
do
  export LIBRARY_PATH="$OPAM_LIBS/$lib:$LIBRARY_PATH"
done

# Build example library

dune build examples/ocaml.bc.so

mkdir examples/sharedlib 2> /dev/null
cp $OPAM_LIBS/ocaml/stdlib.cmi examples/sharedlib
cp _build/default/examples/ocaml.bc.so examples/sharedlib/ocaml.so

cd examples
python setup.py install
cd ..

# Build generated binding

dune build examples-gen/generated/ocaml.bc.so