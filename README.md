# MATLAB Codes in Optimization Algorithms :cocktail:

This is my repository for gathering optimization algorithm codes in MATLAB: [link](https://github.com/nutchanonj/optimization_codes).

This is a part of my works in CUEE505 Introduction to Optimization Techniques, Dept. of EE, Chulalongkorn University.

- **Newton's line search algorithm.** (`newton_search_1var`) [link](https://github.com/nutchanonj/optimization_codes/tree/main/newton_search_1var).
- **Golden section line search algorithm.** (`golden_section_search`) [link](https://github.com/nutchanonj/optimization_codes/tree/main/golden_section_search).
- **Newton’s method to find a root of a system of equations.** (`newton_root_finding`) [link](https://github.com/nutchanonj/optimization_codes/tree/main/newton_root_finding).
- **Searching for a minimizer of a 2-variable function.** (`minimizer_search_2var`): This work uses Newton's method to find search directions for finding a minimizer. The line search algorithm is the golden section search. If Newton's method does not work, use the steepest descent instead. [link](https://github.com/nutchanonj/optimization_codes/tree/main/minimizer_search_2var).
- **BFGS algorithm for finding a minimizer of a 2-variable function.** (`BFGS_algorithm`): This work uses the BFGS algorithm for finding a minimizer. The line search uses a **strong backtrack search**, which is brought from *Numerical Optimization* by Jorge Nocedal and Stephen J. Wright. [link](https://github.com/nutchanonj/optimization_codes/tree/main/BFGS_algorithm).
- **Conjugate gradient method for finding a minimizer of a 2-variable function** (`conjugate_gradient_method`): This work uses the conjugate gradient method for finding a minimizer. The line search also uses a **strong backtrack search** from *Numerical Optimization* by Jorge Nocedal and Stephen J. Wright. You can choose either the Fletcher-Reeves or Polak-Ribiere method by indicating the `option` in the function of `CG.m`. [link](https://github.com/nutchanonj/optimization_codes/tree/main/conjugate_gradient_method).
