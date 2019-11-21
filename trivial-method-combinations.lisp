;;;; trivial-method-combinations.lisp

(defpackage #:trivial-method-combinations
  (:use #:cl)
  (:export #:method-combination-name
           #:method-combination-arglist))

(in-package #:trivial-method-combinations)

(defun method-combination-name (method-combination)
  "Returns the name of the method combination."
  (check-type method-combination method-combination)
  #-(or sbcl ccl ecl clasp abcl clisp)
  (error "Your implementation is not supported by TRIVIAL-METHOD-COMBINATION.
Please patch the library at your earliest convenience or open an issue at
this library's issue tracker.")
  #+sbcl
  (sb-pcl::method-combination-type-name method-combination)
  #+ccl
  (ccl::method-combination-name method-combination)
  #+ecl
  (clos::method-combination-name method-combination)
  #+clasp
  (clos::method-combination-name method-combination)
  #+abcl
  (mop::method-combination-name method-combination)
  #+clisp
  (clos::method-combination-name method-combination))

(defun method-combination-arglist (method-combination)
  "Returns the argument list of the method combination."
  (check-type method-combination method-combination)
  #-(or sbcl ccl ecl clasp abcl clisp)
  (error "Your implementation is not supported by TRIVIAL-METHOD-COMBINATION.
Please patch the library at your earliest convenience or open an issue at
this library's issue tracker.")
  (typecase method-combination
    #+sbcl
    (sb-pcl::long-method-combination
     (values (sb-pcl::long-method-combination-args-lambda-list method-combination)
             t))
    #+ccl
    (ccl::long-method-combination
     (values (ccl::method-combination-args-lambda-list method-combination)
             t))
    #+ecl
    (method-combination
     (warn "ECL does not support :ARGUMENTS in method combinations.")
     (values nil t))
    #+clasp
    (method-combination
     (warn "ECL does not support :ARGUMENTS in method combinations.")
     (values nil t))
    #+abcl
    (mop::long-method-combination
     (values (mop::long-method-combination-arguments method-combination)
             t))
    #+clisp
    (clos::method-combination
     (let ((args-lambda-list
             (clos::method-combination-arguments-lambda-list method-combination)))
       (values args-lambda-list
               (eq (clos::method-combination-expander method-combination)
                   #'clos::long-form-method-combination-expander))))
    (t (values nil nil))))


