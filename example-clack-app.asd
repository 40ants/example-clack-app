(pushnew (merge-pathnames (make-pathname :directory '(:relative "realworld-api"))
                          (uiop:pathname-directory-pathname *load-truename*))
         asdf-utilities:*central-registry*
         :test #'equal)


#-asdf3.1 (error "example-clack-app requires ASDF 3.1 because for lower versions pathname does not work for package-inferred systems.")
(defsystem "example-clack-app"
  :description "Example Clack application showing how to use middlewares"
  :author "Alexander Artemenko <svetlyak.40wt@gmail.com>"
  :license "Unlicense"
  :homepage "https://40ants.com/example-clack-app/"
  :source-control (:git "https://github.com/40ants/example-clack-app")
  :bug-tracker "https://github.com/40ants/example-clack-app/issues"
  :class :40ants-asdf-system
  :defsystem-depends-on ("40ants-asdf-system")
  :pathname "src"
  :depends-on ("example-clack-app/core"
               "example-clack-app/final")
  :in-order-to ((test-op (test-op "example-clack-app-tests"))))


(register-system-packages "lack-app-directory" '("LACK.APP.DIRECTORY"))
