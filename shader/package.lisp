(defpackage #:3bgl-shaders
  (:use :cl))

(defpackage #:glsl
  (:use :cl)
  (:export
   :<<
   :>>
   :texture-2d
   :mat3
   :vec3
   :normalize
   :length
   :max
   :dot
   :sqrt
   :pow
   :glsl-defun
   :glsl-interface
   :glsl-attribute
   :glsl-output
   :@
   :glsl-defconstant
   :vec4
   :step
   :less-than
   :fract
   :floor
   :vec2
   :clamp
   :min
   :abs
   :generate-stage
   :glsl-input
   :gl-vertex-id
   :gl-instance-id
   :gl-per-vertex
   :gl_out
   :gl_in
   :gl-position
   :gl-point-size
   :gl-clip-distance
   :gl-primitive-id-in
   :gl-invocation-id
   :gl-primitive-id
   :gl-layer
   :gl-viewport-index
   :gl-patch-vertices-in
   :gl-tess-level-outer
   :gl-tess-level-inner
   :gl-tess-coord
   :gl-frag-coord
   :gl-front-facing
   :gl-point-coord
   :gl-sample-id
   :gl-sample-position
   :gl-sample-mask-in
   :gl-frag-depth
   :gl-sample-mask
   :glsl-uniform))