" effect-sketches.vim - A tool to make debugging lie easy
" Maintainer:   Guilherme Reis Campos
" Version:      0.1-dev

if exists('g:loaded_effect_sketches')
  finish
endif
let g:loaded_effect_sketches = 1

function NewNode(name, parent)
  let Node = { 'children': [], 'name': a:name, 'parent': a:parent }

  function Node.asDot() dict
    let s:lines = ""
    for child in self.children
      if type(self.parent) == type('') && self.parent == ''
        let s:lines = s:lines . child.asDot() . "\n"
      else
        let s:dotLine = "\"" . self.name . "\" -> \"" . child.name . "\" \n "
        let s:lines = s:lines . s:dotLine . child.asDot()
      endif
    endfor
    return s:lines
  endfunction

  function Node.addChild(node) dict
    call add(self.children, a:node)
  endfunction

  return Node
endfunction


let g:effectSketch = {'steps': [], 'rootNode': NewNode('root', '') }
let g:effectSketch.currentNode = effectSketch.rootNode

function effectSketch.addNode() dict
  let s:newNode = NewNode(expand("<cword>"), self.currentNode)
  call self.currentNode.addChild(s:newNode)
  let g:effectSketch.currentNode = s:newNode
  return s:newNode
endfunction

function effectSketch.asDot() dict
  return "digraph effectgraph {\n". self.rootNode.asDot()."\n}"
endfunction

function effectSketch.preview() dict
  execute system("echo '" . self.asDot() . "' | dot -Tsvg -o graph.svg")
  execute system("open graph.svg")
endfunction

function effectSketch.popStep() dict
  if self.currentNode != self.rootNode
    let parent = self.currentNode.parent
    call remove(parent.children, index(parent.children, 'v:val[name] = "' . self.currentNode.name . '"'), -1)
    let g:effectSketch.currentNode = parent
  endif
endfunction

function effectSketch.reset() dict
  let self.steps = []
endfunction

" TODO:
" FIND OUT BETTER KEY STROKES
" Sketch step
nnoremap <F2> :call effectSketch.addNode()<CR> 
" Sketch remove seep
nnoremap <F3> :call effectSketch.popStep()<CR>
" Sketch Preview
nnoremap <F4> :call effectSketch.preview()<CR>
" Sketch Reset
nnoremap <F5> :call effectSketch.reset()<CR>
