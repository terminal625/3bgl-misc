(defsystem :3bgl-misc
  :depends-on (alexandria cl-glut cl-glu sb-cga zpb-ttf
                          glop classimp)
  :serial t
  :components
  ((:module "basecode"
            :serial t
            :components ((:file "package")
                         (:file "basecode")
                         (:file "basecode-glut")
                         (:file "basecode-glop")
                         (:file "basecode-projection")
                         (:file "basecode-camera")
                         (:file "basecode-misc")
                         (:file "basecode-exit-on-esc")
                         (:file "fps")
                         #++(:file "basecode-demo")))
   (:module "spline"
            :serial t
            :components ((:file "package")
                         (:file "quadratic")
                         (:file "spline-demo")))
   (:module "shader"
            :serial t
            :components ((:file "package")
                         (:file "ir")
                         (:file "walker")
                         (:file "glsl-base")
                         (:file "types")
                         (:file "printer")
                         (:file "compiler")))
   (:module "bench"
    :serial t
    :components ((:file "package")
                 (:file "bench")))
   #++(:module "ttf"
            :serial t
            :components
            ((:file "package")
             (:file "extrude")
             (:file "ttf-extrude-example")))))


