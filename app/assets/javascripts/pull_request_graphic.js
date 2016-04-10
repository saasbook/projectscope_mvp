var PullRequestGraphic = function(projectID, pullRequestURL) {
  this.pullRequestURL = pullRequestURL;
  this.getPullRequestData = function() {
    jQuery.ajax({type: 'GET',
            url: this.pullRequestURL,
            timeout: 5000,
            success: this.showPullRequestGraphic,
            error: function(xhrObj, textStatus, exception) { alert('Pull Request Graphic Error! '
                                                                    + textStatus + ' ' + exception); }
            // 'success' and 'error' functions will be passed 3 args
           });
    return(false);
  };
  this.showPullRequestGraphic = function(jsonData, requestStatus, xhrObject) {
    if (jsonData.green == -1) {
        jQuery('#'+projectID+'-pull-request').html('<p class="bg-danger">Invalid git repo</p>');
        return(false);
    }
    
    if (jsonData.green == 0 && jsonData.yellow == 0 && jsonData.red == 0) {
        jQuery('#'+projectID+'-pull-request').html('<p class="bg-danger">No pull requests</p>');
        return(false);
    }
    // Set a callback to run when the Google Visualization API is loaded.
    google.charts.setOnLoadCallback(drawPullRequestGraphic);
    
    // Callback that creates and populates a data table,
    // instantiates the pie chart, passes in the data and
    // draws it.
    function drawPullRequestGraphic() {
        // Create the data table.
        var pullRequestData = google.visualization.arrayToDataTable([
            ['Project', '2 or more', '1 Review', 'No Reviews', { role: 'annotation' } ],
            ['', jsonData.green, jsonData.yellow, jsonData.red, ''],
          ]);
        
        // Set chart options
        var pullRequestOptions = {
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
        var pullRequestGraphic = new google.visualization.ColumnChart(document.getElementById(projectID+'-pull-request'));
        console.log(pullRequestData);
        pullRequestGraphic.draw(pullRequestData, pullRequestOptions);
    }
    return(false);  // prevent default link action
  };
};
