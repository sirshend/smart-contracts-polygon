// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract School {
    event RequestApproval(address indexed student, address[] teachers);
    event ApprovalReceived(address indexed student);

    struct Request {
        address[] teachers;
        mapping(address => bool) approvals;
    }

    mapping(address => Request) private requests;

    function requestApproval(address[] calldata teachers) external {
        Request storage newRequest = requests[msg.sender];
        newRequest.teachers = teachers;
        emit RequestApproval(msg.sender, teachers);
    }

    function approveRequest(address student) external {
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
