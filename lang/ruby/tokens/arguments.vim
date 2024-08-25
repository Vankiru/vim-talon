let s:tokens = g:Ruby.tokens

"
" ",\s*\n\="
function! s:tokens.RegisterComma()
    call g:Ruby.Register("comma", #{token: ',\s*\n\='}, #{token: "vwh"})
endfunction

" type = "\%(*\|**\|&\)\="
" name = "\<{base_name}\>"
" default = "\s*=\s*{value}"
" keyward = ":\s*{value}\=" 
" suffix = "\%(,\s*\|\%()\||\)\@=\)"
" "{type}{name}\%({default}\|{keyward}\)\={suffix}"
" "\%(*\|**\|&\|\.\.\.\)"
function! s:tokens.RegisterArt()
    let regex = #{
        \name: id.snake_name,
        \body: ".",
        \token: s:BuildArtRegex()
    \}

    let select = #{
        \name: "snake_name",
        \body: "expression",
        \token: "argument"
        " \body: "via",
        " \token: "vaa"
    \}

    call g:Ruby.Register("art", regex, select)
endfunction

function! s:BuildArtRegex()
    let l:type = "\%(\*\|\*\*\|&\)\="
    let default = "%(\s*=\s*".body
    let keyward = "\|:\s*".body."\=\)\="
    let suffix = "\%(,\s*\|\%()\||\)\@=\)"

    return g:BuildRegex(
        \l:type.".name.".default.keyward.suffix,
        \'\%(\*\|\*\*\|&\|\.\.\.\)'
    )
endfunction

"
" "\%({method_name}\|->\s*\)({id}"
function! s:tokens.RegisterArts()
    let regex = #{
        \body: id.snake_text,
        \token: "\%(".base.method_name."\|->\s*\)\@<=(".body
    }

    let select = #{body: "vi(", token: "va("}

    call g:Ruby.Register("arts", regex, select)
endfunction

"
" "{\s*{barbs}"
function! s:tokens.RegisterArts()
    let regex = #{
        \body: id.snake_text,
        \token: "\%({\s*\)\@<=|".body."|"
    }

    let select = #{body: "lvf|h", token: "vf|"}

    call g:Ruby.Register("arts", regex, select)
endfunction
