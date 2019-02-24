" Test selecting previous block.

edit input.txt
execute "11normal! 39|\<C-v>4l2j"

call vimtest#StartTap()
call vimtap#Plan(3)
execute "normal [\<C-v>y"
call IsSelection(10, 11, 5, 3, 'previous block match')
call vimtap#Is(@@, " foo \n bar \n baz ", "selected text")

call vimtest#Quit()
