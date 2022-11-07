# BFGS algorithm for finding minimizer of 2-variable function.

This work uses BFGS algorithm for finding minimizer. The line search uses a **strong backtrack search**, which is brought from *Numerical Optimization* by Jorge Nocedal and Stephen J. Wright.

The strong backtrack search algorithm is contained in a function `StrongBacktrack.m`. For further detail, please refer to the report in a pdf format. Also, you can refer to the original work in *Numerical Optimization* by Jorge Nocedal and Stephen J. Wright.

The BFGS algorithm is given in `BFGS.m`.

The optimized function is contained in `Rosenblock.m`.

To test the code, please run `test_script.m`

You can see the report in pdf file. I also give the LaTeX file gererating that pdf.