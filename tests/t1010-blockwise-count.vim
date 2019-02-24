" Test selecting count'th next block.

call vimtest#SkipAndQuitIf(! vimtest#features#SupportsNormalWithCount(), 'Need support for :normal with count')

edit input.txt
execute "10normal! 11|\<C-v>4l2j"

call vimtest#StartTap()
call vimtap#Plan(2)
execute "normal 3]\<C-v>\<Esc>"
call IsSelection(17, 8, 5, 3, '3rd next block match')

call vimtest#Quit()
