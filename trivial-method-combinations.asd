;;;; trivial-method-combinations.asd

(asdf:defsystem #:trivial-method-combinations
  :description "Portability library for accessing method combination objects"
  :author "Michał \"phoe\" Herda <phoe@disroot.org>"
  :license  "Unlicense"
  :version "0.0.1"
  :serial t
  :depends-on (:closer-mop)
  :components ((:file "trivial-method-combinations")))
