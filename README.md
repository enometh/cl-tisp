# Tisp

A small templating engine written in Common Lisp. The goal is to be a basic `jinja2`-like templating system.

# Example

Given a a trivial example of this `toml` file:

```toml
[person]
name = "Foo Bar"
alive = true
```

And some template file with the following contents:

```
{{ if person.alive }}
{{ person.alive }} is not dead!
{{ else }}
{{ person.alive }} is dead 💀!
{{ end-if}}
```
