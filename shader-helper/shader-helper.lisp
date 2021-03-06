(defpackage #:basecode-shader-helper
  (:use #:cl #:basecode))
(in-package #:basecode-shader-helper)

;; mixin for handling shader reloading with 3bgl-shader
(defclass basecode-shader-helper ()
  ((modified-shaders :accessor modified-shaders :initform nil)))

;; todo: add a mutex for this
(defparameter *running-loops* nil)
;; bound to a hash table within an running loop
(defvar *live-programs*)

;; hook for tracking modifications to programs not managed directly by
;; the window class
;; entries are any of:
;;   a function that returns a list of programs
;;   a program
;;   a list of programs
(defparameter *live-program-hooks* nil)

(defun shader-program-hook (p functions)
  (loop for f in functions
        do (pushnew p (gethash f *live-programs*))))

(defun forget-program (p)
  (loop for k in (alexandria:hash-table-keys *live-programs*)
        do (setf (gethash k *live-programs*)
                 (remove p (gethash k *live-programs*)))))

(defmethod shader-recompiled ((w basecode-shader-helper) shader)
  ;; hook for updating things after a shader is recompiled
  ;; (for example if size of ssbo changed or something)
  )

(defmethod run-main-loop :around ((w basecode-shader-helper))
  (let ((*live-programs* (make-hash-table))
        (3bgl-shaders::*shader-program-hook* 'shader-program-hook)
        (3bgl-shaders::*default-recompilation-callback*
          (list (lambda (s) (funcall 'shader-recompiled w s)))))
    ;; todo: add mutex for this
    (push w *running-loops*)
    (unwind-protect
         (call-next-method)
      ;; todo: add mutex for this
      (setf *running-loops* (remove w *running-loops*)))))


(defun modified-shader-hook (modified)
  (format t "saw modified functions ~s~%" modified)
  ;; todo: add a mutex for this
  (loop for w in *running-loops*
        do (setf (modified-shaders w)
                 (union (modified-shaders w)
                        modified))))

(pushnew 'modified-shader-hook 3bgl-shaders::*modified-function-hook*)

(defun recompile-modified-shaders (w)
  ;; todo: add a mutex for this
  (let ((modified (shiftf (modified-shaders w) nil))
        (more-programs (loop for hook in *live-program-hooks*
                             append (etypecase hook
                                      (3bgl-shaders::shader-program
                                       (list hook))
                                      (list
                                       hook)
                                      ((or function symbol)
                                       (funcall hook)))))
        (more-programs-map (make-hash-table)))
    (when modified
      (format t "~s ~s~%" modified more-programs)
      (format t "~s~%" (alexandria:hash-table-alist *live-programs*)))
    (loop for f in modified
          do (loop for p in (gethash f *live-programs*)
                   do (3bgl-shaders::flag-shader p f)))
    (loop for p in more-programs
          do (alexandria:maphash-values
              (lambda (v)
                (pushnew p (gethash v more-programs-map)))
              (3bgl-shaders::stages p)))
    (loop for f in modified
          do (loop for p in (gethash f more-programs-map)
                   do (3bgl-shaders::flag-shader p f)))))


(defmethod basecode-draw :around ((w basecode-shader-helper))
  (recompile-modified-shaders w)
  (call-next-method))


(defmethod mvp ((w freelook-camera) program &key (m (sb-cga:identity-matrix)))
  (let* ((v (basecode::freelook-camera-modelview w))
         (p (basecode::projection-matrix w))
         (mv (sb-cga:matrix* v m))
         (mvp (sb-cga:matrix* p v m)))
    (setf (3bgl-shaders::uniform program "time")
          (float
           (/ (get-internal-real-time)
              internal-time-units-per-second)))
    (setf (3bgl-shaders::uniform program "m") m
          (3bgl-shaders::uniform program "v") v
          (3bgl-shaders::uniform program "p") p
          (3bgl-shaders::uniform program "mv") mv
          (3bgl-shaders::uniform program "mvp") mvp
          (3bgl-shaders::uniform program "normalMatrix") mv
          (3bgl-shaders::uniform program "eyePos") (basecode::freelook-camera-position w))))

