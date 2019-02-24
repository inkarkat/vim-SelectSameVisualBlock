" SelectSameVisualBlock.vim: Search for the (especially blockwise) selected text.
"
" DEPENDENCIES:
"
" Copyright: (C) 2019 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	001	21-Feb-2019	file creation

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_SelectSameVisualBlock') || (v:version < 700)
    finish
endif
let g:loaded_SelectSameVisualBlock = 1

vnoremap <silent> <Plug>(SelectSameVisualBlockNext) :<C-u>call SelectSameVisualBlock#SelectSameVisualBlock(0, v:count1)<CR>
if ! hasmapto('<Plug>(SelectSameVisualBlockNext)', 'v')
    xmap ]<C-v> <Plug>(SelectSameVisualBlockNext)
endif
vnoremap <silent> <Plug>(SelectSameVisualBlockPrev) :<C-u>call SelectSameVisualBlock#SelectSameVisualBlock(1, v:count1)<CR>
if ! hasmapto('<Plug>(SelectSameVisualBlockPrev)', 'v')
    xmap [<C-v> <Plug>(SelectSameVisualBlockPrev)
endif

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
