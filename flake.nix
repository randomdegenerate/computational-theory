
{
  description = "Computational Theory Dev Environment";

  inputs = {
    #Package url source
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # utilties for dynamically identifying system type (x86-linux,arm,macos etc)
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    #
    flake-utils.lib.eachDefaultSystem (system:
      let
        # Creates an easy to reference variable name for accessing any packages
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        # Developement Shell
        devShells.default = pkgs.mkShellNoCC {
          #Defining the packages active in the dev shell
          packages =
          with pkgs.python314Packages;
          [
            pkgs.python3
            #python3 packages

            # Interactive Python shell.
            ipython
            # Jupyter notebook/lab support.
            ipykernel
            # Jupyter lab.
            jupyterlab
            # Jupyter notebook.
            notebook
            # Numerical arrays.
            numpy
            # Data Frames.
            pandas
            # Scientific computing.
            scipy
            # Statistical modeling.
            statsmodels
            # Download financial market data.
            yfinance
            # Plotting.
            matplotlib
            # Statistical data visualization.
            seaborn
            # Quantum computing.
            # qiskit[visualization]
            # Quantum simulators.
            # qiskit-aer
            # Machine learning.
            scikit-learn
            # Symbolic mathematics.
            sympy
            # Testing.
            pytest
          ];

          #Shell hook runs when shell is entered
          shellHook = "jupyter notebook";
        };
    }
    );
}

