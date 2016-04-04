console.log("generating graphics");
var pullRequestGraphics = function () {
    console.log("iterating through projects...");
    $("tbody tr").each(function() {
       var pr_graphic = new PullRequestGraphic($(this).find("h4").text(), $(this).find("div.pull-request-link").text());
       console.log(pr_graphic.pr_url);
       pr_graphic.getPullRequestInfo();
    });
};
console.log("pull request graphics");
$(pullRequestGraphics);