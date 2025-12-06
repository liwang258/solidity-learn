// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract ERC20demo{

     uint256 private  _totalSupply;

     address public _owner;

     string private _name;

     string private _symbol;

     mapping(address=>uint256) _balanceMap;

     mapping(address=>mapping(address=>uint256)) _approvedMap;

    constructor(string memory name,string memory symbol,address owner){
       _name=name;
       _symbol=symbol;
       _owner=owner;
    }

    modifier onyOwner(){
        require(msg.sender==_owner);
        _;
    }

    event Transfer(address indexed from, address indexed to, uint256 value);
  
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function mint(uint256 total) external onyOwner{
        _totalSupply=total;
        _balanceMap[msg.sender]=total;
    }
   

    function totalSupply() external view returns (uint256){
        return _totalSupply;
    }

    /**
     * @dev Returns the value of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256){
        return _balanceMap[account];
    }


    function transfer(address to, uint256 value) external returns (bool){
        require(_balanceMap[msg.sender]>value);
        _balanceMap[msg.sender]=_balanceMap[msg.sender]-value;
        _balanceMap[to]=_balanceMap[to]+value;
        emit Transfer(msg.sender, to, value);
        return true;
    }


   //获取已经授权的金额
    function allowance(address owner, address spender) external view returns (uint256){
        return _approvedMap[spender][owner];
    }

   //批准给spender授权value
    function approve(address spender, uint256 value) external returns (bool){
        _approvedMap[spender][msg.sender]=value;
        emit Approval(msg.sender, spender, value);
        return true;
    }


    function transferFrom(address from, address to, uint256 value) external returns (bool){
        //被转出的账户余额要足够
        require(_balanceMap[from]>=value);
        //被授权的账户可转移余额要足够
        require(_approvedMap[msg.sender][from]>=value);
        _approvedMap[msg.sender][from]=_approvedMap[msg.sender][from]-value;
        _balanceMap[from]=_balanceMap[from]-value;
        _balanceMap[to]=_balanceMap[to]+value;
        return true;
    }

    function IsOwner() public view returns(bool){
        return msg.sender==_owner;
    }
}