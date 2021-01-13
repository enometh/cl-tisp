(defpackage "CL-TISP-EXAMPLE"
  (:import-from "CL-TISP" "ECO-RENDER" "ZENEKINDARL-RENDER")
  (:use "CL"))
(in-package "CL-TISP-EXAMPLE")

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

(defvar $ztemplate "
{{ if person.alive }}
{{ var person.name }} is not dead!
{{ else }}
{{ var person.name }} is dead 💀!
{{ endif }}
")

#+nil
(zenekindarl-render $ztemplate (cl-toml:parse $toml-string))
