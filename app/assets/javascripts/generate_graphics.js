var generateGraphics = function () {
    jQuery("tbody tr").each(function() {
       var projectName = jQuery(this).find("h4").text();
       var pullRequestGraphic = new PullRequestGraphic(projectName, jQuery(this).find("#pull-request-link").text());
       pullRequestGraphic.getPullRequestData();
       var slackGraphic = new SlackGraphic(projectName, jQuery(this).find("#slack-link").text());
       slackGraphic.getSlackData();
    });
};
jQuery(generateGraphics);
