" Test selecting next line.

edit input.txt
1normal! V

call vimtest#StartTap()
call vimtap#Plan(7)

execute "normal ]\<C-v>y"
call IsSelection(6, 7, 29, 1, 'next line match')
call vimtap#Is(@@, "pharetra lore baz  vel ante.", "selected text")
call vimtap#Is(visualmode(), "\<C-v>", "switched to blockwise selection")

1normal! V
execute "normal 3]\<C-v>y"
call IsSelection(24, 1, 42, 1, 'third line match')
call vimtap#Is(@@, "pharetra lore baz  vel ante. NULLOS DIOS.", "selected text with additional suffix")

call vimtest#Quit()
