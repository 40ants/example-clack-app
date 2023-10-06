(uiop:define-package #:example-clack-app/final
  (:use #:cl)
  (:import-from #:lack)
  (:import-from #:clack)
  (:import-from #:conduit)
  (:import-from #:lack.app.directory)
  (:export #:start))
(in-package #:example-clack-app/final)

(declaim (optimize (debug 3) (safety 3)))

(defvar *server* nil)


;; (defvar *api-app* (make-instance 'ningle))

(defun main-app (env)
  (let ((method (getf env :request-method))
        (uri (getf env :path-info)))
    (list 200
          (list :content-type "text/plain; charset=utf-8")
          (list (format nil "Main App: Processing ~A to ~A"
                        method uri)))))

(defun admin-app (env)
  (let ((method (getf env :request-method))
        (uri (getf env :path-info)))
    (list 200
          (list :content-type "text/plain; charset=utf-8")
          (list (format nil "Admin App: Processing ~A to ~A"
                        method uri)))))


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
          (:mount "/realworld" conduit.routes:app-routes)
          (:mount "/admin"
                  'admin-app)
          'main-app)
         :port port)))
