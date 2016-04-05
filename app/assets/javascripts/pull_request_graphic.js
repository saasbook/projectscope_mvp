var PullRequestGraphic = function(project_name, pr_url) {
  this.pr_url = pr_url;
  this.getPullRequestInfo = function() {
    console.log("getting pull request info");
    jQuery.ajax({type: 'GET',
            url: this.pr_url,
            timeout: 5000,
            success: this.showPullRequestInfo,
            error: function(xhrObj, textStatus, exception) { alert('Error!'); }
            // 'success' and 'error' functions will be passed 3 args
           });
    return(false);
  };
  this.showPullRequestInfo = function(jsonData, requestStatus, xhrObject) {
    console.log("showing pull request info");
    
    // Load the Visualization API and the corechart package.
    // google.charts.load('current', {'packages':['corechart']});
    
    // Set a callback to run when the Google Visualization API is loaded.
    google.charts.setOnLoadCallback(drawChart);
    
    // Callback that creates and populates a data table,
    // instantiates the pie chart, passes in the data and
    // draws it.
    function drawChart() {
        console.log("drawing chart");
        console.log(jsonData);
        var p_name = project_name.replace(/ /g, "-");
        
        // Create the data table.
        var pr_data = google.visualization.arrayToDataTable([
            ['Project', '2 or more', '1 Review', 'No Reviews', { role: 'annotation' } ],
            [p_name, jsonData.green, jsonData.yellow, jsonData.red, ''],
          ]);
        
        // Set chart options
        var pr_options = {
            width: 200,
            height: 200,
            legend: { position: 'none'},
            bar: { groupWidth: '100%' },
            isStacked: true,
            colors: ['green', 'yellow', 'red'],
            hAxis: {textPosition: 'none'},
            vAxis: {textPosition: 'none'}
          };
        
        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.ColumnChart(document.getElementById(p_name));
        console.log(pr_data);
        chart.draw(pr_data, pr_options);
    }
    return(false);  // prevent default link action
  };
};
