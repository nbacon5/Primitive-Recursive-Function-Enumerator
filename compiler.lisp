(declaim (sb-ext:muffle-conditions cl:style-warning))

(defmacro successor ()
  (let ((arg (gensym)))
  `(lambda (,arg) (1+ ,arg))))

(defmacro constant (n k)
  (let ((args (mapcar (lambda (_) (gensym)) (make-list k))))
  `(lambda ,args 
     (declare ,@(mapcar (lambda (var) `(ignore ,var)) args))
     ,n)))

(defmacro projection (i k)
  (let* ((args (mapcar (lambda (_) (gensym)) (make-list k)))
        (chosen-arg (nth (1- i) args))
        (ignored-args (remove chosen-arg args)))
    `(lambda ,args 
       (declare ,@(mapcar (lambda (var) `(ignore ,var)) ignored-args))
       ,chosen-arg)))

(defmacro composition (h g k) ;g is a list of functions
  (let ((args (mapcar (lambda (_) (gensym)) (make-list k)))
        (h (macroexpand h))
        (g (mapcar #'macroexpand g)))
    `(lambda ,args (funcall ,h ,@(mapcar (lambda (f) `(funcall ,f ,@args)) g)))))

(defmacro recursion (g h k)
  (let* ((args (mapcar (lambda (_) (gensym)) (make-list (1+ k))))
        (g (macroexpand g))
        (h (macroexpand h))
        (f (gensym))
        (r (rest args)))
    `(labels ((,f ,args 
       (if (= ,(first args) 0)
         (funcall ,g ,@r)
         (funcall ,h (1- ,(first args)) (funcall #' ,f (1- ,(first args)) ,@r) ,@r))))
       #' ,f)))

(defparameter add (recursion (projection 1 1) (composition (successor) ((projection 2 3)) 3) 1))
(defparameter multiply (recursion (constant 0 1) (composition (macroexpand add) ((projection 2 3) (projection 3 3)) 3) 1))
(defparameter exponentiate (recursion (constant 1 1) (composition (macroexpand multiply) ((projection 2 3) (projection 3 3)) 3) 1))
(defparameter sum (recursion (constant 0 1) (composition (macroexpand add) ((projection 2 3) (composition (macroexpand exponentiate) ((projection 1 3) (projection 3 3)) 3)) 3) 1))

(defun execute (sentences functions)
  (mapcar (lambda (i o) (list o i)) sentences (mapcar (lambda (x) (funcall (eval (macroexpand x)))) functions)))
  ;(mapcar (lambda (x) (funcall (eval (macroexpand x)))) functions))
  ;(sort sentences #'< :key #'length))

(defun execute-max (sentences functions)
  (let ((maxv 0) (maxn 0) (l (length (first sentences))))
    (dotimes (n (length functions))
      (let ((x (funcall (eval (macroexpand (nth n functions))))))
        (if (> x maxv)
          (progn
            (setf maxv x)
            (setf maxn n)
            (setf l (length (nth n sentences))))
          (if (and (= x maxv) (< (length (nth x sentences)) (length (nth maxn sentences))))
            (progn
              (setf maxv x)
              (setf maxn n)
              (setf l (length (nth n sentences))))))))
    (print (nth maxn functions))
    (print maxv)
    (print (length functions))))

(defun test (x)
  (let ((nums))
    (dotimes (n 100)
      (setf nums (append nums (list n))))
    (mapcar (lambda (a) (funcall x a)) nums)))
