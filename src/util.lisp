(in-package :cl-user)
(defpackage cl-tisp.util
  (:use #:cl)
  (:export #:read-file-into-list
           #:write-list-into-file))
(in-package :cl-tisp.util)

(defun read-file-into-list (file-path)
  "Given a file-path return a list of lines."
  (with-open-file (file file-path :direction :input)
    (loop for line = (read-line file nil)
       while line
       collect line)))

(defun write-list-into-file (file-contents file-path)
  "Takes a list of lines and writes them to file."
  (with-open-file (file file-path
                        :direction :output
                        :if-exists :overwrite
                        :if-does-not-exist :create)
    (format file file-contents)))

;; CL-TOML-TABLE is a hash-table returned by CL-TOML:PARSE
(defun extract-key-val-pairs (cl-toml-table &optional parent-key (depth 0))
  (let (ret)
    (flet ((collect (key val)
	     (push val ret)
	     (push (concatenate 'string parent-key key) ret)))
      (maphash (lambda (key val)
		 (assert (stringp key))
		 (cond ((stringp val) (collect key val))
		       ((eql val 'cl-toml:true) (collect key t))
		       ((eql val 'cl-toml:false) (collect key nil))
		       ((hash-table-p val)
			(setq ret (nconc ret (extract-key-val-pairs val (concatenate 'string key ".") (1+ depth)))))
		       ((and (consp val) (eq (car val) :string) (endp (cddr val)))
			(assert (stringp (second val)))
			(collect key (second val)))
		       (t (warn "ignoring key=~S val=~S" key val))))
	       cl-toml-table)
      ret)))

(defun make-plist-bindings-for-package (key-val-pairs package)
  (loop for (key val) on key-val-pairs by #'cddr
	append (list (intern (string-upcase key) package)
		      val)))

(defun make-progv-bindings-for-package (key-val-pairs package)
  (loop for (key val) on key-val-pairs by #'cddr
	collect (intern (string-upcase key) package) into keys
	collect val into vals
	finally (return (values keys vals))))

