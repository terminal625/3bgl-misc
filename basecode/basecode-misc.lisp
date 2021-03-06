(in-package #:basecode)

(defmacro with-pixel-ortho-projection ((w &key (scale 1) (origin :upper-left)) &body body)
  (alexandria:once-only (w)
    `(gl:with-pushed-matrix* (:projection)
       (gl:load-identity)
       (let ((right (/ (width ,w)
                       ,scale))
             (top (/ (height ,w)
                     ,scale)))
         ,(ecase origin
            (:upper-left
             `(glu:ortho-2d 0 right top 0))
            (:lower-left
             `(glu:ortho-2d 0 right 0 top))))
       (gl:matrix-mode :modelview)
       ,@body)))

(defmacro with-unit-ortho-projection ((win &key (scale 1) (origin :center))
                                      &body body)
  (alexandria:once-only (win)
    (alexandria:with-gensyms (aspect w h)
      `(gl:with-pushed-matrix* (:projection)
         (gl:load-identity)
         (let* ((,aspect (/ (float (width ,win))
                            (float (height ,win))))
                (,w (* ,scale
                       (if (<= ,aspect 1.0)
                           1.0
                           ,aspect)))
                (,h  (* ,scale
                        (if (> ,aspect 1.0)
                            1.0
                            ,aspect))))
           , (ecase origin
               (:center ;; -1 .. +1, possibly should be -0.5 .. 0.5?
                `(glu:ortho-2d (- ,w) ,w (- ,h) ,h))
               (:upper-left
                `(glu:ortho-2d 0 ,w ,h 0))
               (:lower-left
                `(glu:ortho-2d 0 ,w 0 ,h)))
           (gl:matrix-mode :modelview)
         ,@body)))))

(defclass basecode-clear ()
  ((clear-color :initarg :clear-color :initform '(0 0 0 1)
                :accessor clear-color)))

(defmethod basecode-draw :before ((w basecode-clear))
  (apply #'gl:clear-color (clear-color w))
  (gl:clear :color-buffer-bit :depth-buffer-bit))




(defclass basecode-draw-axes ()
  ((draw-axes-scale :initform 1.0 :accessor draw-axes-scale)))

(defmethod basecode-draw :after ((w basecode-draw-axes))
  (let ((r 0.0625))
    (gl:with-pushed-matrix* (:modelview)
      (gl:disable :lighting :texture-2d)
      (gl:with-primitives :triangle-strip
        (gl:color 0 0 1 1)
        (loop for i below 17
           for a = (* i (/ pi 8))
           for x = (* (draw-axes-scale w) r (sin a))
           for y = (* (draw-axes-scale w) r (cos a))
           for z = (draw-axes-scale w)
           do (gl:vertex x y 0)
             (gl:vertex x y z)))
      (gl:with-primitives :triangle-strip
        (gl:color 0 1 0 1)
        (loop for i below 17
           for a = (* i (/ pi 8))
           for x = (* (draw-axes-scale w) r (sin a))
           for y = (* (draw-axes-scale w) r (cos a))
           for z = (draw-axes-scale w)
           do (gl:vertex x 0 y)
             (gl:vertex x z y)))
      (gl:with-primitives :triangle-strip
        (gl:color 1 0 0 1)
        (loop for i below 17
           for a = (* i (/ pi 8))
           for x = (* (draw-axes-scale w) r (sin a))
           for y = (* (draw-axes-scale w) r (cos a))
           for z = (draw-axes-scale w)
           do (gl:vertex 0 x y)
             (gl:vertex z x y))))))


(defclass basecode-draw-ground-plane ()
  ((draw-ground-plane-grid-space :initform 1.0
                                 :accessor draw-ground-plane-grid-space)))

(defmethod basecode-draw :after ((w basecode-draw-ground-plane))
  (gl:with-pushed-matrix* (:modelview)
    (gl:disable :lighting :texture-2d)
    (gl:enable :blend :line-smooth :multisample :depth-test)
    (gl:polygon-mode :front-and-back :fill)
    (gl:enable :blend)
    (gl:blend-func :src-alpha :one-minus-src-alpha)
    (gl:with-primitives :triangles
      (gl:color 1 0.2 0.2 0.2)
      (gl:vertex -20 0 -20)
      (gl:vertex  20 0 -20)
      (gl:vertex  20 0  20)
      (gl:vertex -20 0 -20)
      (gl:vertex  20 0  20)
      (gl:vertex -20 0  20))
    (gl:color 1 0 0 0.7)
    (gl:line-width 10)
    (gl:with-pushed-matrix* (:modelview)
      (gl:translate 0.0 0.0 0.0)
      (gl:with-primitives :lines
        (gl:vertex -20 0 0)
        (gl:vertex  20 0 0)
        (gl:vertex 0 0 -20)
        (gl:vertex 0 0  20))
      (gl:color 0 1 0 0.7)
      (loop for i from -20 to 20
         when (zerop (mod i 5))
         do (gl:line-width 5)
         else
         do (gl:line-width 2)
         unless (zerop i)
           do
              (gl:with-primitives :lines
                (gl:vertex -20 0 i)
                (gl:vertex  20 0 i)
                (gl:vertex i 0 -20)
                (gl:vertex i 0  20))))
    (gl:with-primitives :triangles
      (gl:color 1 0 0 1)
      (gl:vertex 22 0 0)
      (gl:vertex 21 0 0.5)
      (gl:vertex 21 0 -0.5)

      (gl:color 0 1 0 1)
      (gl:vertex 0 0 22)
      (gl:vertex 0.5 0 21)
      (gl:vertex -0.5 0 21)

)
    (gl:line-width 1)))

