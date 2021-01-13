(in-package "CL-TISP")

(defun eco-render (eco-template-string cl-toml-table &key
		   (package-name 'eco-template))
  (let* ((ast (eco.parser:parse-template eco-template-string))
	 (eco.compiler::*template-package* (find-package package-name)))
    (multiple-value-bind (keys vals)
	(cl-tisp.util::make-progv-bindings-for-package
	 (cl-tisp.util::extract-key-val-pairs cl-toml-table)
	 eco.compiler::*template-package*)
      (eval
       `(progv ',keys ',vals
	  (with-output-to-string (eco.compiler::%eco-stream)
	    ,@(map 'list 'eco.compiler::emit
		   (remove-if-not 'eco.compiler::template-element-p ast))))))))
