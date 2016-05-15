(defun search-test-fixture ()
  ""
  (interactive)
  (re-search-backward "^[_[:alnum:]]+[.]")
  (message "%s" (thing-at-point 'symbol t)))


(defun search-test-at-point_simple ()
  ""
  (interactive)
  (setq test (thing-at-point 'symbol t))
  (re-search-backward "^[_[:alnum:]]+[.]")
  (setq test-hierarchy-or-fixture (thing-at-point 'symbol t))
  (concat test-hierarchy-or-fixture "." test))

(defun test-s()
  (interactive)
  (message "%s" (search-test-at-point)))

(defun test-string-match ()
  (interactive)
  ;; (message "%s" (zerop (string-match "[.]" "currying_test.")))
  (if (string-match "[.]" "currying_test")
      (message "exists")
    (message "does not exists"))
)
  
(defun is-line-at-point-is-test-hierarchy-or-fixture ()
  ""
  (interactive)
  (string-match "[.]" (thing-at-point 'line t)))
      
(defun test-is-line-at-point-is-test-hierarchy-or-fixture ()
  ""
  (interactive)
  (message "%s" (is-line-at-point-is-test-hierarchy-or-fixture))
)

(defun search-test-at-point ()
  ""
  (interactive)
  (setq test (thing-at-point 'symbol t))
  (if (is-line-at-point-is-test-hierarchy-or-fixture)
      (concat test "*")
    (re-search-backward "^[_[:alnum:]]+[.]")
    (setq test-hierarchy-or-fixture (thing-at-point 'symbol t))
    (concat test-hierarchy-or-fixture "." test)))


;; (defun gtest-run-t  (filter)
;;   (interactive (list
;; 		(read-string (format "filter (%s): " (thing-at-point 'filter))
;; 			     nil nil (thing-at-point 'filter))))
;;     (message "The filter is %s" filter))
(defun gtest-run-t (filter)
  (interactive (list
		(read-string
		 (format "filter (%s): "
			 (concat "*" (thing-at-point 'symbol) "*"))
			     nil nil (thing-at-point 'symbol))))
    (message "The filter is %s" filter))
