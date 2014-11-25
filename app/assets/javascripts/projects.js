
/// photo uploading

/// new user & project functions

function engine(){

    $(document).ready(function() {

        var projectTags = [];

        var parseAPPID = ENV['PARSE_APPID_KEY'];
        var parseJSID = ENV['PARSE_JS_KEY'];

        //Initialize Parse
        Parse.initialize(parseAPPID,parseJSID);
        $("#fileUploader").on("change", function(e) {
          e.preventDefault();

            var fileUploadControl = $("#fileUploader")[0];
            if (fileUploadControl.files.length > 0) {
                var file = fileUploadControl.files[0];
                var name = "photo.jpg";

                console.log("here goes nothing...");
                $('#pic').attr('src', "/images/loader.gif");

                var parseFile = new Parse.File(name, file);
                parseFile.save().then(
                    function() {
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

});
}
