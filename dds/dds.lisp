(in-package #:3bgl-dds)


(defparameter *dds-pixel-format-flags*
  '((:alpha-pixels . #x01)
    (:alpha . #x02)
    (:fourcc . #x04)
    (:indexed . #x20)
    (:rgb . #x40)
    (:yuv . #x200)
    (:luminance . #x20000)))

(defparameter *dds-header-flags*
  ;; caps, height, width, pixelformat are required, but docs say to ignore them
  ;; in readers and assume they are set
  '((:caps . 1)
    (:height . 2)
    (:width . 4)
    (:pitch . 8)
    (:pixelformat . #x1000)
    (:mipmapcount . #x00020000)
    (:linearsize . #x00080000)
    (:depth . #x00800000)))

(defparameter *dds-caps1*
  ;; texture required, docs say not to rely on texture or complex
  '((:complex . #x8)
    (:mipmap . #x400000)
    (:texture . #x1000)))

(defparameter *dds-caps2*
  '((:cubemap . #x200)
    (:cubemap+x . #x400)
    (:cubemap-x . #x400)
    (:cubemap+y . #x1000)
    (:cubemap-y . #x2000)
    (:cubemap+z . #x4000)
    (:cubemap-z . #x8000)
    (:volume . #x200000)))


(defparameter *dxgi-formats*
  '((:unknown . 0)
    (:r32g32b32a32-typeless . 1)
    (:r32g32b32a32-float . 2)
    (:r32g32b32a32-uint . 3)
    (:r32g32b32a32-sint . 4)
    (:r32g32b32-typeless . 5)
    (:r32g32b32-float . 6)
    (:r32g32b32-uint . 7)
    (:r32g32b32-sint . 8)
    (:r16g16b16a16-typeless . 9)
    (:r16g16b16a16-float . 10)
    (:r16g16b16a16-unorm . 11)
    (:r16g16b16a16-uint . 12)
    (:r16g16b16a16-snorm . 13)
    (:r16g16b16a16-sint . 14)
    (:r32g32-typeless . 15)
    (:r32g32-float . 16)
    (:r32g32-uint . 17)
    (:r32g32-sint . 18)
    (:r32g8x24-typeless . 19)
    (:d32-float-s8x24-uint . 20)
    (:r32-float-x8x24-typeless . 21)
    (:x32-typeless-g8x24-uint . 22)
    (:r10g10b10a2-typeless . 23)
    (:r10g10b10a2-unorm . 24)
    (:r10g10b10a2-uint . 25)
    (:r11g11b10-float . 26)
    (:r8g8b8a8-typeless . 27)
    (:r8g8b8a8-unorm . 28)
    (:r8g8b8a8-unorm-srgb . 29)
    (:r8g8b8a8-uint . 30)
    (:r8g8b8a8-snorm . 31)
    (:r8g8b8a8-sint . 32)
    (:r16g16-typeless . 33)
    (:r16g16-float . 34)
    (:r16g16-unorm . 35)
    (:r16g16-uint . 36)
    (:r16g16-snorm . 37)
    (:r16g16-sint . 38)
    (:r32-typeless . 39)
    (:d32-float . 40)
    (:r32-float . 41)
    (:r32-uint . 42)
    (:r32-sint . 43)
    (:r24g8-typeless . 44)
    (:d24-unorm-s8-uint . 45)
    (:r24-unorm-x8-typeless . 46)
    (:x24-typeless-g8-uint . 47)
    (:r8g8-typeless . 48)
    (:r8g8-unorm . 49)
    (:r8g8-uint . 50)
    (:r8g8-snorm . 51)
    (:r8g8-sint . 52)
    (:r16-typeless . 53)
    (:r16-float . 54)
    (:d16-unorm . 55)
    (:r16-unorm . 56)
    (:r16-uint . 57)
    (:r16-snorm . 58)
    (:r16-sint . 59)
    (:r8-typeless . 60)
    (:r8-unorm . 61)
    (:r8-uint . 62)
    (:r8-snorm . 63)
    (:r8-sint . 64)
    (:a8-unorm . 65)
    (:r1-unorm . 66)
    (:r9g9b9e5-sharedexp . 67)
    (:r8g8-b8g8-unorm . 68)
    (:g8r8-g8b8-unorm . 69)
    (:bc1-typeless . 70)
    (:bc1-unorm . 71)
    (:bc1-unorm-srgb . 72)
    (:bc2-typeless . 73)
    (:bc2-unorm . 74)
    (:bc2-unorm-srgb . 75)
    (:bc3-typeless . 76)
    (:bc3-unorm . 77)
    (:bc3-unorm-srgb . 78)
    (:bc4-typeless . 79)
    (:bc4-unorm . 80)
    (:bc4-snorm . 81)
    (:bc5-typeless . 82)
    (:bc5-unorm . 83)
    (:bc5-snorm . 84)
    (:b5g6r5-unorm . 85)
    (:b5g5r5a1-unorm . 86)
    (:b8g8r8a8-unorm . 87)
    (:b8g8r8x8-unorm . 88)
    (:r10g10b10-xr-bias-a2-unorm . 89)
    (:b8g8r8a8-typeless . 90)
    (:b8g8r8a8-unorm-srgb . 91)
    (:b8g8r8x8-typeless . 92)
    (:b8g8r8x8-unorm-srgb . 93)
    (:bc6h-typeless . 94)
    (:bc6h-uf16 . 95)
    (:bc6h-sf16 . 96)
    (:bc7-typeless . 97)
    (:bc7-unorm . 98)
    (:bc7-unorm-srgb . 99)
    (:ayuv . 100)
    (:y410 . 101)
    (:y416 . 102)
    (:nv12 . 103)
    (:p010 . 104)
    (:p016 . 105)
    (:420-opaque . 106)
    (:yuy2 . 107)
    (:y210 . 108)
    (:y216 . 109)
    (:nv11 . 110)
    (:ai44 . 111)
    (:ia44 . 112)
    (:p8 . 113)
    (:a8p8 . 114)
    (:b4g4r4a4-unorm . 115)))

(defparameter *dds-4cc*
  (loop for i in '(:dx10 :dxt1 :dxt2 :dxt3 :dxt4 :dxt5 :bc4u :bc4s :ati2 :bc5s :rgbg :grgb :uyvy :yuy2)
     collect (cons i
                   (loop for c across (string i)
                      for s below 4
                      sum (ash (char-code c) (* s 8))))))

(defparameter *dds-4cc-or-dxgi-format* ;; for buggy files
  (append *dds-4cc* *dxgi-formats*))

(defparameter *dds-format-params*
  ;; name 4cc/format decodable block-size components pixel-octets internal-format &optional format type normalized
  ;; (block-size = nil for uncompressed)
  ;; format/type = values for tex-image-2d, NIL for compressed tex
  `(#++(:dx10 808540228)
    (:dxt1 827611204 t 8 nil nil :compressed-rgba-s3tc-dxt1-ext)
    ;; dxt2 = premultiplied alpha, unsupported in gl
    (:dxt2 844388420 t 16 nil nil nil)
    (:dxt3 861165636 t 16 nil nil :compressed-rgba-s3tc-dxt3-ext)
    ;; dxt4 = premultiplied alpha, unsupported in gl
    (:dxt4 877942852 t 16 nil nil nil)
    (:dxt5 894720068 t 16 nil nil :compressed-rgba-s3tc-dxt5-ext)
    (:ati1 1429488450 t 16 nil nil :compressed-red-rgtc1-ext)
    (:bc4u 1429488450 t 16 nil nil :compressed-red-rgtc1-ext)
    (:bc4s 1395934018 t 16 nil nil :compressed-signed-red-rgtc1-ext)
    (:ati2 843666497 t 16 nil nil :compressed-red-green-rgtc2-ext)
    (:bc5s 1395999554 t 16 nil nil :compressed-signed-red-green-rgtc2-ext)
    #++(:rgbg 1195525970)
    #++(:grgb 1111970375)
    #++(:uyvy 1498831189)
    #++(:yuy2 844715353)
    #++(:unknown 0 nil)
    #++(:r32g32b32a32-typeless 1 t nil 4 4 nil)
    (:r32g32b32a32-float 2 t nil 4 16 :rgba32f :rgba :float)
    (:r32g32b32a32-uint 3 t nil 4 16 :rgba32ui :rgba :unsigned-int)
    (:r32g32b32a32-sint 4 t nil 4 16 :rgba32i :rgba :int)
    #++(:r32g32b32-typeless 5)
    (:r32g32b32-float 6 t nil 3 12 :rgb32f :rgb :float)
    (:r32g32b32-uint 7 t nil 3 12 :rgb32ui :rgb :unsigned-int)
    (:r32g32b32-sint 8 t nil 3 12 :rgb32i :rgb :int)
    #++(:r16g16b16a16-typeless 9)
    (:r16g16b16a16-float 10 t nil 4 8 :rgba16f :rgba :half-float)
    (:r16g16b16a16-unorm 11 t nil 4 8 :rgba16 :rgba :unsigned-short t)
    (:r16g16b16a16-uint 12 t nil 4 8 :rgba16ui :rgba :unsigned-short)
    (:r16g16b16a16-snorm 13 t nil 4 8 :rgba16-snorm :rgba :signed-short t)
    (:r16g16b16a16-sint 14 t nil 4 8 :rgba16i :rgba :signed-short)
    #++(:r32g32-typeless 15)
    (:r32g32-float 16 t nil 2 8 :rg32f :rg :float)
    (:r32g32-uint 17 t nil 2 8 :rg32ui :rg :unsigned-int)
    (:r32g32-sint 18 t nil 2 8 :rg32i :rg :signed-int)
    #++(:r32g8x24-typeless 19)
    #++(:d32-float-s8x24-uint 20)
    #++(:r32-float-x8x24-typeless 21)
    #++(:x32-typeless-g8x24-uint 22)
    #++(:r10g10b10a2-typeless 23)
    (:r10g10b10a2-unorm 24 t nil 4 4 :rgb10-a2 :rgba :unsigned-int-10-10-10-2 t)
    (:r10g10b10a2-uint 25 t nil 4 4 :rgb10-a2ui :rgba :unsigned-int-10-10-10-2)
    (:r11g11b10-float 26 t nil 4 4 :r11f-g11f-b10f :rgb :unsigned-int-10f-11f-11f-rev)
    #++(:r8g8b8a8-typeless 27)
    (:r8g8b8a8-unorm 28 t nil 4 4 :rgba8 :rgba :unsigned-byte t)
    (:r8g8b8a8-unorm-srgb 29 t nil 4 4 :srgb8-alpha8 :rgba :unsigned-byte t)
    (:r8g8b8a8-uint 30 t nil 4 4 :rgba8ui :rgba :unsigned-byte)
    (:r8g8b8a8-snorm 31 t nil 4 4 :rgba8-snorm :rgba :signed-byte t)
    (:r8g8b8a8-sint 32 t nil 4 4 :rgba8i :rgba :unsigned-byte)
    #++(:r16g16-typeless 33)
    (:r16g16-float 34 t nil 2 4 :rg16f :rg :half-float)
    (:r16g16-unorm 35 t nil 2 4 :rg16 :rg :unsigned-short t)
    (:r16g16-uint 36 t nil 2 4 :rg16ui :rg :unsigned-short)
    (:r16g16-snorm 37 t nil 2 4 :rg16 :rg :signed-short t)
    (:r16g16-sint 38 t nil 2 4 :rg16i :rg :signed-short)
    #++(:r32-typeless 39)
    (:d32-float 40 t nil 1 4 :depth-component :depth-component :float)
    (:r32-float 41 t nil 1 4 :r32f :r :float)
    (:r32-uint 42 t nil 1 4 :r32i :r :unsigned-int)
    (:r32-sint 43 t nil 1 4 :r32i :r :signed-int)
    #++(:r24g8-typeless 44)
    #++(:d24-unorm-s8-uint 45)
    #++(:r24-unorm-x8-typeless 46)
    #++(:x24-typeless-g8-uint 47)
    #++(:r8g8-typeless 48)
    (:r8g8-unorm 49 t nil 2 2 :rg8 :rg :unsigned-byte t)
    (:r8g8-uint 50 t nil 2 2 :rg8ui :rg :unsigned-byte t)
    (:r8g8-snorm 51 t nil 2 2 :rg8 :rg :signed-byte t)
    (:r8g8-sint 52 t nil 2 2 :rg8i :rg :signed-byte)
    #++(:r16-typeless 53)
    (:r16-float 54 t nil 1 2 :r16f :r :half-float)
    (:d16-unorm 55 t nil 1 2 :depth-component :depth-component :unsigned-short t)
    (:r16-unorm 56 t nil 1 2 :r16 :r :unsigned-short t)
    (:r16-uint 57 t nil 1 2 :r16ui :r :unsigned-short)
    (:r16-snorm 58 t nil 1 2 :r16 :r :signed-short t)
    (:r16-sint 59 t nil 1 2 :r16i :r :signed-short)
    #++(:r8-typeless 60)
    (:r8-unorm 61 t nil 1 1 :r8 :r :unsigned-byte t)
    (:r8-uint 62 t nil 1 1 :r8ui :r :unsigned-byte)
    (:r8-snorm 63 t nil 1 1 :r8 :r :signed-byte t)
    (:r8-sint 64 t nil 1 1 :r8i :r :signed-byte)
    #++(:a8-unorm 65)
    #++(:r1-unorm 66)
    #++(:r9g9b9e5-sharedexp 67)
    #++(:r8g8-b8g8-unorm 68)
    #++(:g8r8-g8b8-unorm 69)
    #++(:bc1-typeless 70)
    #++(:bc1-unorm 71)
    #++(:bc1-unorm-srgb 72)
    #++(:bc2-typeless 73)
    #++(:bc2-unorm 74)
    #++(:bc2-unorm-srgb 75)
    #++(:bc3-typeless 76)
    #++(:bc3-unorm 77)
    #++(:bc3-unorm-srgb 78)
    #++(:bc4-typeless 79)
    #++(:bc4-unorm 80)
    #++(:bc4-snorm 81)
    #++(:bc5-typeless 82)
    #++(:bc5-unorm 83)
    #++(:bc5-snorm 84)
    #++(:b5g6r5-unorm 85)
    #++(:b5g5r5a1-unorm 86)
    #++(:b8g8r8a8-unorm 87)
    #++(:b8g8r8x8-unorm 88)
    #++(:r10g10b10-xr-bias-a2-unorm 89)
    #++(:b8g8r8a8-typeless 90)
    #++(:b8g8r8a8-unorm-srgb 91)
    #++(:b8g8r8x8-typeless 92)
    #++(:b8g8r8x8-unorm-srgb 93)
    #++(:bc6h-typeless 94)
    #++(:bc6h-uf16 95)
    #++(:bc6h-sf16 96)
    #++(:bc7-typeless 97)
    #++(:bc7-unorm 98)
    #++(:bc7-unorm-srgb 99)
    #++(:ayuv 100)
    #++(:y410 101)
    #++(:y416 102)
    #++(:nv12 103)
    #++(:p010 104)
    #++(:p016 105)
    #++(:420-opaque 106)
    #++(:yuy2 107)
    #++(:y210 108)
    #++(:y216 109)
    #++(:nv11 110)
    #++(:ai44 111)
    #++(:ia44 112)
    #++(:p8 113)
    #++(:a8p8 114)
    #++(:b4g4r4a4-unorm 115)))

(defparameter *dds-resource-dimension*
  '((:unknown . 0)
    (:buffer . 1)
    (:texture-1d . 2)
    (:texture-2d . 3)
    (:texture-3d . 4)))

(defparameter *dds-dx10-misc-flags*
  '((:generate-mips . 1)
    (:shared . 2)
    (:texture-cube . 4)
    (:shared-keyedmutex . #x10)
    (:gdi-compatible . #x20)))


(define-binary-type unsigned-integer-le (bytes bits-per-byte)
  (:reader (in)
    (loop
      with value = 0
      for low-bit from 0 to (* bits-per-byte (1- bytes)) by bits-per-byte
      do (setf (ldb (byte bits-per-byte low-bit) value) (read-byte in))
      finally (return value)))
  (:writer (out value)
    (loop for low-bit from 0 to (* bits-per-byte (1- bytes)) by bits-per-byte
       do (write-byte (ldb (byte bits-per-byte low-bit) value) out))))


(define-binary-type octets (l)
  (:reader (in)
    (let ((s (make-array l :element-type '(unsigned-byte 8))))
      (read-sequence s in)
      s))
  (:writer (out octets)
    (write-sequence octets out)))

(define-binary-type words (l type)
  (:reader (in)
           (loop for i below l collect (read-value type in)))
  (:writer (out words)
           (loop for i in words do (write-value type out i))))


(define-binary-type optional (type if)
  (:reader (in)
           (when if (read-value type in)))
  (:writer (out value)
           (when if (write-value type out value))))


(define-binary-type u32le () (unsigned-integer-le :bytes 4 :bits-per-byte 8))

(define-binary-type flags (alist)
  (:reader (in)
           (let ((f (read-value 'u32le in))
                 (v nil))
             (when alist
               (setf v
                     (loop for (n . v) in alist
                           when (= v (logand v f))
                             collect n
                             and do (setf f (logand f (lognot v))))))
             (if (and v (plusp f))
                 (list* f v)
                 (or v f))))
  (:writer (out flags)
           (if (numberp flags)
               (write-value 'u32le out flags)
               (let ((x 0))
                 (loop for f in flags
                       when (numberp f)
                         do (setf x (logior x f))
                       else do (setf x (logior x (cdr (assoc f alist)))))
                 (write-value 'u32le out x)))))

(define-binary-type enum (alist)
  (:reader (in)
           (let ((f (read-value 'u32le in)))
             (or (car (rassoc f alist)) f)))
  (:writer (out enum)
           (if (numberp enum)
               (write-value 'u32le out enum)
               (write-value 'u32le out (cdr (assoc enum alist))))))

(define-binary-class sized ()
  ())

;; fixme: figure out how to do this cleanly without using unexported symbols
(defmethod binary-data::read-object :around ((o sized) stream)
  (let* ((pos (file-position stream))
         (size (read-value 'u32le stream))
         (end (+ pos size)))
    (prog1
        (call-next-method)
      (assert (<= (file-position stream) end))
      (file-position stream end))))

(defmethod binary-data::write-object :around ((o sized) stream)
  (let* ((start (file-position stream)))
    ;; write temporary size
    (write-value 'u32le stream 0)
    ;; write object
    (call-next-method)
    ;; calculate size, seek back to start, write size, seek to end
    (let* ((end (file-position stream))
           (size (- end start)))
      (file-position stream start)
      (write-value 'u32le stream size)
      (file-position stream end))))

(define-binary-class dds-pixel-format (sized)
  ((flags (flags :alist *dds-pixel-format-flags*))
   (fourcc (enum :alist *dds-4cc-or-dxgi-format*))
   (rgb-bit-count u32le)
   (r-bitmask u32le)
   (g-bitmask u32le)
   (b-bitmask u32le)
   (a-bitmask u32le)))

(define-binary-class dds-header (sized)
  ((flags (flags :alist *dds-header-flags*))
   (height u32le)
   (width u32le)
   (pitch-or-linear-size u32le)
   (depth u32le)
   (mip-count u32le)
   (res (words :l 11 :type 'u32le))
   (pixel-format dds-pixel-format )
   (caps (flags :alist *dds-caps1*))
   (caps2 (flags :alist *dds-caps2*))
   (caps3 u32le)
   (caps4 u32le )
   (reserved2 u32le)
  ))

(define-binary-class dds-dx10-header ()
  ((dx-format (enum :alist *dxgi-formats*))
   (dimension (enum :alist *dds-resource-dimension*))
   (misc-flags (flags :alist *dds-dx10-misc-flags*))
   (array-size u32le)
   (reserved u32le)))

(defun calculate-linear-size (header block-size &optional (mip 0) (bpp nil))
  (let ((w (max 1 (floor (width header) (expt 2 mip))))
        (h (max 1 (floor (height header) (expt 2 mip)))))
    (cond
      ;; already in header, just return it
      #++((member :linearsize (flags header))
       (pitch-or-linear-size header))
      ((member :pitch (flags header))
       (* (height header)
          (pitch-or-linear-size header)))
      ;; otherwise try to calculate it
      ((numberp block-size)
       #++
       (format t "~s x ~s , ~s @ ~s -> ~s~%" w h block-size mip
               (* (max 1 (ceiling w 4))
                  (max 1 (ceiling h 4))
                  block-size))
       (* (max 1 (ceiling w 4))
          (max 1 (ceiling h 4))
          block-size))
      #++((member :luminance (flags (pixel-format header)))
          (* (width header) (height header)))
      ((symbolp block-size)
       #++
       (format t "~s x ~s , ~s / ~s @ ~s -> ~s~%" w h block-size bpp mip
                      (* w h
          (or bpp
              (ecase block-size
                (:luminance 1) (:luminance-alpha 2) (:rgb 3) (:rgba 4)))))
       (* w h
          (or bpp
              (ecase block-size
                (:luminance 1) (:luminance-alpha 2) (:rgb 3) (:rgba 4)))))
      (t
       (error "don't know how to calculate size of data for this dds file?")
       ))))

(define-binary-type dds-images ()
  (:reader (in)
           (let ((*print-array* nil)
                 #++(*print-length* 16))
             ;;(print (flags (header (current-binary-object))))
             ;;(print (flags (pixel-format (header (current-binary-object)))))
             ;;(print (fourcc (pixel-format (header (current-binary-object)))))
             (progn
              (let* ((o (current-binary-object))
                     (header (header o)))
                (labels ((flag (x) (member x (flags header)))
                         (pf-flag (x) (member x (flags (pixel-format header))))
                         (no-4cc ()
                           (let ((luminance (pf-flag :luminance))
                                 (rgb (pf-flag :rgb))
                                 (alpha (pf-flag :alpha-pixels)))
                             (when (not (pf-flag :fourcc))
                               #++(format t "~s ~s/~s/~s/~s ~s~%"
                                       (flags (pixel-format header))
                                       (r-bitmask (pixel-format header))
                                       (g-bitmask (pixel-format header))
                                       (b-bitmask (pixel-format header))
                                       (a-bitmask (pixel-format header))
                                       (rgb-bit-count (pixel-format header))
                                       )
                               (cond
                                 ((and luminance (not alpha))
                                  :luminance)
                                 ((and luminance alpha)
                                  :luminance-alpha)
                                 ((and rgb (not alpha))
                                  (if (= (rgb-bit-count (pixel-format header))
                                         16)
                                      (values :rgb :rgb :unsigned-short-5-6-5 2)
                                      :rgb))
                                 ((and rgb alpha)
                                  :rgba)
                                 (t nil))))))
                  (let* ((format (or (and (dx10 o) (dx-format (dx10 o)))
                                     (and (pf-flag :fourcc)
                                          (fourcc (pixel-format header)))))
                         (params (cddr (assoc format *dds-format-params*))))
                    (cond
                      ;; handle some special cases/unusual formats
                      ((multiple-value-bind (if f type bpp) (no-4cc)
                         ;; various uncompressed texture formats
                         ;; fixme: handle varying bit depths?
                         (when if
                           #++(format t "~&f = ~s/~s/~s/~s~%" if f type bpp)
                           (list :width (width header)
                                 :height (height header)
                                 :compressed nil
                                 :internal-format if
                                 :format (or f if)
                                 :type (or type :unsigned-byte)
                                 :normalized t
                                 :mips
                                 (loop for i below (if (flag :mipmapcount)
                                                       (mip-count header)
                                                       1)
                                       for s = (calculate-linear-size header
                                                                      if
                                                                      i
                                                                      bpp)
                                       collect (read-value 'octets in :l s))))))
                      ((not (and params (car params)))
                       ;; give up
                       (error "don't know how to parse format ~s flags=~s, pf flags = ~s" format (flags header) (flags (pixel-format header))))
                      (t(destructuring-bind (decodable block-size components octets
                                             internal-format
                                             &optional format type normalized)
                            params
                          (declare (ignorable decodable components octets))
                          #++(format t "if=~s~%" internal-format)
                          (list :width (width header)
                                :height (height header)
                                :compressed (if block-size t nil)
                                :internal-format internal-format
                                :format format
                                :type type
                                :normalized normalized
                                :mips
                                (loop for i below (if (flag :mipmapcount)
                                                      (mip-count header)
                                                      1)
                                      for s = (calculate-linear-size header
                                                                     block-size
                                                                     i)
                                      collect (read-value 'octets in :l s))))))))))))
  (:writer (out stream)
           (declare (ignore out stream))
           (error "don't know how to write .dds image data yet")))

(define-binary-class dds-file ()
  ((magic (iso-8859-1-string :length 4))
   (header dds-header)
   (dx10 (optional :type 'dds-dx10-header
                   :if (eq :dx10 (fourcc (pixel-format header)))))
   (images dds-images)))


#++
(with-open-file (in "/tmp/diffuse.dds"
                    :element-type '(unsigned-byte 8))
  (binary-data:read-value 'dds-file in))


(defmethod tex-image-2d ((dds dds-file) &key (level 0))
  (destructuring-bind (&key width height compressed internal-format format type normalized mips) (images dds)
    (declare (ignore normalized))
    (loop for mip in mips
          for w = width then (max 1 (floor w 2))
          for h = height then (max 1 (floor h 2))
          for level from level
          do (if compressed
                 (gl:compressed-tex-image-2d :texture-2d level internal-format
                                             w h 0 mip)
                 (gl:tex-image-2d :texture-2d level internal-format w h 0
                                  format type mip)))
    ;; return number of mipmap levels loaded
    (length mips)))

(defmethod tex-image-2d ((filename string) &key (level 0))
  (with-open-file (in filename :element-type '(unsigned-byte 8))
    (tex-image-2d (read-value 'dds-file in) :level level)))

(defmethod tex-image-2d ((filename pathname) &key (level 0))
  (with-open-file (in filename :element-type '(unsigned-byte 8))
    (tex-image-2d (read-value 'dds-file in) :level level)))












