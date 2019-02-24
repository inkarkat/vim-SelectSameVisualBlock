" Test selecting next block wrapping around.

edit input.txt
execute "11normal! 39|\<C-v>4l2j"

call vimtest#StartTap()
call vimtap#Plan(2)
execute "normal 3]\<C-v>y"
call IsSelection(10, 11, 5, 3, 'wrapped around block match')

call vimtest#Quit()
