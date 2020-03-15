// Generated by CoffeeScript 2.4.1
// unco-mapa.coffee --
// Copyright (C) 2020 Christian Gimenez

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.

// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

// The classrooms map.
export var Map = (function() {
  var MAP_URL;

  class Map {
    // @param canvas {object} The HTML SVG object.
    constructor(svg) {
      this.svg = svg;
      this.load_map();
    }

    load_map() {}

    
    // Highlight the classroom name

    // @param classroom {string} The classroom ID.
    highlight(classroom) {}

  };

  MAP_URL = '../imgs/aulario.svg';

  return Map;

}).call(this);

// draw = @svg.querySelectorAll ("#classroom")
