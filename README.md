# Tisp

A small templating engine written in Common Lisp. The goal is to be a basic `jinja2`-like templating system.

# Example

Given a a trivial example of this `toml` file called `person.toml`:

```toml
[person]
name = "Foo Bar"
alive = true
```

And some template file `template-file.tisp` with the following contents:

```
{{ if person.alive }}
{{ person.alive }} is not dead!
{{ else }}
{{ person.alive }} is dead 💀!
{{ end-if}}
```

Running the `cl-tisp` executable should give you the rendered file:

```bash
$ tisp render -t person.toml -f template-file.tisp -o rendered-file
$ cat rendered-file
Foo Bar is not dead!
```
