var PivotalTrackerGraphic = function(projectID, pivotalTrackerURL) {
  this.pivotalTrackerURL = pivotalTrackerURL;
  this.getPivotalTrackerData = function() {
    jQuery.ajax({type: 'GET',
            url: this.pivotalTrackerURL,
            timeout: 5000,
            success: this.showPivotalTrackerGraphic,
            error: function(xhrObj, textStatus, exception) { alert('Pivotal Tracker Graphic Error! '
                                                                    + textStatus + ' ' + exception); }
            // 'success' and 'error' functions will be passed 3 args
           });
    return(false);
  };
  this.showPivotalTrackerGraphic = function(jsonData, requestStatus, xhrObject) {
    var valid = true;
    var err_msg = '';
    if (jsonData.tracker_id == null) {
        valid = false;
        err_msg = '<p class="bg-danger">Tracker does not exist</p>';
    } else if (jsonData.done == -1) {
        valid = false;
        err_msg = '<p class="bg-danger">Invalid tracker project</p>';
    } else if (jsonData.done == 0 && jsonData.new == 0 && jsonData.old == 0 && jsonData.older == 0) {
        valid = false;
        err_msg = '<p class="bg-danger">No open stories</p>';
    }

    if (!valid) {
        jQuery('#'+projectID+'-pivotal-tracker').html(err_msg);
        return(false);
    }

    // Set a callback to run when the Google Visualization API is loaded.
    google.charts.setOnLoadCallback(drawPivotalTrackerGraphic);
    
    // Callback that creates and populates a data table,
    // instantiates the pie chart, passes in the data and
    // draws it.
    function drawPivotalTrackerGraphic() {
        // Create the data table.
        var pivotalTrackerData = google.visualization.arrayToDataTable([
            ['Project', 'Completed', 'Started', 'Unstarted', 'Unscheduled', { role: 'annotation' } ],
            ['', jsonData.done, jsonData.new, jsonData.old, jsonData.older, ''],
          ]);
        
        // Set chart options
        var pivotalTrackerOptions = {
            width: 150,
            height: 20,
            legend: { position: 'none'},
            bar: { groupWidth: '100%' },
            isStacked: 'percent',
            colors: ['green', 'yellow', 'red', 'gray'],
            hAxis: {textPosition: 'none'},
            vAxis: {textPosition: 'none'},
            chartArea: {'left': 0, 'top': 0, 'width': '100%', 'height': '100%'},
            tooltip: {
                ignoreBounds: true,
                isHtml: true,
                textStyle: {fontSize: 12}
            }
          };
        
        // Instantiate and draw our chart, passing in some options.
        var pivotalTrackerGraphic = new google.visualization.BarChart(document.getElementById(projectID+'-pivotal-tracker'));
        console.log(pivotalTrackerData);
        pivotalTrackerGraphic.draw(pivotalTrackerData, pivotalTrackerOptions);
    }
    return(false);  // prevent default link action
  };
};