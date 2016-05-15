(defgroup gtest nil
  "gtest"	
  :group 'tools)


(defcustom gtest-target "iltest/testil/testil"
  "gtest target"
  :group 'tools'
  :type 'string)

(defun gtest-list ()
  "This will list all the tests as per target path set in the global variable"
  (interactive)
  (shell-command (concat gtest-target " --gtest_list_tests" "&")))

(defun gtest-run(filter)
  "Run gtests using the filter passed as parameter"
  (interactive "sFilter: ")
  (shell-command (concat gtest-target " --gtest_filter=" filter "&")))

(defun is-line-at-point-is-test-hierarchy-or-fixture ()
  ""
  (interactive)
  (string-match "[.]" (thing-at-point 'line t)))

(defun search-test-at-point ()
  ""
  (interactive)
  (setq test (thing-at-point 'symbol t))
  (if (is-line-at-point-is-test-hierarchy-or-fixture)
      (concat test "*")
    (re-search-backward "^[_[:alnum:]]+[.]")
    (setq test-hierarchy-or-fixture (thing-at-point 'symbol t))
    (concat test-hierarchy-or-fixture "." test)))

(defun gtest-run-at-point ()
  "run test at point"
  (interactive)
  (setq test (search-test-at-point))
  (push (regexp-quote test) regexp-history)
  (call-interactively(gtest-run test))
  )

(define-minor-mode gtest-mode
  "gtest runner"
  :lighter "gtest-mode"
  :keymap (let ((map (make-sparse-keymap)))
	    (define-key map (kbd "C-c l") 'gtest-list)
	    (define-key map (kbd "C-c t") 'gtest-run)
	    (define-key map (kbd "C-M-t") 'gtest-run)
	    map))
(provide 'gtest-mode)
	    
