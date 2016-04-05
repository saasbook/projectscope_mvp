// Set a callback to run when the Google Visualization API is loaded.
google.charts.setOnLoadCallback(drawHeatMap);

// Callback that creates and populates a data table,
// instantiates the pie chart, passes in the data and
// draws it.
function drawHeatMap() {

  // Create the data table.
  var slack_data = new google.visualization.DataTable();
  slack_data.addColumn('number', '');
  slack_data.addColumn('number', '');
  slack_data.addColumn('number', '');
  slack_data.addRows([
    [11, 6, 15],
    [0, 11, 12]
  ]);

  // Set chart options
  var slack_options = {'useRowLabels':false,
                 'startColor':{r:255, g:0, b:0, a:1},
                 'endColor':{r:0, g:255, b:0, a:1}};

  // Instantiate and draw our chart, passing in some options.
  var chart = new org.systemsbiology.visualization.BioHeatMap(document.getElementById('heatmapContainer'));
  // new google.visualization.PieChart(document.getElementById('heatmapContainer'));
  chart.draw(slack_data, slack_options);
}
