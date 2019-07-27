;; ----------------------------------------------------------------------------
;; Application Options
;; ###################

;; Disable GUI elements. Why?
;; .. they take up screen-space and are unnecessary, favor a minimal interface.
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Disable startup message. Why?
;; .. less noise is better.
(defun display-startup-echo-area-message ()
  (message ""))

;; Visual bell. Why?
;; Audible beeps are annoying.
(setq visible-bell 1)

;; Window Title:
;; Include the buffer name & modified status since they're both useful information.
;; Without this the title doesn't contain useful info.
(setq-default frame-title-format "%b %& emacs")

;; ----------------------------------------------------------------------------
;; Defaults
;; ########

;; Use UTF-8 everywhere. Why?
;; .. this is the most common encoding, saves hassles guessing and getting it wrong.
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

;; Show text instead prompts instead of dialog popups. Why?
;; .. because they're not as nice for quick keyboard access.
(setq use-dialog-box nil)

;; For text-mode prompts. Why?
;; .. answering just 'y' or 'n' is sufficient.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Store registers on exit. Why?
;; .. nice to keep macros available on restart.
(savehist-mode 1)
(setq savehist-additional-variables '(register-alist))

;; Don't use file backups. Why?
;; It adds cruft on the file-system which gets annoying.
(setq backup-inhibited t)
(setq auto-save-default nil)

;; Don't say anything on mode-line mouse-over
(setq mode-line-default-help-echo nil)

;; Show empty lines. Why?
;; Without this you can't tell if there are blank lines at the end of the file.
(setq-default indicate-empty-lines t)

;; Keep cursors and highlights in current window only
(setq cursor-in-non-selected-windows nil)
;; Don't highlight inactive windows.
(setq highlight-nonselected-windows nil)
;; Disable bidirectional text support. Why?
;; .. slight performance bonus.
(setq bidi-display-reordering nil)

;; No startup screen. Why?
;; .. No need to distract us with unnecessary info.
(setq inhibit-startup-screen t)

;; Don't show buffer list on startup. Why?
;; .. buffer switching gets in the way, you can manually switch between them.
(setq inhibit-startup-buffer-menu t)

;; Hide cursor while typing. Why?
;; .. it can overlap characters we want to see.
(setq make-pointer-invisible t)

;; Don't pause display on input. Why?
;; .. it can make display lag, especially when holding a key.
(setq redisplay-dont-pause t)

;; Don't put two spaces after full-stop. Why?
;; .. one space after a full-stop is sufficient in most documentation & comments.
(setq sentence-end-double-space nil)

;; ---------
;; Scrolling
;; =========

;; Scroll N lines to screen edge. Why?
;; .. having some margin is useful to see some lines above/below the lines you edit.
(setq scroll-margin 2)

;; Scroll back this many lines to being the cursor back on screen. Why?
;; .. Default behavior is to re-center which is jarring. Clamp to the scroll margin instead.
(setq scroll-conservatively scroll-margin)

;; Keyboard scroll one line at a time. Why?
;; .. having scrolling jump is jarring & unnecessary (use page up down in this case).
(setq scroll-step 1)
;; Mouse scroll N lines. Why?
;; .. speed is fast but slower than page up/down (a little personal preference).
(setq mouse-wheel-scroll-amount '(6 ((shift) . 1)))
;; Don't accelerate scrolling. Why?
;; .. it makes scrolling distance unpredictable.
(setq mouse-wheel-progressive-speed nil)
;; Don't use timer when scrolling. Why?
;; .. it's not especially useful, one less timer for a little less overhead.
(setq mouse-wheel-inhibit-click-time nil)

;; Preserve line/column (nicer page up/down). Why?
;; .. avoids having the cursor at the top/bottom edges.
(setq scroll-preserve-screen-position t)
;; Move the cursor to top/bottom even if the screen is viewing top/bottom (for page up/down). Why?
;; .. so pressing page/up down can move the cursor & the view to start/end of the buffer.
(setq scroll-error-top-bottom t)

;; Center after going to the next compiler error. Why?
;; .. don't get stuck at screen edges.
(setq next-error-recenter (quote (4)))

;; Always redraw immediately when scrolling. Why?
;; .. more responsive and doesn't hang.
(setq fast-but-imprecise-scrolling nil)
(setq jit-lock-defer-time 0)

;; -----------------
;; Clipboard Support
;; =================

;; Cutting & pasting use the system clipboard. Why?
;; .. integrates with the system clipboard for convenience.
(setq select-enable-clipboard t)

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; Paste at text-cursor instead of mouse-cursor location. Why?
;; .. allow selecting to paste while in insert-mode, instead of moving the text cursor.
(setq mouse-yank-at-point t)

;; ----------------------------------------------------------------------------
;; Editing Options
;; ###############

;; Case Sensitivity
;; ================

;; Be case sensitive. Why?
;; Results are less ambiguous, although this is personal preference too.

;; Case sensitive search.
(setq-default case-fold-search nil)
;; Case sensitive abbreviations.
(setq dabbrev-case-fold-search nil)


;; -----------
;; Indentation
;; ===========

;; yes, both are needed!
(setq default-tab-width 4)
(setq tab-width 4)
(setq default-fill-column 80)
(setq fill-column 80)
(setq-default evil-indent-convert-tabs nil)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default evil-shift-round nil)

;; ----------------------------------------------------------------------------
;; Packages
;; ########

(with-eval-after-load 'package
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

;; Auto-install use-package.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; This is only needed once, near the top of the file
(eval-when-compile
  (require 'use-package))

;; Download automatically. Why?
;; .. convenience, so on first start all packages are installed.
(setq use-package-always-ensure t)
;; Defer loading packages by default. Why?
;; .. faster startup for packages which are only activated on certain modes or key bindings.
(setq use-package-always-defer t)

;; Nice theme from Vim. Why?
;; .. personal preference.
(use-package inkpot-theme
  :demand t
  :config
  (load-theme 'inkpot t))

;; Main Vim emulation package. Why?
;; .. without this, you won't have Vim key bindings or modes.
(use-package evil
  :demand t
  :config
  ;; Initialize.
  (evil-mode)

  ;; For some reasons evils own search isn't default.
  (setq evil-search-module 'evil-search)
  (setq evil-ex-search-case 'sensitive))

;; Use evil numbers to increment & decrement. Why?
;; .. evil-mode doesn't include this Vim functionality.
(use-package evil-numbers)

;; Perform actions on surrounding characters. Why?
;; .. while not part of Vim, it's a useful & common package for developers.
(use-package evil-surround
  :demand t
  :config
  ;; Initialize.
  (global-evil-surround-mode 1))

;; Leader key support. Why?
;; .. this is part of Vim, but not part of evil-mode, use a package.
(use-package evil-leader
  :demand t
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  ;; EXAMPLE:
  ;; Interactive file name search.
  (evil-leader/set-key "k" 'find-file-in-project)
  ;; Interactive file content search (git).
  (evil-leader/set-key "f" 'counsel-git-grep)
  ;; Interactive current-file search.
  (evil-leader/set-key "s" 'swiper)
  ;; Interactive open-buffer switch.
  (evil-leader/set-key "b" 'counsel-switch-buffer))

;; Prompt for available keys after some delay. Why?
;; .. useful to see available keys after some delay, especially for evil-leader key.
(use-package which-key
  :demand t
  :config
  ;; Initialize.
  (which-key-mode))

;; Ivy completion. Why?
;; .. makes compleating various prompts for input much more friendly & interactive.
(use-package ivy
  :demand t
  :config
  (ivy-mode)

  ;; Always show half the window height. Why?
  ;; Useful when searching through large lists of content.
  (setq ivy-height-alist `((t . ,(lambda (caller) (/ (frame-height) 2)))))
  (setq ivy-display-style 'fancy)

  ;; Vim style keys in ivy (holding Ctrl).
  (define-key ivy-minibuffer-map (kbd "C-j") 'next-line)
  (define-key ivy-minibuffer-map (kbd "C-k") 'previous-line)

  (define-key ivy-minibuffer-map (kbd "C-h") 'minibuffer-keyboard-quit)
  (define-key ivy-minibuffer-map (kbd "C-l") 'ivy-done)

  ;; open and next
  (define-key ivy-minibuffer-map (kbd "C-M-j") 'ivy-next-line-and-call)
  (define-key ivy-minibuffer-map (kbd "C-M-k") 'ivy-previous-line-and-call)

  (define-key ivy-minibuffer-map (kbd "<C-return>") 'ivy-done)

  ;; so we can switch away
  (define-key ivy-minibuffer-map (kbd "C-w") 'evil-window-map))

;; Use for auto-complete. Why?
;; .. saves typing.
(use-package company
  :commands (company-complete-common company-dabbrev)
  :config
  (global-company-mode)
  (setq company-tooltip-limit 40)
  ;; Case sensitive completion of words in the current buffer.
  (setq company-dabbrev-downcase nil)

  ;; Keymap: hold Ctrl for Vim motion. Why?
  ;; .. we're already holding Ctrl, allow navigation at the same time.
  (define-key company-active-map (kbd "C-j") 'company-select-next-or-abort)
  (define-key company-active-map (kbd "C-k") 'company-select-previous-or-abort)
  (define-key company-active-map (kbd "C-l") 'company-complete-selection)
  (define-key company-active-map (kbd "C-h") 'company-abort)
  (define-key company-active-map (kbd "<C-return>") 'company-complete-selection)

  (define-key company-search-map (kbd "C-j") 'company-select-next)
  (define-key company-search-map (kbd "C-k") 'company-select-previous))

;; Use swiper for interactive buffer search. Why?
;; .. quickly search the buffer if useful.
(use-package swiper
  :commands (swiper))

;; Use counsel for project wide searches. Why?
;; .. interactive project wide search is incredibly useful.
(use-package counsel
  :commands (counsel-git-grep counsel-switch-buffer))

;; Use git-gutter. Why?
;; .. shows lines you have modified from the last commit.
(use-package git-gutter
  :demand t
  :config
  (global-git-gutter-mode))

;; Highlights numbers. Why?
;; .. emacs doesn't do this by default, use a package.
(use-package highlight-numbers
  :hook ((prog-mode) . highlight-numbers-mode))

;; Find file in project. Why?
;; .. interactively narrowing down other files in the project is very useful.
(use-package find-file-in-project
  :commands (find-file-in-project))

;; ---------------
;; Display Options
;; ===============

;; Show line numbers. Why?
;; Helpful to give context when reading errors & the current line is made more prominent.
(global-display-line-numbers-mode 1)

;; Show the column as well as the line. Why?
;; .. some compiler errors show the column which is useful to compare.
(setq column-number-mode t)

;; Show matching parentheses. Why?
;; .. handy for developers to match nested brackets.
(show-paren-mode 1)
;; Don't blink, it's too distracting.
(setq blink-matching-paren nil)
(setq show-paren-delay 0.2)
(setq show-paren-highlight-openparen t)
(setq show-paren-when-point-inside-paren t)

;; disable word-wrap
(set-default 'truncate-lines t)

;; ------------
;; File Formats
;; ============

;; Options for generic modes.
(add-hook
 'after-change-major-mode-hook
 (lambda ()
   (when (derived-mode-p 'text-mode)
     (flyspell-mode))
   (when (derived-mode-p 'prog-mode)
     (flyspell-prog-mode))))

;; ------
;; Markup
;; ------

(add-hook
 'org-mode-hook
 (lambda ()
   (setq-local fill-column 120)
   (setq-local tab-width 2)
   (setq-local evil-shift-width 2)
   (setq-local indent-tabs-mode nil)

   (setq-local ffip-patterns '("*.org"))))

;; ---------
;; Scripting
;; ---------

(add-hook
 'emacs-lisp-mode-hook
 (lambda ()
   (setq-local fill-column 120)
   (setq-local tab-width 2)
   (setq-local evil-shift-width 2)
   (setq-local indent-tabs-mode nil)

   (setq-local ffip-patterns '("*.el"))

   ;; Don't delimit on dashes or underscores. Why?
   ;; .. makes seaching for variable names inconvenient.
   (modify-syntax-entry ?- "w")
   (modify-syntax-entry ?_ "w")))

(add-hook
 'python-mode-hook
 (lambda ()
   (setq-local fill-column 80)
   (setq-local tab-width 4)
   (setq-local evil-shift-width 4)
   (setq-local indent-tabs-mode nil)

   (setq-local ffip-patterns '("*.py"))

   ;; don't show whitespace in Python mode (only trailing long lines).
   (setq-local local-cfg/use-show-whitespace nil)))

;; -----
;; Shell
;; -----

(add-hook
 'sh-mode-hook
 (lambda ()
   (setq-local fill-column 120)
   (setq-local tab-width 4)
   (setq-local evil-shift-width 4)
   (setq-local indent-tabs-mode nil)

   (setq-local ffip-patterns '("*.sh"))))

;; ---------------
;; Other Languages
;; ---------------

(add-hook
 'c-mode-hook
 (lambda ()
   (setq-local fill-column 120)
   (setq-local c-basic-offset 4)
   (setq-local tab-width 4)
   (setq-local evil-shift-width 4)
   (setq-local indent-tabs-mode nil)

   (setq-local ffip-patterns '("*.c" "*.cc" "*.cpp" "*.cxx" "*.h" "*.hh" "*.hpp" "*.hxx" "*.inl"))

   ;; Don't delimit on '_'. Why?
   ;; .. makes seaching for variable names inconvenient.
   (modify-syntax-entry ?_ "w")))

;; ----------------------------------------------------------------------------
;; Keymap
;; ######

;; Use secondary selection in insert mode, Why?
;; .. this is handy for quick middle mouse copy/paste while in insert mode.
(define-key evil-insert-state-map (kbd "<down-mouse-1>") 'mouse-drag-secondary)
(define-key evil-insert-state-map (kbd "<drag-mouse-1>") 'mouse-drag-secondary)
(define-key evil-insert-state-map (kbd "<mouse-1>") 'mouse-start-secondary)
;; De-select after copy, allows quick select-copy-paste.
(define-key evil-insert-state-map (kbd "<mouse-2>")
  (lambda (click) (interactive "*p")
    (when (overlay-start mouse-secondary-overlay)
      (mouse-yank-secondary click)
      (delete-overlay mouse-secondary-overlay))))

;; Vim increment/decrement keys.
(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-x") 'evil-numbers/dec-at-pt)

;; Auto complete using words from the buffer.
(define-key evil-insert-state-map (kbd "C-n") 'company-dabbrev)
;; Comprehensive auto-complete.
(define-key evil-insert-state-map (kbd "C-SPC") 'company-complete-common)

;; ----------------------------------------------------------------------------
;; Custom Variables
;; ################

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)