;;; kbdify.el --- Markup keyboard sequences for Markdown/HTML -*- lexical-binding: t -*-
;; Copyright 2026 by Dave Pearson <davep@davep.org>

;; Author: Dave Pearson <davep@davep.org>
;; Version: 1.0.0
;; Keywords: convenience, text
;; URL: https://github.com/davep/kbdify.el
;; Package-Requires: ((emacs "26.1"))

;; This program is free software: you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation, either version 3 of the License, or (at your
;; option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
;; Public License for more details.
;;
;; You should have received a copy of the GNU General Public License along
;; with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; kbdify.el provides a command that marks up keyboard sequences for Markdown/HTML.

;;; Code:

(require 'xml)

(defun kbdify ()
  "Mark up the text at point with <kbd> tags.

So given something like:

C-M-S-s-<up>

the result will be:

<kbd>C</kbd>-<kbd>M</kbd>-<kbd>S</kbd>-<kbd>s</kbd>-<kbd>&lt;up&gt;</kbd>"
  (interactive)
  (when-let* ((candidate (thing-at-point 'symbol t))
              (bounds (bounds-of-thing-at-point 'symbol)))
    (delete-region (car bounds) (cdr bounds))
    (insert (replace-regexp-in-string
             (rx (group (one-or-more (not (any "-" "+")))))
             (lambda (match)
               (format "<kbd>%s</kbd>" match))
             (xml-escape-string candidate) t))))

(provide 'kbdify)

;;; kbdify.el ends here
