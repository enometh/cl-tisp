(defpackage "CL-TISP-EXAMPLE"
  (:import-from "CL-TISP"
   #+cl-tisp-eco-backend "ECO-RENDER"
   #+cl-tisp-zenekindarl-backend "ZENEKINDARL-RENDER"
   #+cl-tisp-temper-backend "TEMPER-RENDER")
  (:use "CL"))
(in-package "CL-TISP-EXAMPLE")


;;; ----------------------------------------------------------------------
;;;
;;; https://github.com/eudoxia0/eco.git
;;;

(defvar $toml-string "
[person]
name = \"Foo Bar\"
alive = true
")

(defvar $etemplate "
<% if person.alive %>
<%= person.name %> is not dead!
<% else %>
<%= person.name %> is dead 💀!
<% end %>
")

#+(and nil cl-tisp-eco-backend)
(eco-render $etemplate (cl-toml:parse $toml-string))


;;; ----------------------------------------------------------------------
;;;
;;;  https://github.com/KeenS/zenekindarl.git
;;;

(defvar $ztemplate "
{{ if person.alive }}
{{ var person.name }} is not dead!
{{ else }}
{{ var person.name }} is dead 💀!
{{ endif }}
")

#+(and nil cl-tisp-zenekindarl-backend)
(zenekindarl-render $ztemplate (cl-toml:parse $toml-string))


;;; ----------------------------------------------------------------------
;;;
;;; https://github.com/cacharle/temper.git
;;;
(defvar $temper-template "
<% (if person.alive (progn %>
<%= person.name %> is not dead!
<% ) (progn  %>
<%= person.name %> is dead 💀!
<% )) %>
")

#+nil
(import 'CL-TISP::TEMPER-RENDER)

#+(and nil cl-tisp-temper-backend)
(temper-render $temper-template (cl-toml:parse $toml-string))


;;; ----------------------------------------------------------------------
;;;
;;; https://github.com/kanru/cl-mustache.git
;;;
(defvar $mustache-template "
{{#person.alive}} {{person.name}} is not dead {{/person.alive}}
{{^person.alive}} {{person.name}} is not dead 💀! {{/person.alive}}
")

#+nil
(import 'CL-TISP::MUSTACHE-RENDER)

#+(and nil cl-tisp-mustache-backend)
(mustache-render $mustache-template (cl-toml:parse $toml-string))



;;; ----------------------------------------------------------------------
;;;
;;;
;;;
(defvar $keyfile-data
"
[person]
name = \"Foo Bar\"
alive = false
")

(defmacro fixup-bool (place)
  `(let* ((.old. ,place)
	  (.rep. (cond ((string-equal "true" .old.) t)
		       ((string-equal "false" .old.) nil)
		       (t (error "place is not a bool")))))
     (setf ,place .rep.)))

#+nil
(setq $t1 (cl-tisp.util::ini-file-to-toml-table
	   (make-instance 'gir-lib:ini-file
	     :data $keyfile-data)))
#+nil
(fixup-bool (gethash "alive" (gethash "person" $t1)))

#+nil
(temper-render $temper-template $t1)
