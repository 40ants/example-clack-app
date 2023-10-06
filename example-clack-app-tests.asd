(defsystem "example-clack-app-tests"
  :author "Alexander Artemenko <svetlyak.40wt@gmail.com>"
  :license "Unlicense"
  :homepage "https://40ants.com/example-clack-app/"
  :class :package-inferred-system
  :description "Provides tests for example-clack-app."
  :source-control (:git "https://github.com/40ants/example-clack-app")
  :bug-tracker "https://github.com/40ants/example-clack-app/issues"
  :pathname "t"
  :depends-on ("example-clack-app-tests/core")
  :perform (test-op (op c)
                    (unless (symbol-call :rove :run c)
                      (error "Tests failed"))))
