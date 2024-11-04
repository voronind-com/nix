{ ... }: {
	text = ''
		shopt -s dotglob
		shopt -s globstar
		shopt -s autocd
		shopt -s extglob

		# Enable vim mode.
		bind 'set editing-mode vi'
		bind 'set show-mode-in-prompt on'
		bind 'set keyseq-timeout 0'

		# Set the mode string and cursor to indicate the vim mode
		#   For the number after `\e[`:
		#     0: blinking block
		#     1: blinking block (default)
		#     2: steady block
		#     3: blinking underline
		#     4: steady underline
		#     5: blinking bar (xterm)
		#     6: steady bar (xterm)
		bind 'set vi-ins-mode-string \1\e[6 q\2'
		bind 'set vi-cmd-mode-string \1\e[2 q\2'

		exec {BASH_XTRACEFD}>/dev/null
	'';
}
