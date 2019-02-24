" Test selecting next block without wrapscan.

set nowrapscan
edit input.txt
execute "11normal! 39|\<C-v>4l2j"

call vimtest#StartTap()
call vimtap#Plan(2)
execute "normal 3]\<C-v>y"
call IsSelection(11, 39, 5, 3, 'original block still selected')

call vimtest#Quit()
