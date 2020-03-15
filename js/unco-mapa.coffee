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

    # @param canvas {object} The HTML SVG object.
    constructor: (@maindiv) ->
        this.load_map()

    # Load the map from the SVG URL.
    load_map: () ->
        fetch(MAP_URL).then (result) =>
            result.text().then (text) =>
                console.log 'text: '
                console.log text
                @maindiv.innerHTML = text

    # Highlight the classroom name
    #
    # @param classroom {string} The classroom ID.
    highlight: (classroom) ->
        # draw = @svg.querySelectorAll ("#classroom")
