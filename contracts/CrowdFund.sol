// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Crowdfund is Ownable {
    struct projectData {
        uint startAt;
        uint endAt;
        uint target;
        uint pledged;
        string projectName;
    }

    IERC20 public immutable token;

    constructor(IERC20 _token) {
        token = _token;
    }

    event projectLaunch(uint id, uint target, uint startAt, uint endAt);
    event pledge(uint indexed id, address indexed caller, uint amount);
    uint public count;

    mapping(uint => projectData) public projects;
    mapping(uint => mapping(address => uint)) funders;

    function CreateFundProject(
        uint _startAt,
        uint _endAt,
        uint _target,
        string memory _projectName
    ) external onlyOwner {
        require(_startAt >= block.timestamp, "Time is not Accurate");
        require(_endAt >= _startAt, "Time is not Accurate");
        count++;
        projects[count] = projectData({
            startAt: _startAt,
            endAt: _endAt,
            target: _target,
            pledged: 0,
            projectName: _projectName
        });
        emit projectLaunch(count, _target, _startAt, _endAt);
    }

    function Pledge(uint _projectId, uint _amt) external {
        require(
            projects[_projectId].endAt > block.timestamp,
            "This fund is no longer active"
        );
        token.transferFrom(msg.sender, address(this), _amt);
        projects[_projectId].pledged += _amt;
        funders[_projectId][msg.sender] = _amt;
        emit pledge(_projectId, msg.sender, _amt);
    }

    function Refund(uint _projectId) external {
        uint amount = funders[_projectId][msg.sender];
        require(
            projects[_projectId].endAt <= block.timestamp,
            "This project is not ended yet"
        );
        require(
            projects[_projectId].pledged < projects[_projectId].target,
            "Target Achieved by this Project"
        );
        funders[_projectId][msg.sender] = 0;
        token.transfer(msg.sender, amount);
    }

    function ClaimByProjectOwner(uint _projectId) external onlyOwner {
        uint amount = projects[_projectId].pledged;
        require(
            projects[_projectId].endAt < block.timestamp,
            "This Project is still active,You Can't Claim"
        );
        require(
            projects[_projectId].pledged >= projects[_projectId].target,
            "You can't Claim:Target not achieved"
        );
        projects[_projectId].pledged = 0;
        token.transfer(msg.sender, amount);
    }
}
