" Test selecting next word.

edit input.txt
execute "3normal! )ve"

call vimtest#StartTap()
call vimtap#Plan(3)
execute "normal ]\<C-v>y"
call IsSelection(9, 75, 5, 1, 'next word match')
call vimtap#Is(@@, "Nulla", "selected text")

call vimtest#Quit()
