;;; fibers.el --- Fibers for elisp                   -*- lexical-binding: t; -*-

;; Copyright (C) 2018  Raimon Grau

;; Author: Raimon Grau <raimon@konghq.com>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(defvar task-queue ())

(defun schedule-task (thunk)
  "Schedules a `thunk' into task-queue"
  (push thunk task-queue))

(defun run-tasks ()
  (let ((queue task-queue))
    (setq task-queue ())
    (mapc 'apply queue)))

(defvar current-fiber nil)

(defun spawn-fiber (fn)
  "This `fn'. "
  (let ((fiber (make-thread
                (lambda ()
                  (thread-yield)
                  (apply fn)))))
    (schedule-task (lambda () (resume-fiber fiber)))))

(defun resume-fiber (fiber &rest args)
  (let ((current-fiber fiber))
    ))

(mapcar 'thread-alive-p (mapcar 'make-thread '(1 2 3)))

(provide 'fibers)
;;; fibers.el ends here
