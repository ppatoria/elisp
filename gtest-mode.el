(defgroup gtest nil
  "Unit test"	
  :group 'tools)

(defun test-report()
  (interactive)
  (helm-swoop :$query "RUN")
  (helm-swoop :$query "OK")
  (helm-swoop :$query "PASSED")
  (helm-swoop :$query "FAILED")
  )

(defcustom test-filter-script "runtests.sh"
  "gtest filter"
  :group 'tools'
  :type 'string)

(defcustom test-target "iltest/testil/testil"
  "gtest target"
  :group 'tools'
  :type 'string)

(defcustom test-target-path "iltest/testil"
  "gtest target path"
  :group 'tools'
  :type 'string)

(defcustom test-target-script "iltest/testil/runTest.sh"
  "gtest target script"
  :group 'tools'
  :type 'string)

(defun test-run-all ()
  "This is generic version to run all the tests. It runs the
filter script set as global variable."
  (interactive)
  (shell-command(concat "source " test-filter-script "&")))


(defun test-run-all-trunk()
  "This is custom version for run all the tests from trunk."
  (interactive)
  (setq test-filter-scripts (concat "runtests.sh"))
  (test-run-all))

(defun test-list ()
  "This will list all the tests as per target path set in the global variable"
  (interactive)
  (add-to-list 'load-path test-target-path)
  (shell-command (concat test-target "--gtest_list_tests" "&")))

(defun test-run(filter)
  "Run gtests using the filter passed as parameter"
  (interactive "sFilter: ")
  (add-to-list 'load-path test-target-path)
  (shell-command (concat test-target " --gtest_filter=" filter "&")))

(defun test-run-using-script (filter)
  "Runs scripts which first set the required environment and than run the test"
  (interactive "sFilter: ")
  (add-to-list 'load-path test-target-path)
  (shell-command(concat "source " test-target-script " " filter "&")))

(defun test-run-at-point ()
  "run test at point"
  (interactive)
  (let (test)
    (setq test(concat "*" (thing-at-point 'symbol) "*"))
    (if(string-equal test "**")
	(setq test(concat "*" test "*"))
      (push (regex-quote test) regexp-history)
      (call-interactively(test-run test))
      )
    )
  )

(defun test-run-at-point-using-script ()
  "run test at point using script which first set the env"
  (interactive)
  (let (test)
    (setq test (concat "*" (thing-at-point 'symbol) "*"))
    (if (string-equal test "**")
	(setq test (concat "*" test "*"))
      (push( regexp-quote test) regexp-history)
      (call-interactively (test-run-using-script test))
      )
    )
  )
