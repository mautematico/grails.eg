<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.highcharts.com/highcharts.js"></script>
<script src="http://code.highcharts.com/modules/exporting.js"></script>



<div id="container" style="min-width: 310px; height: 400px; max-width: 600px; margin: 0 auto"></div>

<script>
var personas = ${raw(data)};
var edades = personas.reduce(function(res, obj) {
    if (!(obj.edad in res))
        res.__array.push(res[obj.edad] = obj);
    else {
    	if(!res[obj.edad].hits)
    		res[obj.edad].hits=1;
        res[obj.edad].hits++;
    }
    return res;
}, {__array:[]}).__array
                .sort(function(a,b) { return b.hits - a.hits; });


var histograma = [];
/* [
	["40 años", 9],
	["29 años", 7],
	...
	["19 años", 9]
]
*/

for( i = 0; i< edades.length;i++){
	histograma[i]=[];
	histograma[i].push(edades[i].edad + " años");
	if(!!edades[i].hits)
		histograma[i].push(edades[i].hits);
	else
		histograma[i].push(0);
}



$(function () {

    // Radialize the colors
    Highcharts.getOptions().colors = Highcharts.map(Highcharts.getOptions().colors, function (color) {
        return {
            radialGradient: { cx: 0.5, cy: 0.3, r: 0.7 },
            stops: [
                [0, color],
                [1, Highcharts.Color(color).brighten(-0.3).get('rgb')] // darken
            ]
        };
    });

    // Build the chart
    $('#container').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: 'Repeticiones de edades de una muestra de por ahí'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    },
                    connectorColor: 'silver'
                }
            }
        },
        series: [{
            type: 'pie',
            name: 'Porcentaje',
            data: histograma
        }]
    });
});

</script>