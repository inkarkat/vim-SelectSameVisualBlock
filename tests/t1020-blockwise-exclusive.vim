" Test selecting next block with exclusive selection.

set selection=exclusive
edit input.txt
execute "10normal! 11|\<C-v>5l2j"

call vimtest#StartTap()
call vimtap#Plan(3)
execute "normal ]\<C-v>y"
call IsSelection(11, 39, 6, 3, 'next block match')
call vimtap#Is(@@, " foo \n bar \n baz ", "selected text")

call vimtest#Quit()
