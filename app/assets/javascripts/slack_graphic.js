var SlackGraphic = function(projectID, slackURL) {
  this.slackURL = slackURL;
  this.getSlackData = function() {
    jQuery.ajax({type: 'GET',
            url: this.slackURL,
            timeout: 5000,
            success: this.showSlackGraphic,
            error: function(xhrObj, textStatus, exception) { alert('Error!'); }
            // 'success' and 'error' functions will be passed 3 args
           });
    return(false);
  };
  this.showSlackGraphic = function(jsonData, requestStatus, xhrObject) {
    // Set a callback to run when the Google Visualization API is loaded.
    google.charts.setOnLoadCallback(drawSlackGraphic);
    
    // Callback that creates and populates a data table,
    // instantiates the pie chart, passes in the data and
    // draws it.
    function drawSlackGraphic() {
        var slackData = new google.visualization.DataTable();
        var numUsers = jsonData.length;
        var numColumns = 3;
        var numRows = Math.ceil(numUsers / numColumns);
        for (var i = 0; i < numColumns; i++) {
          slackData.addColumn('number', '');
        }
        slackData.addRows(numRows);
        for (var i = 0; i < numRows; i++) {
          for (var j = 0; j < numColumns; j++) {
            var user = i*numColumns + j;
            var numMessages = null;
            if (user < numUsers) {
              numMessages = jsonData[user].messages;
            }
            slackData.setCell(i, j, numMessages);
          }
        }
        
        // Set chart options
        var slackOptions = {'useRowLabels':false,
                       'startColor':{r:255, g:0, b:0, a:1},
                       'endColor':{r:0, g:255, b:0, a:1},
                       'emptyDataColor':{r:255, g:255, b:255, a:1},
                       'mapWidth':200,
                       'mapHeight':200,
                       'drawBorder': false
        };
        
        // Instantiate and draw our chart, passing in some options.
        var slackGraphic = new org.systemsbiology.visualization.BioHeatMap(document.getElementById(projectID+'-slack'));
        slackGraphic.draw(slackData, slackOptions);
    }
    return(false);  // prevent default link action
  };
};
