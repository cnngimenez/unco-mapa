import {Map} from '../js/unco-mapa.js'

assign_events = () ->
    btn = document.querySelector '.btn-highlight'
    btn.addEventListener 'click', () ->
        sel = document.querySelector 'select.classroom'
        name = sel.value
        cr_map.highlight name

export fill_select = () ->
    lst_ids = cr_map.get_classrooms()
    lst_ids.sort (first, second) ->
         second.name < first.name 
    select = document.querySelector 'select.classroom'
    lst_ids.forEach (idobj) =>
        op = "<option value=\"" + idobj.id + "\">"
        op = op + idobj.name + "</option>"
        select.innerHTML = select.innerHTML.concat op

load_complete = () ->
    fill_select()
    svg = document.querySelector 'svg'
    width = svg.getAttribute 'width'
    height = svg.getAttribute 'height'
    svg.setAttribute 'width', width/2
    svg.setAttribute 'height', height/2
        
console.log 'loading map...'
export cr_map = new Map document.querySelector('.map'), load_complete
assign_events()
