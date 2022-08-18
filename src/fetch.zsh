
#--------------------------------------------------------------------#
# Fetch Suggestion                                                   #
#--------------------------------------------------------------------#
# Loops through all specified strategies and returns a suggestion
# from the first strategy to provide one.
#

_zsh_autosuggest_fetch_suggestion() {
	emulate -L zsh
	setopt EXTENDED_GLOB

	typeset -g suggestion
	local -a strategies
	local strategy
	local buffer="${1##[ $'\t\n']##}"

	# Ensure we are working with an array
	strategies=(${=ZSH_AUTOSUGGEST_STRATEGY})

	for strategy in $strategies; do
		# Try to get a suggestion from this strategy
		_zsh_autosuggest_strategy_$strategy "$buffer"

		# Ensure the suggestion matches the prefix
		[[ "$suggestion" != "$buffer"* ]] && unset suggestion

		# Break once we've found a valid suggestion
		[[ -n "$suggestion" ]] && break
	done
}
