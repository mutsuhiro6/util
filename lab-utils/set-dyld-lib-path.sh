function set-dyld {
  export MCR_ROOT=/Applications/MATLAB/MATLAB_Runtime
  export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$MCR_ROOT/v901/runtime/maci64:$MCR_ROOT/v901/sys/os/maci64:$MCR_ROOT/v901/bin/maci64
}

function unset-dyld {
  unset DYLD_LIBRARY_PATH
}

function set-dyld-v95 {
	export MCR_ROOT=/Applications/MATLAB/MATLAB_Runtime
	export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$MCR_ROOT/v95/runtime/maci64:$MCR_ROOT/v95/sys/os/maci64:$MCR_ROOT/v95/bin/maci64:$MCR_ROOT/v95/extern/bin/maci64
}

function set-dyld-v98 {
        export MCR_ROOT=/Applications/MATLAB/MATLAB_Runtime
        export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$MCR_ROOT/v98/runtime/maci64:$MCR_ROOT/v98/sys/os/maci64:$MCR_ROOT/v98/bin/maci64:$MCR_ROOT/v98/extern/bin/maci64
}
