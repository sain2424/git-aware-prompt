source "${GITAWAREPROMPT}/colors.sh"
source "${GITAWAREPROMPT}/prompt.sh"
export PS1='\h:\W \u\[$txtcyn\]'$git_branch'\[$txtred\]\[$txtrst\]\$ '
