(defsystem "cl-tisp"
  :version "0.1.0"
  :author "rgrmrts"
  :license "MIT"
  :source-control "https://github.com/rgrmrsts/cl-tisp"
  :description "A tiny templating engine for Common Lisp."
  :depends-on (:alexandria
               :cl-toml)
  :components ((:module "src"
                :components
                ((:file "tisp")
                 (:file "util")
                 (:file "macros"))))
  :in-order-to ((test-op (test-op "cl-tisp-test"))))
