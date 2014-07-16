CLML Machine-Learning Library Extras
`==================================`

This repository contains tests for the CLML Machine Learning library and sample datasets and code.

The CLML Machine-Learning is high performance and large scale statistical
machine learning package written in Common Lisp developed at MSI. CLML can be obtained from the git repository
    <https://github.com/mmaul/clml.git>

The test code is an excellent way of getting familiar with using CLML

Orginization
`==========`

-   test - clml.test test for CLML
-   sample - datasets supporting tests and sample data

# Testing

## Test package

The package for test is 'lisp-unit'.
Operation check required: linux32, linux64, win32, sparc/solaris32
Tests are located in the test directory and are an invaluable source
of knowledge in understanding how to use this library.

## Running Tests

The clml.test package must be loaded prior to running tests. Below is
how to invoke tests:
  (ql:quickload :clml.test)
  (in-package :test)
  (run-tests :all)

## lisp-unit notes

### How to use

-   1. Read the documentation in 
    <http://www.cs.northwestern.edu/academics/courses/325/readings/lisp-unit.html>

-   2. Make a file of DEFINE-TEST's. See exercise-tests.lisp for many examples. If you want, start your test file with (REMOVE-TESTS) to clear any previously defined tests.

-   2. (use-package :lisp-unit)

-   3. Load your code file and your file of tests.

-   4. Test your code with (RUN-TESTS test-name1 test-name2 &#x2026;) &#x2013; no quotes! &#x2013; or simply (RUN-TESTS) to run all defined tests.

-   A summary of how many tests passed and failed will be printed, with details on the failures.

-   Note: Nothing is compiled until RUN-TESTS is expanded. Redefining functions or even macros does not require reloading any tests.

Running CLML Test Suite
`=====================`

The test directory contains test code from the CLML library. If using quicklisp this repository should be unpacked in ~/quicklisp/local-projects if using asdf this repository should be in your central registry.

All tests can be ran by:
    (ql:quickload :clml.extras)
    (in-package :test)
    (run-tests :all)

Individual tests can be run by supplying run-tests with a list of tests to execute.
    (ql:quickload :clml.extras)
    (in-package :test)
    (run-tests '(svm.smo.kernels smo.svm))