# Conjugate gradient method for finding a minimizer of a 2-variable function.

This work uses the conjugate gradient method to find a minimizer. The line search uses a **strong backtrack search**, which is brought from *Numerical Optimization* by Jorge Nocedal and Stephen J. Wright.

The strong backtrack search algorithm is contained in a function `StrongBacktrack.m`. For further details, please refer to the report in a PDF format. Also, you can refer to the original work in *Numerical Optimization* by Jorge Nocedal and Stephen J. Wright.

The Conjugate gradient method is given in `CG.m`. You can choose either the Fletcher-Reeves or the Polak-Ribiere method by indicating `option`.

The optimized function is contained in `Rosenblock.m`.

To test the code, please run `test_script.m`

You can see the report in a PDF file. I also give the LaTeX file that generates that PDF.
