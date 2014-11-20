/// photo uploading

var projectTags = [];

$(document).ready(function() {

    var parseAPPID = "WaIQr0ALAedB6JhACwDdqAJXN5m0kBizefvqIRMd";
    var parseJSID = "JWFUQveemVMqiwfgLY5GVDrjCF9t3HQpv1wvE0Z1";

    //Initialize Parse
    Parse.initialize(parseAPPID,parseJSID);
    $("#fileUploader").on("change", function(e) {
      e.preventDefault();

        var fileUploadControl = $("#fileUploader")[0];
        if (fileUploadControl.files.length > 0) {
            var file = fileUploadControl.files[0];
            var name = "photo.jpg";

            console.log("here goes nothing...");
            $('#pic').attr('src', "/assets/loader.gif");

            var parseFile = new Parse.File(name, file);
            parseFile.save().then(
                function() {
                    console.log("Woot!");
                    console.log(parseFile.url());
                    $('#url').val(parseFile.url());
                    $('#pic').attr('src', parseFile.url());
                },
                function(error) {
                    console.log("Error");
                    console.dir(error);
            });
        }
    });

  $( ".project-tag" ).on("click", function(event) {
    if (projectTags.indexOf(event.target.id) !== -1) {
      projectTags.splice(this.index, 1);
      $(this).toggleClass( "active" );
      console.log(projectTags);
    }
    else {
      projectTags.push(event.target.id);
      $(this).toggleClass( "active" );
      $('#project-tags-input').val(projectTags);
      console.log(projectTags);
    }

  });

});
