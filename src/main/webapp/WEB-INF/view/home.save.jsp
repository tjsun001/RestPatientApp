<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE HTML>
<html>
  <head>
    <title>Patient Info (Spring/MVC/AJAX/Hibernate/MYSQL)</title>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
      <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
      <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
      <link rel="stylesheet" href="/resources/demos/style.css" />
      <script>
      $(function() {
        $("#dateOfBirthInput").datepicker();
      });
      </script>
    <style>
    	body { background-color: #eee; font: helvetica; }
    	#container { width: 500px; background-color: #fff; margin: 30px auto; padding: 30px; border-radius: 5px; box-shadow: 5px; }
    	.green { font-weight: bold; color: green; }
    	.message { margin-bottom: 10px; }
    	label { width:200px; display:inline-block;}
    	.hide { display: none; }
    	.error { color: red; font-size: 0.8em; }
    </style>
    <script src="resources/mask/mask.js" type="text/javascript"></script>
    <script src="resources/gen_validatorv4.js" type="text/javascript"></script>
  </head>
  <body>

	<div id="container">

		<h1>Patient Information</h1>

		<h2>Get Patient by Social Security ID</h2>
		<form id="SSNForm" >
		    <div id='SSNForm_SSN_errorloc' style="font-style: italic"></div>
			<input type="submit" value="Get Patient Info By SSN" id="getBySSNIDButton"/>
			<input type="text" name="SSN"  id="SSN" value="888-88-8888"  />
			<script type="text/javascript">
                        $("#SSN").mask("999-99-9999");
                        </script>
			 <div id="SSNFormResponseMsg"> </div>
		</form>
		<script  type="text/javascript">
            //var frmvalidator = new Validator("SSNForm");
		    //frmvalidator.addValidation("SSN","req"," Please enter your SSN");
		    //frmvalidator.EnableOnPageErrorDisplay();
        //frmvalidator.EnableMsgsTogether();
        </script>

		<hr/>

		<h2>Patient Details</h2>
		<form id="newPersonForm">
		    <div style="font-style: italic" id='newPersonForm_firstName_errorloc'></div>
			<label for="nameInput">First Name: </label>
			    <input type="text" name="firstName" id="firstNameInput" />
			<br/>
             <div id='newPersonForm_lastName_errorloc' style="font-style: italic"></div>
			<label for="nameInput">Last Name: </label>
                <input type="text" name="lastName" id="lastNameInput" required/>
            <br/>
            <div id='newPersonForm_dateOfBirth_errorloc' style="font-style: italic"></div>
			<label for="nameInput">Date Of Birth: </label>
                <input type="text" name="dateOfBirth" id="dateOfBirthInput" />
            <br/>
            <div id='newPersonForm_socialSecurityNumber_errorloc' style="font-style: italic"></div>
            <label for="nameInput">Social Security Number: </label>
                <input type="text" name="socialSecurityNumber" id="socialSecurityNumber" />
            <br/>
            <script type="text/javascript">
            $("#socialSecurityNumber").mask("999-99-9999");
            </script>
            <div id='newPersonForm_countryOfBirth_errorloc' style="font-style: italic"></div>
            <label for="nameInput">Country of Birth: </label>
                <!--
                <input type="text" name="countryOfBirth" id="countryOfBirth" />
                -->
                <select selected="selected" id="countryOfBirth" name="countryOfBirth">
                                <option>USA</option>
                                  <option>Google Chrome</option>
                                  <option>Firefox</option>
                                  <option>Internet Explorer</option>
                                  <option>Safari</option>
                                  <option>Opera</option>
                                </select>
            <br/>
            <!--
            <label for="nameInput">State/City of Birth: </label>
                //<input type="text" name="StateOfBirth" id="stateOfBirthInput" />

            <br/>

			<label for="ageInput">Age: </label>
			<input type="text" name="age" id="ageInput" />   -->
			<br/>
			<br/>


			<input type="submit" class="addClick" value="Add New Patient Info" id="updatePatientSubmit"/>
			<input type="button" value="Reset Input" onclick="formLoad()"/>

			<input type="submit" class="deleteClick" value="Delete Patient Info" id="deletePatientSubmit/>
			<br/><br/>
			<input type="hidden" name="action" id="action" />
			<br/>
			<div id="newPatientFormResponseMsg"> </div>
			<input type="hidden" id="btaction"/>
			<input type="hidden" id="firstNameFlag"/>
			<input type="hidden" id="lastNameFlag"/>
			<input type="hidden" id="SSNFlag"/>
			<input type="hidden" id="dobFlag"/>
			<input type="hidden" id="cobFlag"/>
		</form>
          <script  type="text/javascript">
            function validateNewPersonForm() {
                //alert("in validation function");

                var elem = document.getElementById("firstNameInput");

                    if (elem.value.length > 0){
                        //alert("fname length greater than zero; length = " + elem.value.length );
                        $('#firstNameFlag').val("pass");
                    }else{
                        //alert("fname length not greater than zero; length = " + elem.value.length );
                        $('#firstNameFlag').val("fail");
                    }

                elem = document.getElementById("lastNameInput");

                    if (elem.value.length > 0){
                        //alert("last name length greater than zero; length = " + elem.value.length );
                        $('#lastNameFlag').val("pass");
                    }else{
                        //alert("last name length not greater than zero; length = " + elem.value.length );
                        $('#lastNameFlag').val("fail");
                    }

                elem = document.getElementById("dateOfBirthInput");

                    if (elem.value.length > 0){
                        //alert("DOB length greater than zero; length = " + elem.value.length );
                        $('#dobFlag').val("pass");
                    }else{
                        //alert("DOB length not greater than zero; length = " + elem.value.length );
                        $('#dobFlag').val("fail");
                    }

                elem = document.getElementById("socialSecurityNumber");

                    if (elem.value.length > 0){
                        //alert("socialSecurityNumber length greater than zero; length = " + elem.value.length );
                        $('#SSNFlag').val("pass");
                    }else{
                        //alert("socialSecurityNumber length not greater than zero; length = " + elem.value.length );
                        $('#SSNFlag').val("fail");
                    }

                elem = document.getElementById("countryOfBirth");

                    if (elem.value.length > 0){
                        //alert("countryOfBirth length greater than zero; length = " + elem.value.length );
                        $('#COBFlag').val("pass");
                    }else{
                        //alert("countryOfBirth length not greater than zero; length = " + elem.value.length );
                        $('#COBFlag').val("fail");
                    }

            }

          </script>
	</div>


	<script type="text/javascript">

		$(document).ready(function() {

			// Person By SSN AJAX Request
                $('#getBySSNIDButton').click(function() {
                $('#newPatientFormResponseMsg').text(' ');
                    formReset();
                    var SSN = +$('#SSN').val();
                    var elem = document.getElementById("SSN");
                    $.getJSON('${pageContext.request.contextPath}/api/person/user/' + elem.value , function(user) {

                        if (!(user.firstName == null)){

                            var elem = document.getElementById("firstNameInput");
                            elem.value = user.firstName;

                            var elem = document.getElementById("lastNameInput");
                            elem.value = user.lastName;

                            var elem = document.getElementById("dateOfBirthInput");
                            elem.value = user.dateOfBirth;

                            var elem = document.getElementById("socialSecurityNumber");
                            elem.value = user.socialSecurityNumber;

                            var elem = document.getElementById("countryOfBirth");
                            elem.value = user.countryOfBirth;

                         $('#SSNFormResponseMsg').text(" ");
                        // $('#NameInput').value = user.name;
                        }else{
                        //alert("SSN: " + user.socialSecurityNumber + " not found");
                        $('#SSNFormResponseMsg').text("SSN not found " + user.socialSecurityNumber );
                        }

                    });
                });

			// Request Person by SSN AJAX
                $('#SSNForm').submit(function(e) {

                    var personId = +$('#personId').val();
                    if(!validatePersonId(personId))
                        return false;
                    $.get('${pageContext.request.contextPath}/api/person/' + personId, function(person) {
                        $('#personIdResponse').text(person.name + ', age ' + person.age);
                    });
                    e.preventDefault(); // prevent actual form submit
                });

			// Save Person AJAX Form Submit
                $('#randomPerson').click(function() {
                    $.getJSON('${pageContext.request.contextPath}/api/person/random', function(person) {
                        $('#personResponse').text(person.name + ', age ' + person.age);
                    });
                });

			    $('.deleteClick').click(function() {
                    var r=confirm("Are you sure you want to delete the selected item?");
                    if (r==false){
                       // alert("false");
                        return;
                    }else{
                        // alert("true");
                    }
                    var elem = document.getElementById("btaction");
                    $('#btaction').val(1);
                        //e.preventDefault(); // prevent actual form submit and page reload
                     });


            $('.addClick').click(function() {
                //alert("addClick");
                var elem = document.getElementById("btaction");
                    $('#btaction').val(0);
                });

			$('#newPersonForm').submit(function(e) {
			    //alert("in newperson submit");
			    validateNewPersonForm ();
			    var focusField ;

                var flag = document.getElementById("firstNameFlag");
                if (flag.value == "fail"){
                    //alert("validation failed flag = " + flag.value) ;
                    $('#newPersonForm_firstName_errorloc').text('missing first name');
                    focusField = document.getElementById("firstNameInput");
                    focusField.focus();
                    e.preventDefault();
                    return;
                 }else{
                     //alert("validation passed flag = " + flag.value) ;
                     $('#newPersonForm_firstName_errorloc').text('');
                     //return;
                 }

                var flag = document.getElementById("lastNameFlag");
                if (flag.value == "fail"){
                    //alert("validation failed flag = " + flag.value) ;
                    $('#newPersonForm_lastName_errorloc').text('missing last name');
                    focusField = document.getElementById("lastNameInput");
                    focusField.focus();
                    e.preventDefault();
                    return;
                 }else{
                     //alert("validation passed flag = " + flag.value) ;
                     $('#newPersonForm_lastName_errorloc').text('');
                     //return;
                 }

                var flag = document.getElementById("dobFlag");
                if (flag.value == "fail"){
                    //alert("validation failed flag = " + flag.value) ;
                    $('#newPersonForm_dateOfBirth_errorloc').text('missing DOB');
                    focusField = document.getElementById("dateOfBirthInput");
                    focusField.focus();
                    e.preventDefault();
                    return;
                 }else{
                     //alert("validation passed flag = " + flag.value) ;
                     $('#newPersonForm_dateOfBirth_errorloc').text('');
                     //return;
                 }

                var flag = document.getElementById("SSNFlag");
                if (flag.value == "fail"){
                    //alert("validation failed flag = " + flag.value) ;
                    $('#newPersonForm_socialSecurityNumber_errorloc').text('missing SSN');
                    focusField = document.getElementById("socialSecurityNumber");
                    focusField.focus();
                    e.preventDefault();
                    return;
                 }else{
                     //alert("validation passed flag = " + flag.value) ;
                     $('#newPersonForm_socialSecurityNumber_errorloc').text('');
                     //return;
                 }

                var flag = document.getElementById("cobFlag");
                if (flag.value == "fail"){
                    //alert("validation failed flag = " + flag.value) ;
                    $('#newPersonForm_countryOfBirth_errorloc').text('missing COB');
                    focusField = document.getElementById("countryOfBirth");
                    focusField.focus();
                    e.preventDefault();
                    return;
                 }else{
                     //alert("validation passed flag = " + flag.value) ;
                      $('#newPersonForm_countryOfBirth_errorloc').text('');
                     //return;
                 }

                var action = document.getElementById("btaction");
                if (action.value == 0) {
                    $.post('${pageContext.request.contextPath}/api/user', $(this).serialize(),
                        function(response) {
                        $('#newPatientFormResponseMsg').text(response);
                        }) ;
                }else
                if (action.value == 1){
                    var deleteUserObject = document.getElementById("newPersonForm");
                    $.get('${pageContext.request.contextPath}/api/delete', $(deleteUserObject).serialize(),function(response1) {
                             $('#newPatientFormResponseMsg').text(response1);
                            }) ;
                        }
                   //e.preventDefault();

                e.preventDefault(); // prevent actual form submit and page reload
            });


		});

		function validatePersonId(personId) {

			if(personId === undefined || personId < 0 || personId > 3) {
				$('#idError').show();
				return false;
			}
			else {
				$('#idError').hide();
				return true;
			}
		}
        function formLoad()
           {
           //document.getElementById("newPersonForm").reset();
           location.reload();
           }
        function formReset()
           {
           document.getElementById("newPersonForm").reset();
           //location.reload();
           }


	</script>


  </body>
</html>