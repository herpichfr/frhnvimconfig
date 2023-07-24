#!/usr/bin/node
///
/// A simple node.js script for displaying average CPU temp on tmux segment
/// @date January 2016
///
var sp = require('child_process');
var colors = require('tmux-colors');

// this script assumes you already have installed and configures lm-sensors
var sensors = sp.spawnSync("/usr/bin/sensors", ["--no-adapter", "coretemp-isa-0000"]);
var output = sensors.stdout.toString();
output = output.replace(/^.*coretemp-isa-0000.*$/mg, "");
output = output.replace(/^\s+|\s+$/g, '');
var lines = output.split("\n");
var avg = 0.0;
var core_count = 0.0;
var max_temp = 0.0;

// get raw temps and average them
lines.forEach(function(line){
    var temp = line.substring(line.indexOf('+')+1, line.indexOf('°C'));
    var temp = parseFloat(temp);
    avg += temp;
    core_count++;
    if (temp > max_temp) max_temp = temp;
});
avg /= core_count;

// change those to adjust your tmps
var max = 100;
var min = 30;

// min max normalise temperature
var norm = ((avg - min) / (max - min))*100;

// use the average temp / or use the max_temp
var temp = avg;

// find RGB value
var r = parseInt((255 * norm) / 100);
var g = parseInt((255 * (100 - norm)) / 100);
var b = parseInt(0);

// 8ths (no empty box)
var bars = ['\u2581','\u2582','\u2583','\u2584',
            '\u2585','\u2586','\u2587','\u2588'];

// re-scale the norm value to eights
var eight = (((temp - min) * (8 - 1)) / (max - min)) + 1;
var index = parseInt(eight);

// rgb hex'ed
var rgb = rgbToHex(r, g, b); 

console.log(colors('#[fg='+rgb+',bold]'+bars[index]+'°C'));

function componentToHex(c){
    var hex = c.toString(16);
    return hex.length == 1 ? "0" + hex : hex;
}

function rgbToHex(r, g, b) {
    return "#" + componentToHex(r) + componentToHex(g) + componentToHex(b);
}
