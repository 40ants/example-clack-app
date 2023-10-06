(uiop:define-package #:example-clack-app-tests/core
  (:use #:cl)
  (:import-from #:rove
                #:deftest
                #:ok
                #:testing))
(in-package #:example-clack-app-tests/core)


(deftest test-example ()
  (ok t "Replace this test with something useful."))
