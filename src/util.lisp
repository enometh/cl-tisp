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
    (format file file-contents)
