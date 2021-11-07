(in-package "CL-TISP")

;; unlike cl-tisp.util::extract-key-val-pairs this function does not
;; flatten to a single list
(defun mustache-massage (cl-toml-hash-table)
  (labels ((fkey (k)
	     (assert k)
	     (assert (atom k))
	     (assert (stringp k))
	     k)
	   (fval (v)
	     (assert (atom v))
	     (etypecase v
	       (hash-table
		(fhash v))
	       ((or number string array)
		v)
	       (local-time:timestamp nil)
	       (symbol
		(cond ((eql v 'cl-toml:true) t)
		      ((eql v 'cl-toml:false) nil)
		      (t nil)))))
	   (fhash (h)
	     (let ((ret nil))
	       (maphash (lambda (k v)
			  (let ((k1 (fkey k))
				(v1 (fval v)))
			    (if (null v1)
				(warn "ignoring (k v) = ~S" (list k v))
				(push (cons k1 v1) ret))))
			h)
	       (nreverse ret))))
    (fhash cl-toml-hash-table)))

(defun mustache-render (mustache-template-string cl-toml-table)
  (mustache:render* mustache-template-string
		    (mustache-massage cl-toml-table)))
