import {Map} from '../js/unco-mapa.js'

assign_events = () ->
    btn = document.querySelector '.btn-highlight'
    btn.addEventListener 'click', () ->
        txt = document.querySelector '.txt-classroom'
        name = txt.value
        cr_map.highlight name

console.log 'loading map...'
export cr_map = new Map document.querySelector '.map'
assign_events()
