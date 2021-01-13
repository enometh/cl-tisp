(in-package "CL-TISP")

;; PATCH zenekindarl/src/backend.lisp: (emit-parameters): to accept
;; symbols as keyword parameters. (This should be an around method but
;; as of now the generic function has only one method specialized on
;; T.)  Note reloading zenekindarl requires patching the code again.
;;
(defvar *zenekindarl-backend-uses-keyword-p* t)

(defmethod zenekindarl.backend::emit-parameters (backend)
  (let ((syms (zenekindarl.backend::symbols backend)))
    (unless *zenekindarl-backend-uses-keyword-p*
      (setq syms (mapcar (lambda (sym) (list (list sym sym))) syms)))
    (if syms `(&key ,@syms) ())))

(defun zenekindarl-render (ztemplate-string cl-toml-table)
  (let* ((*zenekindarl-backend-uses-keyword-p* nil)
	 (func (zenekindarl:compile-template-string
		:stream ztemplate-string)))
    (with-output-to-string (stream)
      (apply func stream
	     (cl-tisp.util::make-plist-bindings-for-package
	      (cl-tisp.util::extract-key-val-pairs cl-toml-table)
	      "ZENEKINDARL.LEXER.DEFAULT")))))
