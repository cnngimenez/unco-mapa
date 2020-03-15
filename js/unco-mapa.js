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
    // @param maindiv {object} The HTML SVG object.
    constructor(maindiv, load_callback = null) {
      this.maindiv = maindiv;
      this.load_map(load_callback);
    }

    // Load the map from the SVG URL.
    load_map(load_callback = null) {
      return fetch(MAP_URL).then((result) => {
        return result.text().then((text) => {
          this.maindiv.innerHTML = text;
          if (load_callback != null) {
            return load_callback();
          }
        });
      });
    }

    reset_all() {
      var lst;
      lst = this.maindiv.querySelectorAll('rect');
      lst.forEach(function(elt) {
        return elt.style.fill = 'none';
      });
      lst = this.maindiv.querySelectorAll('path');
      return lst.forEach(function(elt) {
        return elt.style.fill = 'none';
      });
    }

    // Highlight the classroom name

    // @param classroom {string} The classroom ID.
    highlight(classroom) {
      var draw;
      this.reset_all();
      draw = this.maindiv.querySelector("#" + classroom);
      return draw.style.fill = 'red';
    }

    // Return all classrooms id and names.

    // @return {array} An array of objects.
    get_classrooms() {
      var lst;
      lst = Array.from(this.maindiv.querySelectorAll('rect'));
      lst = lst.concat(Array.from(this.maindiv.querySelectorAll('path')));
      return lst.map(function(elt) {
        return {
          id: elt.getAttribute('id'),
          name: elt.getAttribute('inkscape:label')
        };
      });
    }

  };

  MAP_URL = '../imgs/aulario.svg';

  return Map;

}).call(this);
