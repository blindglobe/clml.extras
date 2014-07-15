#|(defpackage :test-pwss3-svm
  (:use :common-lisp
	:lisp-unit
	:hjs.learn.read-data
	:pwss3-svm)
  (:export :test-kernels :test-svm)) 

(in-package test-pwss3-svm)
|#
(in-package :test)
(define-test test-pwss3-kernels
  (assert-true (setf z-1 (make-array 4 :element-type 'double-float
                                     :initial-contents #(-1.0d0 7.0d0 4.0d0 1.0d0))
                     z-2 (make-array 4 :element-type 'double-float
                                     :initial-contents #(2.0d0 5.0d0 3.0d0 -1.0d0))))
  (assert-true (= 45.0d0 (pwss3-svm::call-kernel-function-uncached (clml.svm.pwss3:make-linear-kernel) z-1 z-2)))
  (assert-true (setf rbf-kernel (pwss3-svm::make-rbf-kernel :gamma 1.0d0)))
  (assert-true (> 0.00001d0 (- 8.315287191035679e-7 (pwss3-svm::call-kernel-function-uncached rbf-kernel z-1 z-2))))
  (assert-true (setf poly-kernel (pwss3-svm::make-polynomial-kernel :gamma 1.0d0 :r 0.0d0 :d 2)))
  (assert-true (= 2025.0d0 (pwss3-svm::call-kernel-function-uncached poly-kernel z-1 z-2)))
  (assert-true (setf poly-kernel (pwss3-svm::make-polynomial-kernel :gamma 1.0d0 :r 1.0d0 :d 2)))
  (assert-true (= 2116.0d0 (pwss3-svm::call-kernel-function-uncached poly-kernel z-1 z-2)))
  (assert-true (setf poly-kernel (pwss3-svm::make-polynomial-kernel :gamma 2.0d0 :r -89.0d0 :d 2)))
  (assert-true (= 1.0d0 (pwss3-svm::call-kernel-function-uncached poly-kernel z-1 z-2)))
  (assert-true (setf poly-kernel (pwss3-svm::make-polynomial-kernel :gamma 3.0d0 :r -133.0d0 :d 3)))
  (assert-true (= 8.0d0 (pwss3-svm::call-kernel-function-uncached poly-kernel z-1 z-2)))
  )


(define-test test-pwss3-svm
  
  (assert-true (setf svm-bc-train
                     (pick-and-specialize-data
                      (read-data-from-file (asdf:system-relative-pathname 'clml.extras "sample/bc-train-for-svm.csv")
                                           :type :csv
                                           :csv-type-spec 
                                           (make-list 10 :initial-element 'double-float))
                      :data-types (make-list 10 :initial-element :numeric))))
  
  (assert-true (setf svm-bc-test
                     (pick-and-specialize-data
                      (read-data-from-file (asdf:system-relative-pathname 'clml.extras "sample/bc-test-for-svm.csv")
                                           :type :csv
                                           :csv-type-spec 
                                           (make-list 10 :initial-element 'double-float))
                      :data-types (make-list 10 :initial-element :numeric))))
  
  (assert-true (setf training-vector (dataset-points svm-bc-train)))
  (assert-true (setf test-vector (dataset-points svm-bc-test)))
  
  (assert-true (setf linear-svm (pwss3-svm::make-svm-learner training-vector (clml.svm.pwss3:make-linear-kernel) :c 1))) ;Not sure whether is c or weight
  (assert-true (= 1.0d0 (funcall linear-svm (svref test-vector 0))))
  (assert-true (= -1.0d0 (funcall linear-svm (svref test-vector 7))))
  (assert-true (= 4 (length (pwss3-svm::svm-validation linear-svm test-vector))))
         
  (assert-true (setf rbf-kernel (pwss3-svm::make-rbf-kernel :gamma 0.05d0)))
  (assert-true (setf rbf-svm (pwss3-svm:make-svm-learner training-vector rbf-kernel :c 100)))
  (assert-true (= 1.0d0 (funcall rbf-svm (svref test-vector 0))))
  (assert-true (= -1.0d0 (funcall rbf-svm (svref test-vector 7))))
  (assert-true (= 4 (length (pwss3-svm:svm-validation rbf-svm test-vector))))
  (assert-true (setf poly-svm (pwss3-svm::make-svm-learner training-vector (pwss3-svm:make-polynomial-kernel :gamma 1.0d0 :r 0.0d0 :d 2) :c 1)))
  (assert-true (= 1.0 (funcall poly-svm (svref test-vector 0))))
  (assert-true (= -1.0 (funcall poly-svm (svref test-vector 7))))
  (assert-true (= 4 (length (pwss3-svm:svm-validation poly-svm test-vector))))
  (assert-true (setf train-data (pick-and-specialize-data (read-data-from-file (asdf:system-relative-pathname 'clml.extras "sample/svm-benchmark-train.csv") :type :csv :csv-type-spec (make-list 24 :initial-element 'double-float)
									       :external-format :utf-8) :data-types (make-list 24 :initial-element :numeric))))
  (assert-true (setf test-data (pick-and-specialize-data (read-data-from-file (asdf:system-relative-pathname 'clml.extras "sample/svm-benchmark-test.csv") :type :csv :csv-type-spec (make-list 24 :initial-element 'double-float)
									      :external-format :utf-8) :data-types (make-list 24 :initial-element :numeric))))
  (assert-true (setf training-vector (dataset-points train-data)))
  (assert-true (setf test-vector (dataset-points test-data)))
  (assert-true (setf rbf (pwss3-svm:make-rbf-kernel :gamma 0.5d0)))
  (assert-true (setf svm (pwss3-svm:make-svm-learner training-vector rbf :c 10)))
  (assert-true (multiple-value-setq (results accuracy) (pwss3-svm:svm-validation svm test-vector)))
  (assert-true (= accuracy 94.85150853161717d0))
  )
