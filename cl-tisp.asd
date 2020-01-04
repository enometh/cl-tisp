;;;; cl-tisp

;;; A tiny templating engine written in Common Lisp. Inspired by other commonly used templating
;;; engines like jinja2 (python) and erb (ruby).

(in-package :cl-user)
(defpackage cl-tisp
  (:use :cl :asdf))
(in-package :cl-tisp)

(defsystem "cl-tisp"
  :version "0.1.0"
  :author "rig0rmortis"
  :license "MIT"
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "tisp"))))
  :description "A tiny templating engine for Common Lisp."
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.md"))
  :in-order-to ((test-op (test-op "cl-tisp-test"))))
