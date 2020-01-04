(defsystem "cl-tisp"
  :version "0.1.0"
  :author "rig0rmortis"
  :license "MIT"
  :depends-on ()  ;; <== list of Quicklisp dependencies
  :components ((:module "src"
                :components
                ((:file "cl-tisp"))))
  :description "Templating In liSP"
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.md"))
  :in-order-to ((test-op (test-op "cl-tisp-test"))))
