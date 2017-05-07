" effect-sketches.vim - A tool to make debugging lie easy
" Maintainer:   Guilherme Reis Campos
" Version:      0.1-dev

if exists('g:loaded_effect_sketches')
  finish
endif
let g:loaded_effect_sketches = 1

let g:effectSketch = {'steps': []}
function effectSketch.addStep() dict
	call add(self.steps, expand("<cword>"))
endfunction

" TODO:
" REFACTOR CODE.
function effectSketch.preview() dict
  let gVizDigraph = "digraph effectgraph {\n"
  let previousStep = 0
  let stepsLength = len(self.steps)
  let counter = 0
	while counter < stepsLength
    let step = get(self.steps, counter)
    if counter == 0
      let previousStep = step
    else
      let gVizDigraph = gVizDigraph . "\n \"" . previousStep . "\" -> \"" . step . "\""
      let previousStep = step
    endif
    let counter = counter + 1
  endwhile
  let gVizDigraph = gVizDigraph . "}"
  execute system("echo '" . gVizDigraph . "' | dot -Tsvg -o graph.svg")
  execute system("open graph.svg")
endfunction

function effectSketch.popStep() dict
  if len(self.steps) > 0
    let self.steps = remove(self.steps, 1, -1)
  endif
endfunction

function effectSketch.reset() dict
  let self.steps = []
endfunction

" TODO:
" FIND OUT BETTER KEY STROKES
" Sketch step
nnoremap <F2> :call effectSketch.addStep()<CR> 
" Sketch remove seep
nnoremap <F3> :call effectSketch.popStep()<CR>
" Sketch Preview
nnoremap <F4> :call effectSketch.preview()<CR>
" Sketch Reset
nnoremap <F5> :call effectSketch.reset()<CR>
