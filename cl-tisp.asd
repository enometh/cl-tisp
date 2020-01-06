(defsystem "cl-tisp"
  :version "0.1.0"
  :author "rig0rmortis"
  :license "MIT"
  :components ((:module "src"
                :components
                ((:file "tisp")
                 (:file "util")
                 (:file "macros"))))
  :description "A tiny templating engine for Common Lisp."
  :in-order-to ((test-op (test-op "cl-tisp-test"))))
