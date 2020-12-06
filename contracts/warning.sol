pragma solidity ^0.4.22;

// 坏账序号 ID （设置为自增即可）建立一个mapping
// 坏账：struct
// 公司 ID
// 公司 string
// 案件名称 string
// 案件类型 int 1：金额案件 2：货物支持案件 3：产能互换案件
// 案件详细信息 string 如 美丝可股份有限公司与浙江淘宝网络有限公司,张勇相关贷款金额纠纷，结果：本案按原告沈金利撤回起诉处理
// 坏账记录时间 string 如 2020-07-01
// 坏账案号 string 如（2020）冀0404民初604号
contract Credit {
    struct badtrack{
       int ID;
       string companyId;
       string companyname;
       int tracktype;
       string info;
       string date;
       string trackid;
    } 
    struct risk{
        string companyId;
        string companyname;
        int index;
    }
    int i = 0;
    mapping(address => badtrack) public info_addrs;
    badtrack[] public badtracks;
    risk[] public risks;
    
    //10000000,"sdasda",1,"sdads","dsadad","dsadasd","123456","ddasdasd"
    function add(string memory companyId,string memory companyname,int tracktype,string memory info,string memory date,string trackid)public returns(bool){
        require(badisin(trackid));
        badtrack memory newtrack = badtrack(
                i,companyId,companyname,tracktype,info,date,trackid
                
            );
            i+=1;
        badtracks.push(newtrack);
        addrisk(companyId,companyname);
        return true;
    }
    function addrisk(string memory companyId,string memory companyname)public returns (bool){
        if(riskisin(companyId)){
            changerisk(companyId);
        }else{
            risk memory newrisk = risk(
                companyId,companyname,5
            );
        }
        risks.push(newrisk);
        return true;
    }
    function changebadtrack(string memory companyId,string memory companyname,int tracktype,string memory info,string memory date,string trackid)public returns(bool){
        badtrack memory newbadtrack = badtrack(
                i,companyId,companyname,tracktype,info,date,trackid
            );
        // infos.push(newinfo);
        for(uint k=0;k<badtracks.length;k++){
            if(keccak256(badtracks[k].trackid)==keccak256(newbadtrack.trackid)){
                badtracks[k] = newbadtrack;
            } 
        }
        return true;
    }
    function searchbadtrack(string trackid) returns (int){
        for(uint k=0;k<badtracks.length;k++){
            if(keccak256(badtracks[k].trackid)==keccak256(trackid)){
                return badtracks[k].ID;
            } 
        }
    }
    function badisin(string trackid) returns(bool){
        for(uint k=0;k<badtracks.length;k++){
            if(keccak256(badtracks[k].trackid)==keccak256(trackid)){
                return true;
            } 
        }
        return false;
    }
    function riskisin(string companyId) returns(bool){
        for(uint k=0;k<risks.length;k++){
            if(keccak256(risks[k].companyId)==keccak256(companyId)){
                return true;
            } 
        }
        return false;
    }
    function getlength() public view returns(uint){
           return badtracks.length;
    }
    function changerisk(string companyId)public  returns (bool){
        for(uint k=0;k<risks.length;k++){
            if(keccak256(risks[k].companyId)==keccak256(companyId)){
                risks[k].index += 5;
            } 
        }
        return false;
    }
   

}
