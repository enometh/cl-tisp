(in-package "CL-TISP")

(defun zenekindarl-render (ztemplate-string cl-toml-table)
  (let ((func (zenekindarl:compile-template-string
	       :stream ztemplate-string)))
    (with-output-to-string (stream)
      (apply func stream
	     (cl-tisp.util::make-plist-bindings-for-package
	      (cl-tisp.util::extract-key-val-pairs cl-toml-table)
	      "ZENEKINDARL.LEXER.DEFAULT")))))
