console.log("generating graphics");
var pullRequestGraphics = function () {
    console.log("iterating through projects...");
    jQuery("tbody tr").each(function() {
       var pr_graphic = new PullRequestGraphic(jQuery(this).find("h4").text(), jQuery(this).find("div.pull-request-link").text());
       console.log(pr_graphic.pr_url);
       pr_graphic.getPullRequestInfo();
    });
};
console.log("pull request graphics");
jQuery(pullRequestGraphics);
