(declaim (sb-ext:muffle-conditions cl:style-warning))

(load "compiler.lisp")

(defpackage :primitive-recursion
  (:use :cl)                    ; import common lisp symbols
  (:export :parse)
  (:export :convert))   ; only export this

(in-package :primitive-recursion)


(defparameter s nil)
(defparameter l nil)
(defparameter i 0)

(defparameter f "")

(defparameter c 1)

(defun unwrap (s)
  (subseq (subseq s 2) 0 (- (length s) 3)))

(defun match (x)
  (if (eql l x)
    (progn
      (incf i)
      (unless (= i (length s)) (setf l (char s i))))
    (print "Match Error")))

(defun convert (x)
  (setf s x)
  (setf l (char s 0))
  (setf i 0)
  (setf f "")
  (setf c 1)
  (A)
  (if (= c 0) (print "Semantic Error"))
  (read-from-string f))
  

(defun parse (sentences)
  (let ((functions nil))
    (dolist (x sentences)
      (setf s x)
      (setf l (char s 0))
      (setf i 0)
      (setf f "")
      (setf c 1)
      (if (not (= (A) 0)) (setf c 0))
      (if (= c 0) 
        (setf sentences (remove x sentences))
        (setf functions (append functions (list (read-from-string f))))))
    (print (cl-user::execute sentences functions))))

(defun A ()
  (case l
    (#\C (let ((k)) (setf f (concatenate 'string f "(constant ")) (setf k (C)) (setf f (concatenate 'string f ")")) k))
    (#\S (let ((k)) (setf f (concatenate 'string f "(successor")) (setf k (S)) (setf f (concatenate 'string f ")")) k))
    (#\P (let ((k)) (setf f (concatenate 'string f "(projection ")) (setf k (P)) (setf f (concatenate 'string f ")")) k))
    (#\o (let ((k)) (setf f (concatenate 'string f "(composition ")) (setf k (O)) (setf f (concatenate 'string f ")")) k))
    (#\p (let ((k)) (setf f (concatenate 'string f "(recursion ")) (setf k (R)) (setf f (concatenate 'string f ")")) k))
    (otherwise (format t "A Error at (~A ~A)~%" l i))))

(defun C ()
  (if (eql l #\C)
    (let ((k))
      (match #\C)
      (match #\{)
      (setf f (concatenate 'string f (write-to-string (N 0)) " "))
      (match #\ )
      (setf k (N 0))
      (setf f (concatenate 'string f (write-to-string k)))
      (match #\})
      k)
    (print "C Error")))

(defun S ()
  (if (eql l #\S)
    (progn
      (match #\S)
      1)
    (print "S Error")))

(defun P ()
  (if (eql l #\P)
    (let ((k) (y))
      (match #\P)
      (match #\{)
      (setf y (N 0))
      (if (= 0 y) (setf c 0))
      (setf f (concatenate 'string f (write-to-string y) " "))
      (match #\ )
      (setf k (N 0))
      (if (> y k) (setf c 0))
      (setf f (concatenate 'string f (write-to-string k)))
      (match #\})
      k)
    (print "P Error")))

(defun O ()
  (if (eql l #\o)
    (let ((k) (hm) (gm))
      (match #\o)
      (match #\[)
      (setf hm (A))
      (match #\ )
      (setf f (concatenate 'string f " ("))
      (setf k (A))
      (setf gm (F 1 k))
      (if (not (= hm gm)) (setf c 0))
      (match #\])
      (setf f (concatenate 'string f ") " (write-to-string k)))
      k)
    (print "O Error")))

(defun R ()
  (if (eql l #\p)
    (let ((k))
      (match #\p)
      (match #\[)
      (setf k (A))
      (match #\ )
      (setf f (concatenate 'string f " "))
      ;(A)
      (if (not (= (+ k 2) (A))) (setf c 0))
      (match #\])
      (setf f (concatenate 'string f " " (write-to-string k)))
      (1+ k))
    (print "R Error")))

(defun F (n k) ;n = number of functions, k = each function is k-ary
  (case l
    (#\  (let ((m)) (match #\ ) (setf f (concatenate 'string f " ")) (if (not (= k (A))) (progn (setf c 0))) (setf m (F (1+ n) k))))
    (#\] n)
    (otherwise (print "F Error"))))

(defun N (n)
  (case l
    (#\0 (match #\0) n)
    (#\S 
      (let ((x))
        (S) (match #\() (setf x (N (1+ n))) (match #\)) x))
    (otherwise (print "N Error"))))

