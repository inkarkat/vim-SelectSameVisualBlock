call vimtest#AddDependency('vim-ingo-library')

runtime plugin/SelectSameVisualBlock.vim

function! IsSelection( startLnum, startCol, width, height, description ) abort
    call vimtap#Is(getpos("'<")[1:2], [a:startLnum, a:startCol], a:description . ' start')
    call vimtap#Is(getpos("'>")[1:2], [a:startLnum + a:height - 1, a:startCol + a:width - 1], a:description . ' end')
endfunction

set nowrap
