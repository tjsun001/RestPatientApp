$('.deleteClick').click(function() {
			    var r=confirm("Are you sure you want to delete the selected item?");
			    if (r==false){alert("false"); return;} alert("true");
			    var elem = document.getElementById("newPersonForm");
                 $.getJSON('${pageContext.request.contextPath}/api/person/user/' + elem.value , function(user) {
                         alert("here");
                       }

                 				e.preventDefault(); // prevent actual form submit and page reload
                 			});