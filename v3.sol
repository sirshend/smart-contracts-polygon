pragma solidity ^0.8.0;

contract School {
    event RequestApproval(address indexed student, address[] teachers);
    event ApprovalReceived(address indexed student);

    struct Request {
        address[] teachers;
        mapping(address => bool) approvals;
    }

    mapping(address => Request) private requests;
    mapping(address => bool) public students;
    mapping(address => bool) public teachers;

    function registerStudent(address student) external {
        students[student] = true;
    }

    function registerTeacher(address teacher) external {
        teachers[teacher] = true;
    }

    function requestApproval(address[] calldata teachersList) external {
        require(students[msg.sender], "Only registered students can request approval.");
        for(uint i = 0; i < teachersList.length; i++) {
            require(teachers[teachersList[i]], "Only registered teachers can be requested for approval.");
        }
        requests[msg.sender] = Request(teachersList);
        emit RequestApproval(msg.sender, teachersList);
    }

    function approveRequest(address student) external {
        require(teachers[msg.sender], "Only registered teachers can approve.");
        Request storage request = requests[student];
        require(isTeacher(request, msg.sender), "Only requested teacher can approve.");
        require(!request.approvals[msg.sender], "Teacher has already approved.");

        request.approvals[msg.sender] = true;

        if(isApproved(request)) {
            emit ApprovalReceived(student);
        }
    }

    function isTeacher(Request storage request, address teacher) private view returns(bool) {
        for(uint i = 0; i < request.teachers.length; i++) {
            if(request.teachers[i] == teacher) {
                return true;
            }
        }
        return false;
    }

    function isApproved(Request storage request) private view returns(bool) {
        for(uint i = 0; i < request.teachers.length; i++) {
            if(!request.approvals[request.teachers[i]]) {
                return false;
            }
        }
        return true;
    }
}
