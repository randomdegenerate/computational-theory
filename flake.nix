
{
  description = "Computational Theory Dev Environment(runtime environment tba)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      rec {
        devShells.default = pkgs.mkShellNoCC {
          packages =
          with pkgs.python313Packages;
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
        };
      }
    );
}

