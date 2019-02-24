" SelectSameVisualBlock.vim: Search for the (especially blockwise) selected text.
"
" DEPENDENCIES:
"   - ingo-library.vim plugin
"
" Copyright: (C) 2019 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	001	21-Feb-2019	file creation

function! s:WrapMessage( searchName, isBackward )
    if &shortmess !~# 's'
	call ingo#msg#WarningMsg(a:searchName . ' search ' . (a:isBackward ? 'hit TOP, continuing at BOTTOM' : 'hit BOTTOM, continuing at TOP'))
    endif
endfunction
function! s:LocateBlock( searchName, searches, isBackward, count )
    let l:backwardsFlag = (a:isBackward ? 'b' : '')

    let l:save_view = winsaveview()
    let l:isWrapped = 0
    let [l:prevLine, l:prevCol] = [line("'<"), col("'<")]

    for l:i in range(1, a:count)
	while 1
	    let l:matchPosition = searchpos(a:searches[0], l:backwardsFlag)
	    if l:matchPosition == [0, 0]
		if l:i > 1
		    " (Due to the count,) we've already moved to an intermediate
		    " match. Undo that to behave like the old vi-compatible
		    " motions. (Only the ]s motion has different semantics; it obeys
		    " the 'wrapscan' setting and stays at the last possible match if
		    " the setting is off.)
		    call winrestview(l:save_view)
		endif

		return l:matchPosition
	    elseif l:i == 1 && l:matchPosition == [l:prevLine, l:prevCol]
		" We've wrapped around to the original selection on the initial
		" search for other matches.
		call winrestview(l:save_view)
		return [0, 0]
	    endif

	    if s:IsBlockMatch(l:matchPosition[0], virtcol('.'), a:searches)
		break   " We've found a full block
	    endif
	endwhile

	if ! a:isBackward && ingo#pos#IsOnOrAfter([l:prevLine, l:prevCol], l:matchPosition)
	    let l:isWrapped = 1
	elseif a:isBackward && ingo#pos#IsOnOrBefore([l:prevLine, l:prevCol], l:matchPosition)
	    let l:isWrapped = 1
	endif
	let [l:prevLine, l:prevCol] = l:matchPosition
    endfor

    " Open (potential) fold(s) across the final search result. This makes the
    " search work like the built-in motions.
    execute printf('silent! %d,%dfoldopen!', l:matchPosition[0], l:matchPosition[0] + len(a:searches) - 1)

    if l:isWrapped
	redraw
	call s:WrapMessage(a:searchName, a:isBackward)
    else
	" We need to clear any previous wrap message; it's confusing
	" otherwise. /pattern searches do not have that problem, as they
	" echo the search pattern.
	echo
    endif

    return l:matchPosition
endfunction
function! s:IsBlockMatch( startLnum, virtCol, searches )
    let l:lastLnum = a:startLnum + len(a:searches) - 1
    if l:lastLnum > line('$')
	return 0 | " Not enough lines in buffer.
    endif

    for l:i in range(len(a:searches))   " Verify the first line's match once more here, for consistency.
	if getline(a:startLnum + l:i) !~ '\%' . a:virtCol . 'v' . a:searches[l:i]
	    return 0
	endif
    endfor

    return 1
endfunction

function! SelectSameVisualBlock#SelectSameVisualBlock( isBackward, count )
    let l:isLineWise = (visualmode() ==# 'V')

    let l:blockText = split(ingo#selection#Get(), '\n', 1)
    if l:isLineWise
	call remove(l:blockText, -1)
    endif

    let [l:minWidth, l:maxWidth] = ingo#strdisplaywidth#GetMinMax(l:blockText, virtcol("'<") - 1)
    let l:isJaggedEdge = (l:minWidth != l:maxWidth)

    let l:searchExpr = '"\\V" . escape(v:val, "\\")'
    if l:isLineWise || l:isJaggedEdge
	" Assert match at the end of the line.
	let l:searchExpr .= ' . "\\$"'
    endif
    if l:isLineWise
	" Assert match either at the start or end (already done).
	let l:searchExpr = '"\\%(^\\V" . escape(v:val, "\\") . "\\|" . ' . l:searchExpr . ' . "\\)"'
    endif
    let l:searches = map(l:blockText, l:searchExpr)


    if s:LocateBlock((l:isJaggedEdge ? 'Jagged visual block' : 'Visual block'), l:searches, a:isBackward, a:count) == [0, 0]
	" Ring the bell to indicate that no further match exists.
	execute "normal! \<C-\>\<C-n>\<Esc>"

	" Re-create the original selection at the original position.
	normal! gv
    else
	" Create an identical selection at the found position.
	if l:isLineWise
	    " A linewise selection may also match (jaggedly) at the end of
	    " (longer) lines that have (same-width) prefixes. We just want to
	    " re-select the actual match, not the full line. Therefore, change
	    " the selection into a jagged blockwise one.
	    execute "normal! 1v\<C-v>$"
	else
	    execute 'normal! 1v' . (! l:isJaggedEdge && &selection ==# 'exclusive' ? ' ' : '')
	endif
    endif
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
