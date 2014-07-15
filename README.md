CLML Machine-Learning Library Extras
====================================

This repository contains tests for the CLML Machine Learning library and sample datasets and code.

    
The CLML Machine-Learning is high performance and large scale statistical
machine learning package written in Common Lisp developed at MSI. CLML can be obtained from the git repository
    https://github.com/mmaul/clml.git
    
The test code is an excellent way of getting familiar with using CLML

Orginization
============
+ test - clml.test test for CLML
+ sample - datasets supporting tests and sample data
    
Running CLML Test Suite
=======================
    
The test directory contains test code from the CLML library. If using quicklisp this repository should be unpacked in ~/quicklisp/local-projects if using asdf this repository should be in your central registry.
    
All tests can be ran by:
    (ql:quickload :clml.extras)
    (in-package :test)
    (run-tests :all)

Individual tests can be run by supplying run-tests with a list of tests to execute.
    (ql:quickload :clml.extras)
    (in-package :test)
    (run-tests '(svm.smo.kernels smo.svm))
