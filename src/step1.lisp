(uiop:define-package #:example-clack-app/step1
  (:use #:cl)
  (:import-from #:lack)
  (:import-from #:clack)
  (:import-from #:lack.app.directory)
  (:export #:start))
(in-package #:example-clack-app/step1)

(defvar *server* nil)


(defun main-app (env)
  (let ((method (getf env :request-method))
        (uri (getf env :path-info)))
    (list 200
          (list :content-type "text/html; charset=utf-8")
          (list (format nil "<p>Main App: Processing ~A to ~A"
                        method uri)
                "<p>ROUTES:"
                "<p>Any of these lead to main app: <a href=\"/\">/</a>, <a href=\"/foo/\">/foo/</a>, <a href=\"/foo/\">/bar/</a>"))))


(defun start (&key (port 5000))
  (when *server*
    (clack:stop *server*))

  (setf *server*
        (clack:clackup
         'main-app
         :port port)))
