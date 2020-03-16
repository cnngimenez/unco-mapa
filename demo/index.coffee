import {Overview} from '../js/unco-mapa.js'

assign_events = () ->
    btn = document.querySelector '.btn-building'
    btn.addEventListener 'click', () ->
        sel = document.querySelector 'select.building'
        name = sel.value
        overview_map.highlight name

fill_overview_select = () ->
    lst_ids = overview_map.get_buildings()
    lst_ids.sort (first, second) ->
         second.name < first.name 
    select = document.querySelector 'select.building'
    lst_ids.forEach (idobj) =>
        op = "<option value=\"" + idobj.id + "\">"
        op = op + idobj.name + "</option>"
        select.innerHTML = select.innerHTML.concat op

load_overview_complete = () ->
    fill_overview_select()
    svg = document.querySelector '.overview-map svg'
    width = svg.getAttribute 'width'
    height = svg.getAttribute 'height'
    svg.setAttribute 'width', width/4
    svg.setAttribute 'height', height/4
        
console.log 'loading map...'
export overview_map = new Overview document.querySelector('.overview-map'),
    load_overview_complete
# export building_map = new Buildings document.querySelector('.building-map'),
#     load_buildings_complete

assign_events()
