(defsystem "example-clack-app-ci"
  :author "Alexander Artemenko <svetlyak.40wt@gmail.com>"
  :license "Unlicense"
  :homepage "https://40ants.com/example-clack-app/"
  :class :package-inferred-system
  :description "Provides CI settings for example-clack-app."
  :source-control (:git "https://github.com/40ants/example-clack-app")
  :bug-tracker "https://github.com/40ants/example-clack-app/issues"
  :pathname "src"
  :depends-on ("40ants-ci"
               "example-clack-app-ci/ci"))
