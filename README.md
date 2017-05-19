# vim-effect-sketches

[Effect sketches](https://www.amazon.com/Working-Effectively-Legacy-Michael-Feathers/dp/0131177052/ref=sr_1_1?ie=UTF8&qid=1495199951&sr=8-1&keywords=working+effectively) in vim at the speed of the light  :)


# Why ?

Sometimes code can be really messy and you need a way to track where the calls are made. You could use a pen and paper, a more [sofiscated approach](https://github.com/tmm1/perftools.rb) or you could use your text editor to mark the callgraph as you go through the code. That's where vim-effect-sketches can help you.


# Installing

First of all, you need to have [Graphviz](http://www.graphviz.org/) installed on your machine.
```
brew install graphviz
```

## Using Vundle
Add to you ```.vimrc```:
```
Plugin 'guilherme/vim-effect-sketches'
```

# Shortcuts
```
F2 - Mark word under cursor as node in the effect sketch.
F3 - Remove previous node from the effect sketch
F4 - Generate and try to open (works on OSX)
F5 - Remove all nodes.
```

Yeah F* feels like 90s. That's ok. This is only the beginning of this plugin.

# TODO
- Think of 21st century shortcuts.
- Add support for multiple branches from a single node.
- Support multiple platforms.
