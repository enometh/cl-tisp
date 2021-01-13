(in-package "CL-TISP")

(defun temper-render (template-string cl-toml-table)
  (with-input-from-string (stream template-string)
    (apply #'temper::render stream
	   (cl-tisp.util::make-plist-bindings-for-package
	    (cl-tisp.util::extract-key-val-pairs cl-toml-table)
	    *package*))))