"" comfortable-motion.vim
Plug 'yuttie/comfortable-motion.vim'

let g:comfortable_motion_interval = 1000 / 60
let g:comfortable_motion_friction = 1500.0
let g:comfortable_motion_air_drag = 15

let g:comfortable_motion_no_default_key_mappings = 1
nnoremap <silent> ` :call comfortable_motion#flick(winheight(0) * -20)<CR>
nnoremap <silent> * :call comfortable_motion#flick(winheight(0) * 20)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(winheight(0) * -20)<CR>
nnoremap <silent> <C-d> :call comfortable_motion#flick(winheight(0) * 20)<CR>

