SELECT SAME VISUAL BLOCK
===============================================================================
_by Ingo Karkat_

DESCRIPTION
------------------------------------------------------------------------------

Searching for an exact text block can be handy, but Vim's regular expressions
don't allow to do that (for arbitrary, aligned columns), and search
highlighting would either match only the first line segment, each line
individually, or the surrounding inner text as well, making it difficult to
operate on.

This plugin locates the next match of the selected text, and re-creates the
selection there. It is most useful for blockwise-visual selections; for a
characterwise selection, a simpler mapping would do (and several plugins (see
below) already provide this). For linewise-visual selections, it doesn't
just search for the exact same line(s) (which also can be done easily via
regular expression search), but allows additional (same-width) prefix text or
(arbitrary) suffix text, sort of turning the linewise selection into a
blockwise one (without insisting on equal line width, though).

### SOURCE

Idea from https://vi.stackexchange.com/a/10278/970

### SEE ALSO

- SearchHighlighting.vim ([vimscript #4320](http://www.vim.org/scripts/script.php?script_id=4320)) has a {Visual}\* mapping that
  matches the (blockwise) selection, but loses the assertion on vertical
  alignment due to the use of regular expressions.

USAGE
------------------------------------------------------------------------------

    {Visual}[<C-v>          Search for the [count]'th occurrence of the currently
    {Visual}]<C-v>          selected text in the same form.
                            For linewise selections, that means lines starting or
                            ending with the same text, possibly with additional
                            suffix / (same-width) prefix text. Note that suffix
                            text will be included in the selection, as there's no
                            irregular selection within a line, and repeats of the
                            same search therefore won't work.
                            For blockwise selections, that means each line starts
                            at the same screen column (i.e. the left border of the
                            selection stays aligned). For a jagged-edge selection
                            (v_$), only text at the end of lines will match.

INSTALLATION
------------------------------------------------------------------------------

The code is hosted in a Git repo at
    https://github.com/inkarkat/vim-SelectSameVisualBlock
You can use your favorite plugin manager, or "git clone" into a directory used
for Vim packages. Releases are on the "stable" branch, the latest unstable
development snapshot on "master".

This script is also packaged as a vimball. If you have the "gunzip"
decompressor in your PATH, simply edit the \*.vmb.gz package in Vim; otherwise,
decompress the archive first, e.g. using WinZip. Inside Vim, install by
sourcing the vimball or via the :UseVimball command.

    vim SelectSameVisualBlock*.vmb.gz
    :so %

To uninstall, use the :RmVimball command.

### DEPENDENCIES

- Requires Vim 7.0 or higher.
- Requires the ingo-library.vim plugin ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)), version 1.036 or
  higher.

CONFIGURATION
------------------------------------------------------------------------------

If you want to use different mappings, map your keys to the
<Plug>(SelectSameVisualBlock...) mapping targets _before_ sourcing the script
(e.g. in your vimrc):

    xmap ]<C-v> <Plug>(SelectSameVisualBlockNext)
    xmap [<C-v> <Plug>(SelectSameVisualBlockPrev)

CONTRIBUTING
------------------------------------------------------------------------------

Report any bugs, send patches, or suggest features via the issue tracker at
https://github.com/inkarkat/vim-SelectSameVisualBlock/issues or email (address
below).

HISTORY
------------------------------------------------------------------------------

##### GOAL
First published version.

##### 0.01    21-Feb-2019
- Started development.

------------------------------------------------------------------------------
Copyright: (C) 2019 Ingo Karkat -
The [VIM LICENSE](http://vimdoc.sourceforge.net/htmldoc/uganda.html#license) applies to this plugin.

Maintainer:     Ingo Karkat <ingo@karkat.de>
