(in-package #:basecode)

(defclass basecode-demo (basecode-glut perspective-projection basecode-clear fps-graph basecode-draw-axes basecode-draw-ground-plane freelook-camera)
  ()
  (:default-initargs :look-at-eye '(8 1 4)))

(defmethod basecode-draw ((w basecode-demo))
  (gl:enable :depth-test)
  (gl:with-pushed-matrix* (:modelview)
    (gl:disable :cull-face :lighting)
    (gl:rotate (random 180.0) 1 1 0)
    (gl:with-primitives :triangles
      (gl:color 1 0 0 1)
      (gl:vertex 0 0 0)
      (gl:vertex 0 1 0)
      (gl:vertex 1 0 0)
      (gl:color 0 1 0 1)
      (gl:vertex 0 0 0)
      (gl:vertex 0 0 1)
      (gl:vertex 1 0 0)
      (gl:color 0 0 1 1)
      (gl:vertex 0 0 0)
      (gl:vertex 0 1 0)
      (gl:vertex 0 0 1))))

; (basecode-run (make-instance 'basecode-demo))