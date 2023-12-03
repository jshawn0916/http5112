


// AJAX for teacher here
// This file is connected to the project via Shared/_Layout.cshtml


function AddTeacher() {

	var formHandle = document.forms.addTeacher;

	var TeacherFname = formHandle.TeacherFname.value;
	var TeacherLname = formHandle.TeacherLname.value;
	var EmployeeNumber = formHandle.EmployeeNumber.value;
	var Salary = formHandle.Salary.value;

	//input validation
	if (TeacherFname == false || TeacherLname == false || EmployeeNumber == false || Salary == false) {
		alert('Enter all information');
		return false;
	}

	var formData = new FormData(formHandle);
	formData.append('TeacherFname', TeacherFname);
	formData.append('TeacherLname', TeacherLname);
	formData.append('EmployeeNumber', EmployeeNumber);
	formData.append('Salary', Salary);

	var rq = new XMLHttpRequest();

	//goal: send a request which looks like this:
	//POST : http://localhost:44374/api/Teacher/Create
	//with POST data of teachername, employeenumber, hire date, etc.
	
	var URL = "/Teacher/Create";

	//Create XMLHttpRequest object
	rq.open("POST", URL, true);

	rq.onreadystatechange = function () {
		//ready state should be 4 AND status should be 200
		if (rq.readyState == 4 && rq.status == 200) {
			//request is successful and the request is finished
			location.href = '/Teacher/List';
		} else {
			alert("Check again your information");
			console.error(rq.status);
		}

	}
	//POST information sent through the .send() method
	rq.send(formData);

	return false;
}

function DeleteTeacher(teacherId) {

	var rq = new XMLHttpRequest();
	var URL = "/Teacher/Delete/" + Number(teacherId);

	//Create XMLHttpRequest object
	rq.open("POST", URL, true);
	rq.onreadystatechange = function () {
		//ready state should be 4 AND status should be 200
		if (rq.readyState == 4 && rq.status == 200) {
			//request is successful and the request is finished
			location.href = '/Teacher/List';
		} else {
			console.error(rq.status);
		}

	}
	rq.send();
	
}