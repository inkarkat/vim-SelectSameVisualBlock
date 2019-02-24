" Test selecting next jagged block with exclusive selection.

set selection=exclusive
edit input.txt
execute "10normal! $b\<C-v>$2j"

call vimtest#StartTap()
call vimtap#Plan(5)
execute "normal ]\<C-v>y"
call IsSelection(19, 84, 1, 3, 'next jagged block match')
call vimtap#Is(@@, "foo\nbar\n", "selected text")

execute "normal gv]\<C-v>y"
call IsSelection(10, 86, 1, 3, 'wrap around to original jagged block match')

call vimtest#Quit()
