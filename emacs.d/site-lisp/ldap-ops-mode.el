(defgroup ldap-ops-mode nil
  "Mode for doing ldap searches/modifications"
  :version "0.5"
  :group 'applications)

(defcustom ldap-uri "ldap://ldap.csee.wvu.edu"
  "Specifies the URI of an LDAP server to connect to."
  :type '(string)
  :group 'ldap-ops-mode)

(defcustom ldap-base "dc=csee,dc=wvu,dc=edu"
  "Specifies the default base DN to use when performing ldap
operations"
  :type '(string)
  :group 'ldap-ops-mode)

(defcustom ldap-binddn nil
  "Specifies the default bind DN to use when performing ldap  operations."
  :type '(string)
  :group 'ldap-ops-mode)

(defcustom ldap-scope "sub"
  "Specify the scope of the search to be one of base, one, sub,
or children to specify a base object, one-level, subtree, or
children search, respectively. The default is sub."
  :type '(string)
  :group 'ldap-ops-mode)

(defcustom ldap-cmd "ldapsearch"
  "Specify the system command to use for ldap searches."
  :type '(string)
  :group 'ldap-ops-mode)

(defcustom ldap-search-options "-xLLL"
  "Specify any other options to pass to LDAP-CMD. The default is
simple authentication (-x) omitting all operational
comments (-LLL)."
  :type '(string)
  :group 'ldap-ops-mode)

(defun ldap-ops-mode
  "Enable or disable the ldap-ops minor mode."
  ;; Keep on with these docs:
  ;;; http://www.gnu.org/software/emacs/elisp/html_node/Minor-Mode-Conventions.html
  )

(defun ldap-build-search-command (&rest args)
  "Builds the COMMAND string for the `shell-command' call in
`ldap-search'"
  (let
      ((base "-b")
       (scope "-s")
       (host "-H")
       (options ldap-search-options))
    ;; ldapsearch -xLLL -s sub -H ldap://host -b dc=some,dc=host
    (combine-and-quote-strings (remove nil `(,ldap-cmd "-xLLL" ,scope ,ldap-scope ,host ,ldap-uri ,base ,ldap-base ,@args)))))

(defun ldap-search (filter &optional attrs)
  "Execute an ldap search for FILTER optionally returning only
the space separated list of attributes in ATTRS.

FILTER defaults to objectClass=*
ATTRS defaults to *

The syntax for FILTER and ATTRS is shown in these examples:

Filter: uid=rms
Filter: (&(objectClass=automount)(cn=cs*))

Attrs: uidNumber gidNumber gecos
Attrs: automountInformation"
  (interactive "sFilter:\nsAttrs:")
  (let
      ((ldap-base-cmd (ldap-build-search-command filter attrs)))
    (shell-command ldap-base-cmd)))
