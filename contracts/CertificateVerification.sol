// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract CertificateVerification {
    address public admin;

    struct Certificate {
        string studentName;
        string courseName;
        uint256 issueDate;
        address issuer;
        bool isValid;
    }

    uint256 public certCounter = 0;
    mapping(uint256 => Certificate) public certificates;

    event CertificateIssued(uint256 certId, address indexed issuer, string studentName);
    event CertificateRevoked(uint256 certId);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action.");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function issueCertificate(string memory _studentName, string memory _courseName) public onlyAdmin {
        certCounter++;
        certificates[certCounter] = Certificate({
            studentName: _studentName,
            courseName: _courseName,
            issueDate: block.timestamp,
            issuer: msg.sender,
            isValid: true
        });

        emit CertificateIssued(certCounter, msg.sender, _studentName);
    }

    function revokeCertificate(uint256 _certId) public onlyAdmin {
        require(certificates[_certId].isValid, "Certificate is already revoked or doesn't exist.");
        certificates[_certId].isValid = false;
        emit CertificateRevoked(_certId);
    }

    function verifyCertificate(uint256 _certId) public view returns (bool) {
        return certificates[_certId].isValid;
    }
}
