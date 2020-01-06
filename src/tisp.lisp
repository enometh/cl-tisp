(in-package :cl-user)
(defpackage cl-tisp
  (:use #:cl)
  (:import-from #:cl-tisp.util
                #:read-file-into-list)
  (:export #:render-template))
(in-package :cl-tisp)


(defun render-template (template variables)
  (let ((foo (concatenate 'string template variables))) (princ foo)))
