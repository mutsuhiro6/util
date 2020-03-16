function set-dyld {
  export MCR_ROOT=/Applications/MATLAB/MATLAB_Runtime
  export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$MCR_ROOT/v901/runtime/maci64:$MCR_ROOT/v901/sys/os/maci64:$MCR_ROOT/v901/bin/maci64
}

function unset-dyld {
  unset DYLD_LIBRARY_PATH
}
