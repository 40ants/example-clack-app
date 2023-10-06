(uiop:define-package #:example-clack-app
  (:use #:cl)
  (:nicknames #:example-clack-app/core)
  (:export #:hello
           #:make-hello
           #:say
           #:user-name))
(in-package #:example-clack-app)


(defclass hello ()
  ((name :initarg :name
         :reader user-name))
  (:documentation "Example class."))


(defun make-hello (name)
  "Makes hello world example"
  (make-instance 'hello
                 :name name))


(defgeneric say (obj)
  (:documentation "Say what should be said.")
  (:method ((obj hello))
    (format nil "Hello, ~A!~%"
            (user-name obj))))
