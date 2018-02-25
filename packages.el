;;; packages.el --- w3m layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Kuroi Mato and Adam Beckmeyer
;;
;; Author: Kuroi Mato <venmos@fuck.gfw.es>, Adam Beckmeyer
;; URL: https://github.com/non-Jedi/w3m-layer
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Code:

(setq w3m-packages
      '(
        w3m
        helm-w3m
        ))

(defun spacemacs/w3m-mpv-current-url ()
  (interactive)
    (if (not w3m-current-url)
        (message "No current url.")
      (call-process "mpv" nil nil nil w3m-current-url)
      (message "Sorry, Playback error. Please check url.")))

(defun spacemacs/w3m-mpv-this-url ()
  (interactive)
  (let ((link (w3m-anchor)))
    (if (not link)
        (message "This point is not a link.")
      (call-process "mpv" nil nil nil link)
      (message "Sorry, Playback error. Please check url."))))

(defun v/w3m-copy-link ()
  (interactive)
  (let ((link (w3m-anchor)))
    (if (not link)
        (message "The point is not link.")
      (kill-new link)
      (message "Copy \"%s\" to clipboard." link))))

(defun w3m/init-helm-w3m ()
  "Initializes helm-w3m and adds keybindings for its exposed functionalities."
  (use-package helm-w3m
    :commands (helm-w3m-bookmarks)
    :init
    (progn
      (spacemacs/set-leader-keys
        "awb" 'helm-w3m-bookmarks))))

(defun w3m/init-w3m()
  "Initializes w3m and adds keybindings for its exposed functionalities."
  (use-package w3m
    :defer t
    :init
    (progn
        (evilified-state-evilify w3m-mode w3m-mode-map
          "y" 'evil-yank
          "d" 'evil-delete
          "0" 'evil-digit-argument-or-evil-beginning-of-line
          "$" 'evil-end-of-line
          "f" 'evil-find-char
          "F" 'evil-find-char-backward
          )
        (spacemacs/declare-prefix-for-mode 'w3m-mode "mo" "open")
        (spacemacs/declare-prefix-for-mode 'w3m-mode "moe" "external")
        (spacemacs/declare-prefix-for-mode 'w3m-mode "moet" "this url")
        (spacemacs/declare-prefix-for-mode 'w3m-mode "ms" "search")
        (spacemacs/declare-prefix-for-mode 'w3m-mode "mb" "buffer")
        (spacemacs/declare-prefix-for-mode 'w3m-mode "mm" "mark")
        (spacemacs/set-leader-keys-for-major-mode 'w3m-mode
          ;; general-purpose opening stuff
          "oo" 'w3m-goto-url
          "oO" 'w3m-goto-url-new-session
          "of" 'w3m-find-file
          "ot" 'w3m-view-this-url
          "oT" 'w3m-view-this-url-new-session
          ;; opening externally
          "oeo" 'w3m-external-view-current-url
          "oeto" 'w3m-external-view-this-url
          "oev" 'spacemacs/w3m-mpv-current-url
          "oetv" 'spacemacs/w3m-mpv-this-url
          ;; searching
          "ss" 'w3m-search
          "sS" 'w3m-search-new-session
          ;; navigating buffers
          "bj" 'w3m-next-buffer
          "bk" 'w3m-previous-buffer
          "bd" 'w3m-delete-buffer
          "bw" 'w3m-save-buffer
          ;; working with bookmarks
          "me" 'w3m-bookmark-edit
          "ma" 'w3m-bookmark-add-current-url
          "mm" 'helm-w3m-bookmarks
          "mM" 'w3m-bookmark-view
          ;; other stuff
          "y" 'v/w3m-copy-link
          ))))

(with-eval-after-load 'w3m
  (define-key w3m-mode-map (kbd "C-f") 'evil-scroll-page-down)
  (define-key w3m-mode-map (kbd "C-b") 'evil-scroll-page-up)
  (define-key w3m-mode-map (kbd "SPC") 'evil-evilified-state))

(defun v/init-w3m ()
  (use-package w3m
    :init
    (progn
      (setq browse-url-browser-function 'w3m-goto-url-new-session
            w3m-user-agent "Mozilla/5.0 (Linux; U; Android 2.3.3; zh-tw; HTC_Pyramid Build/GRI40) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533."
            w3m-coding-system 'utf-8
            w3m-file-coding-system 'utf-8
            w3m-file-name-coding-system 'utf-8
            w3m-input-coding-system 'utf-8
            w3m-output-coding-system 'utf-8
            w3m-terminal-coding-system 'utf-8))))

;;; packages.el ends here
