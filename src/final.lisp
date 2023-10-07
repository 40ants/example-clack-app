(uiop:define-package #:example-clack-app/final
  (:use #:cl)
  (:import-from #:lack)
  (:import-from #:clack)
  (:import-from #:conduit)
  (:import-from #:lack.app.directory)
  (:export #:start))
(in-package #:example-clack-app/final)

(defvar *server* nil)


(defun main-app (env)
  (let ((method (getf env :request-method))
        (uri (getf env :path-info)))
    (list 200
          (list :content-type "text/html; charset=utf-8")
          (list (format nil "<p>Main App: Processing ~A to ~A"
                        method uri)
                "<p>Available routes:"
                "<p><a href=\"/static/README.md\">/static/README.md</a> - static files without without index pages support"
                "<p><a href=\"/blog/\">/blog/</a> - static blog pages with index pages support"
                "<p><a href=\"/admin/\">/admin/</a> - just an example of mounted clack app"
                "<p><a href=\"/realworld/\">/realworld/</a> - application combining REST API + JS frontend"))))

(defun admin-app (env)
  (let ((method (getf env :request-method))
        (uri (getf env :path-info)))
    (list 200
          (list :content-type "text/plain; charset=utf-8")
          (list (format nil "Admin App: Processing ~A to ~A"
                        method uri)))))


(defparameter *real-app*
  (lack:builder
   (:mount "/api" conduit.routes:app-routes)
   (make-instance 'lack.app.directory:lack-app-directory
                  :root (asdf:system-relative-pathname
                         :example-clack-app
                         "realworld-frontend/"))))


(defun start (&key (port 5000))
  (when *server*
    (clack:stop *server*))

  (conduit.auth:initialize-auth "changeit")
  (conduit.db:initialize-db
   (ensure-directories-exist (asdf:system-relative-pathname :conduit "db/conduit.db")))
  
  (setf *server*
        (clack:clackup
         (lack:builder 
          ;; For this middleware backslashes at the end of path
          ;; and directory name are mandatory. Omit one of them,
          ;; and it will not work as expected.
          :accesslog
          (:static :path "/static/"
                   :root (asdf:system-relative-pathname
                          :example-clack-app
                          "static/"))
          ;; Because of bug, we dont should to add a backslash
          ;; the end of path, otherwise app will not be mounted
          ;; as expected.
          (:mount "/blog" (make-instance 'lack.app.directory:lack-app-directory
                                         :root (asdf:system-relative-pathname
                                                :example-clack-app
                                                "blog/")))
          (:mount "/realworld" *real-app*)

          (:mount "/admin"
                  'admin-app)
          'main-app)
         :port port)))
