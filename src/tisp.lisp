(in-package :cl-user)
(defpackage cl-tisp
  (:use #:cl)
  (:import-from #:cl-tisp.util
                #:read-file-into-list)
  (:export #:render-template))
(in-package :cl-tisp)


(defun render-template (template variables)
  "given the template file and parsed toml as a lisp of variables, return the
  rendered content with the variables substituted."
  (let ((foo (concatenate 'string template variables))) (princ "foo")))
