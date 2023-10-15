(uiop:define-package #:example-clack-app/step2
  (:use #:cl)
  (:import-from #:lack)
  (:import-from #:clack)
  (:import-from #:lack.app.directory)
  (:export #:start))
(in-package #:example-clack-app/step2)

(defvar *server* nil)


(defun main-app (env)
  (let ((method (getf env :request-method))
        (uri (getf env :path-info)))
    (list 200
          (list :content-type "text/html; charset=utf-8")
          (list (format nil "<p>Main App: Processing ~A to ~A"
                        method uri)
                "<p>Available routes:"
                "<p>Any of these lead to main app: <a href=\"/\">/</a>, <a href=\"/foo/\">/foo/</a>, <a href=\"/foo/\">/bar/</a>"))))


(defun start (&key (port 5000))
  (when *server*
    (clack:stop *server*))

  (setf *server*
        (clack:clackup
         (lack:builder 
          ;; 2 step
          :session
          (:accesslog :logger
                      (lambda (output)
                        (log:info output)))
          ;; 1 step
          'main-app)
         :port port)))
