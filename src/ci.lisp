(uiop:define-package #:example-clack-app-ci/ci
  (:use #:cl)
  (:import-from #:40ants-ci/jobs/linter)
  (:import-from #:40ants-ci/jobs/run-tests
                #:run-tests)
  (:import-from #:40ants-ci/jobs/docs
                #:build-docs)
  (:import-from #:40ants-ci/workflow
                #:defworkflow))
(in-package #:example-clack-app-ci/ci)


(defworkflow linter
  :on-push-to "master"
  :by-cron "0 10 * * 1"
  :on-pull-request t
  :cache t
  :jobs ((40ants-ci/jobs/linter:linter
          :checkout-submodules t
          :asdf-systems ("example-clack-app"
                         "example-clack-app-docs"
                         "example-clack-app-tests"))))

(defworkflow docs
  :on-push-to "master"
  :by-cron "0 10 * * 1"
  :on-pull-request t
  :cache t
  :jobs ((build-docs
          ;; :checkout-submodules t
          :asdf-system "example-clack-app-docs")))


(defworkflow ci
  :on-push-to "master"
  :by-cron "0 10 * * 1"
  :on-pull-request t
  :cache t
  :jobs ((run-tests
          :checkout-submodules t
          :asdf-system "example-clack-app"
          :lisp ("sbcl-bin"
                 "ccl-bin")
          :coverage t)))
