(defsystem "example-clack-app-docs"
  :author "Alexander Artemenko <svetlyak.40wt@gmail.com>"
  :license "Unlicense"
  :homepage "https://40ants.com/example-clack-app/"
  :class :package-inferred-system
  :description "Provides documentation for example-clack-app."
  :source-control (:git "https://github.com/40ants/example-clack-app")
  :bug-tracker "https://github.com/40ants/example-clack-app/issues"
  :pathname "docs"
  :depends-on ("example-clack-app"
               "example-clack-app-docs/index"))
