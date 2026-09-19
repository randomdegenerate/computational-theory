
{
  description = "Computational Theory Dev Environment";

  # references used to write this flake
  #https://discourse.nixos.org/t/how-to-create-flake-nix-for-nix-shell-loading-a-few-packages/58456/2
  #https://nixos.wiki/wiki/Packaging/Python

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
            [
                # define python3 package and the modules within the package
                # aligning versioning and ensuring it works
                (pkgs.python3.withPackages(pythonPackages: with pythonPackages; [
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
                ]))
            ];

            env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
                pkgs.stdenv.cc.cc.lib
                pkgs.libz
            ];

          #Shell hook runs when shell is entered
          # shellHook = "";
        };
    }
    );
}

