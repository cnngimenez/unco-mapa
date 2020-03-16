# unco-mapa.coffee --
# Copyright (C) 2020 Christian Gimenez

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.

# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


# The classrooms map.
class Map

    # @param maindiv {object} The HTML SVG object.
    constructor: (@maindiv, load_callback=null) ->
        this.load_map @maindiv, load_callback

    # Load the map from the SVG URL.
    load_map: (maindiv, load_callback=null) ->
        fetch(this.map_url()).then (result) =>
            result.text().then (text) =>
                maindiv.innerHTML = text
                load_callback() if load_callback?

    reset_all: () ->
        if @current_animation?
            try
                @current_animation.cancel()
            catch 
        lst = @maindiv.querySelectorAll 'rect'
        lst.forEach (elt) ->
            if elt.style.fill is "red"
                elt.style.fill = elt.previous_fill
        lst = @maindiv.querySelectorAll 'path'
        lst.forEach (elt) ->
            if elt.style.fill is "red"
                elt.style.fill = elt.previous_fill


    # Highlight the classroom name
    #
    # @param classroom {string} The classroom ID.
    highlight: (classroom) ->
        draw = @maindiv.querySelector "#" + classroom
        if draw.style.fill is 'red'
            return
        this.reset_all()

        lst_rect = Array.from draw.querySelectorAll 'rect'
        lst_rect = lst_rect.concat Array.from draw.querySelectorAll 'path'
        lst_rect.forEach (rect) ->
            rect.previous_fill = rect.style.fill
            rect.style.fill = 'red'
 
        draw.previous_fill = draw.style.fill
        draw.style.fill = 'red'

        @current_animation = draw.animate [
            {opacity: 0}
            {opacity: 1}
            ],
            duration: 500
            iterations: Infinity

        
    # Return all classrooms id and names.
    # 
    # @return {array} An array of objects.
    get_classrooms: () ->
        lst = Array.from @maindiv.querySelectorAll 'rect'
        lst = lst.concat Array.from @maindiv.querySelectorAll 'path'
        lst.map (elt) ->
            id: elt.getAttribute 'id'
            name: elt.getAttribute 'inkscape:label'


# The Overview Map
export class Overview extends Map
    map_url: () ->
        '../imgs/overview.svg'

    get_buildings: () ->
        lst = Array.from @maindiv.querySelectorAll 'g'
        lst = lst.filter (elt) ->
            elt.getAttribute('inkscape:label') != null
        lst.map (elt) ->
            id: elt.getAttribute 'id'
            name: elt.getAttribute 'inkscape:label'

# Buildings
export class Buildings extends Map

    map_url: () ->
        '../imgs/buildings.svg'
    
    constructor: (maindiv, load_callback=null) ->
        alldiv = document.createElement 'div'
        super alldiv, () =>
            alldiv.style.display = 'none'
            load_callback()

        @alldiv = alldiv
        @maindiv = maindiv

        @alldiv.setAttribute 'class', 'all-buildings'
        @alldiv.style.display = 'none'
        @maindiv.appendChild alldiv
      
        @graphdiv = document.createElementNS 'http://www.w3.org/2000/svg', 'svg'
        @graphdiv.setAttribute 'class', 'building'
        @graphdiv.setAttribute 'width', '500'
        @graphdiv.setAttribute 'height', '500'
        @graphdiv.setAttribute 'viewBox', '0 0 100 100'
        @graphdiv.setAttribute 'xmlns:svg', 'http://www.w3.org/2000/svg'
        @graphdiv.setAttribute 'xmlns', 'http://www.w3.org/2000/svg'
        @maindiv.appendChild @graphdiv


    # Hide all buildings
    reset_all: () ->
        @graphdiv.innerHTML = ''
        
    show_building: (name) ->
        this.reset_all()
        orig_building = @alldiv.querySelector '#' + name
        
        building = orig_building.cloneNode true
        @graphdiv.appendChild building.cloneNode true
        building = @graphdiv.querySelector 'g'

        # center building

        bbox = building.getBBox()
        @graphdiv.viewBox.baseVal.x = bbox.x 
        @graphdiv.viewBox.baseVal.y = bbox.y
        @graphdiv.viewBox.baseVal.width = bbox.width 
        @graphdiv.viewBox.baseVal.height = bbox.height


