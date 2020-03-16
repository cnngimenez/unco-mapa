import {Overview, Buildings} from '../js/unco-mapa.js'

assign_events = () ->
    btn = document.querySelector '.btn-building'
    btn.addEventListener 'click', () ->
        sel = document.querySelector 'select.building'
        name = sel.value
        console.log name
        overview_map.highlight name
        building_map.show_building name,
            x: 0.5
            y: 0.5

# Create all the option tags with id and names from the
# overview SVG map.
fill_overview_select = () ->
    lst_ids = overview_map.get_buildings()
    lst_ids.sort (first, second) ->
         second.name < first.name 
    select = document.querySelector 'select.building'
    lst_ids.forEach (idobj) =>
        op = "<option value=\"" + idobj.id + "\">"
        op = op + idobj.name + "</option>"
        select.innerHTML = select.innerHTML.concat op

# What to do when the overview map has been loaded?
load_overview_complete = () ->
    fill_overview_select()
    svg = document.querySelector '.overview-map svg'
    width = svg.getAttribute 'width'
    height = svg.getAttribute 'height'
    svg.setAttribute 'width', width/4
    svg.setAttribute 'height', height/4

# What to do when the buildings map has been loaded?
load_buildings_complete = () ->
    # fill_building_select()
    svg = document.querySelector '.building-map svg'
    # width = svg.getAttribute 'width'
    # height = svg.getAttribute 'height'
    # svg.setAttribute 'width', width/2
    # svg.setAttribute 'height', height/2
    
console.log 'loading map...'
export overview_map = new Overview document.querySelector('.overview-map'),
    load_overview_complete
export building_map = new Buildings document.querySelector('.building-map'),
    load_buildings_complete

assign_events()
