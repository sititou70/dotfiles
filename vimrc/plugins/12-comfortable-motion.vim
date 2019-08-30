"" comfortable-motion.vim
Plug 'yuttie/comfortable-motion.vim'

let g:comfortable_motion_interval = 1000 / 60
let g:comfortable_motion_friction = 500.0
let g:comfortable_motion_air_drag = 5.0

let g:comfortable_motion_no_default_key_mappings = 1
nnoremap <silent> { :call comfortable_motion#flick(winheight(0) * -4)<CR>
nnoremap <silent> } :call comfortable_motion#flick(winheight(0) * 4)<CR>

let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"

