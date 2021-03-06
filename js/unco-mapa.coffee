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
export class Map

    MAP_URL = '../imgs/aulario.svg'

    # @param maindiv {object} The HTML SVG object.
    constructor: (@maindiv, load_callback=null) ->
        this.load_map load_callback

    # Load the map from the SVG URL.
    load_map: (load_callback=null) ->
        fetch(MAP_URL).then (result) =>
            result.text().then (text) =>
                @maindiv.innerHTML = text
                load_callback() if load_callback?

    reset_all: () ->
        lst = @maindiv.querySelectorAll 'rect'
        lst.forEach (elt) ->
            elt.style.fill = 'none'
        lst = @maindiv.querySelectorAll 'path'
        lst.forEach (elt) ->
            elt.style.fill = 'none'

    # Highlight the classroom name
    #
    # @param classroom {string} The classroom ID.
    highlight: (classroom) ->
        this.reset_all()
        draw = @maindiv.querySelector "#" + classroom
        draw.style.fill = 'red'

    # Return all classrooms id and names.
    # 
    # @return {array} An array of objects.
    get_classrooms: () ->
        lst = Array.from @maindiv.querySelectorAll 'rect'
        lst = lst.concat Array.from @maindiv.querySelectorAll 'path'
        lst.map (elt) ->
            id: elt.getAttribute 'id'
            name: elt.getAttribute 'inkscape:label'
