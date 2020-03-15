import {Map} from '../js/unco-mapa.js'

assign_events = () ->
    btn = document.querySelector '.btn-highlight'
    btn.addEventListener 'click', () ->
        sel = document.querySelector 'select.classroom'
        name = sel.value
        cr_map.highlight name

export fill_select = () ->
    lst_ids = cr_map.get_classrooms()
    select = document.querySelector 'select.classroom'
    lst_ids.forEach (idstr) =>
        op = "<option value=\"" + idstr + "\">" + idstr + "</option>"
        select.innerHTML = select.innerHTML.concat op
        
console.log 'loading map...'
export cr_map = new Map document.querySelector('.map'), fill_select
assign_events()
