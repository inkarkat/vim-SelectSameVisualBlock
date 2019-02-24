" Test selecting next lines.

edit input.txt
1normal! Vj

call vimtest#StartTap()
call vimtap#Plan(7)

execute "normal ]\<C-v>y"
call IsSelection(6, 7, 25, 2, 'next line match')
call vimtap#Is(@@, "pharetra lore baz  vel ante.\npharetra durus vel ante.", "selected text")
call vimtap#Is(visualmode(), "\<C-v>", "switched to blockwise selection")

1normal! Vj
execute "normal 3]\<C-v>y"
call IsSelection(24, 1, 38, 2, 'third line match')
call vimtap#Is(@@, "pharetra lore baz  vel ante. NULLOS DIOS.\npharetra durus vel ante. NULLOS DIOS.", "selected text with additional suffixes")

call vimtest#Quit()
