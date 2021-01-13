(defpackage "CL-TISP-EXAMPLE"
  (:import-from "CL-TISP" "ECO-RENDER" "ZENEKINDARL-RENDER" "TEMPER-RENDER")
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

#+nil
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

#+nil
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

#+nil
(temper-render $temper-template (cl-toml:parse $toml-string))
