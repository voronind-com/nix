{ ... }: {
	text = ''
		# Git push.
		function gps() {
			git push "''${@}"
		}

		# Git push all (branches). Useful for pushing all stuff to a new remote.
		function gpsa() {
			local remotes=($(git remote))
			for remote in ''${remotes[@]}; do
				echo -n "''${remote}: "
				git push "''${remote}" --tags "refs/remotes/origin/*:refs/heads/*"
			done
		}

		# Git force push.
		function gpsf() {
			git push --force "''${@}"
		}

		# Git pull.
		function gpl() {
			git pull "''${@}"
		}

		# Git log.
		function gl() {
			git log --show-signature "''${@}"
		}

		# Git status.
		function gs() {
			git status "''${@}"
		}

		# Git stash.
		function gst() {
			git stash "''${@}"
		}

		# Git diff.
		function gd() {
			git diff "''${@}"
		}

		# Git diff added.
		function gda() {
			git diff --cached "''${@}"
		}

		# Git commit.
		function gc() {
			git commit -m "''${@}"
		}

		# Git clone (lazy!).
		function gcl() {
			git clone --filter tree:0 "''${@}"
		}

		# Git signed commit.
		function gcs() {
			git commit -S -m "''${@}"
		}

		# Git checkout.
		function gch() {
			git checkout "''${@}"
		}

		# Git checkout branch.
		# Usage: gchb <BRANCH>
		function gchb() {
			git checkout -b "''${@}"
		}

		# Git branch.
		function gb() {
			git branch --all "''${@}"
		}

		# Git branch delete.
		# Usage: gbd <BRANCH>
		function gbd() {
			git branch -D "''${@}"
		}

		# Git branch delete all except current.
		function gbda() {
			git branch | grep -v ^* | xargs git branch -D
		}

		# Git fetch all.
		function gf() {
			git fetch --all -v -p
		}

		# Git tag.
		function gt() {
			git tag "''${@}"
		}

		# Git ignore files.
		function gi() {
			git ls-files -ci --exclude-standard -z | xargs -0 git rm --cached
		}

		# Git patch create.
		# Usage: gpc <FILE>
		function gpc() {
			git diff --cached --binary > "''${@}"
		}

		# Git patch (apply).
		# Usage: gp <FILE>
		function gp() {
			git apply "''${@}"
		}

		# Run git garbage collection.
		function ggc() {
			git gc --aggressive --no-cruft --prune=now
		}

		# Preview diff while adding. Adds current dir by default.
		# Usage: ga [FILES]
		function ga() {
			local target=''${@}

			if [[ "''${target}" = "" ]]; then
				target="."
			fi

			git diff ''${target}
			git add ''${target}
		}

		# Rebase by X commits or from root. When COUNT is 0 - rebase from root. Default is 2.
		# Usage: gr [COMMIT COUNT]
		function gr() {
			local base="''${1}"

			# Rebase last 2 commits by default.
			if [[ "''${base}" = "" ]]; then
				base="2"
			fi

			# If 0, rebase from root. else from specified base.
			if [[ "''${base}" = "0" ]]; then
				git rebase -i --root
			else
				git rebase -i HEAD~''${base}
			fi
		}

		# Specify git user as Dmitry Voronin with provided email.
		# Usage: gu [EMAIL]
		function gu() {
			local name="Dmitry Voronin"
			local email="''${1}"

			if [[ "''${name}" = "" || "''${email}" = "" ]]; then
				echo "usage: gu [EMAIL]"
				return 2
			fi

			git config user.name "''${name}"
			git config user.email "''${email}"
		}

		# Get my git repo.
		# Usage: gg <REPO>
		function gg() {
			local repo="''${1}"

			if [[ "''${repo}" = "" ]]; then
				help gg
				return 2
			fi

			git clone ssh://git@git.voronind.com:22144/voronind/"''${repo}"
		}

		# See diff for a specific commit. Last commit by default.
		# Usage: gdc [COMMITHASH]
		function gdc() {
			local hash="''${1}"
			[[ "''${hash}" = "" ]] && hash="HEAD"
			git diff "''${hash}^!"
		}

		# Get version number based on commit count.
		function gv() {
			git rev-list HEAD --count
		}

		# Open the remote web url in default browser.
		# Usage: gw [REMOTE]
		function gw() {
			local remote="''${1}"
			[[ "''${remote}" = "" ]] && remote="$(git remote | head -n1)"

			local url="$(git remote get-url ''${remote})"
			open "''${url}"
		}

		# Sign the old commits. 0 to resign from root.
		# Usage: git_sign [COMMIT_COUNT]
		function git_sign() {
			local base="''${1}"

			# Resign last commit by default.
			if [[ "''${base}" = "" ]]; then
				base="1"
			fi

			# If 0, rebase from root. else from specified base.
			if [[ "''${base}" = "0" ]]; then
				git rebase --exec 'git commit --amend --no-edit -n -S' -i --root
			else
				git rebase --exec 'git commit --amend --no-edit -n -S' -i HEAD~''${base}
			fi
		}

		# Show current branch.
		function _git_current_branch() {
			git branch --show-current 2> /dev/null
		}

		# Show origin's url.
		function _git_origin_url() {
			git remote get-url origin
		}

		# Get this dotfiles url.
		function _git_dotfiles_url() {
			echo 'https://git.voronind.com/voronind/linux.git'
		}

		# Check if current git repo is this dotfiles.
		function _git_is_dotfiles() {
			# [[ "$(_git_origin_url)" = "$(_git_dotfiles_url)" ]]
			local dir="''${PWD}"

			while [[ "''${dir}" != "" ]]; do
				if [[ -d "''${dir}/.git" ]]; then
					if [[ "''${dir}" = "''${HOME}" ]] || [[ "''${dir}" = "$(realpath ''${HOME})" ]]; then
						return 0
					else
						return 1
					fi
				fi

				dir="''${dir%/*}"
			done
		}

		# Autocomplete.
		_completion_loader git &> /dev/null
		__git_complete gps  _git_push     &> /dev/null
		__git_complete gpsf _git_push     &> /dev/null
		__git_complete gpl  _git_pull     &> /dev/null
		__git_complete gl   _git_log      &> /dev/null
		__git_complete gs   _git_status   &> /dev/null
		__git_complete gst  _git_stash    &> /dev/null
		__git_complete gd   _git_diff     &> /dev/null
		__git_complete gdc  _git_diff     &> /dev/null
		__git_complete gc   _git_commit   &> /dev/null
		__git_complete gch  _git_checkout &> /dev/null
		__git_complete gchb _git_checkout &> /dev/null
		__git_complete gb   _git_branch   &> /dev/null
		__git_complete gbd  _git_branch   &> /dev/null
		__git_complete gf   _git_fetch    &> /dev/null
		__git_complete gt   _git_tag      &> /dev/null
		__git_complete gp   _git_apply    &> /dev/null
		__git_complete ga   _git_add      &> /dev/null
		__git_complete gw   _git_pull     &> /dev/null

		# Autocomplete with my git emails.
		function _gu() {
			_autocomplete_first hi@voronind.com dd.voronin@fsight.ru
		}

		complete -F _gu gu
	'';
}
