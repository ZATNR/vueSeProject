pragma solidity ^0.4.22;

//     车主结构体struct 
// {
// id:用户id string
// name:车主名 string
// 车辆编号devid : string
// 车牌号：devstr : string
// }
    
contract all {
   struct info {
		string owner_id;
		string owner_name;
		string dev_id;
		string dev_str;
		int isvalid;
	}
    mapping(address => info) public info_addrs;
    info[] public infos;
    //infos.push(newinfo1);
    //"001","老王","002","沪D4313"
    function add(string memory owner_id,string memory owner_name,string  memory dev_id,string memory dev_str)public returns(bool){
        require(!isin(owner_id));
        info memory newinfo = info(
                owner_id,
                owner_name,
                dev_id,
                dev_str,
                1
            );
        infos.push(newinfo);
        return true;
    }
    function change(string memory owner_id,string memory owner_name,string  memory dev_id,string memory dev_str)public returns(bool){
       
        for(uint i=0;i<infos.length;i++){
            if(keccak256(infos[i].owner_id)==keccak256(owner_id)){
                info memory newinfo = info(
                owner_id,
                owner_name,
                dev_id,
                dev_str,
                infos[i].isvalid
            );
               infos[i]=newinfo;
            }
        }
        return true;
    }
    function searchfromindex(uint index) public returns(string,string,string,string,int){

        return (infos[index].owner_id,infos[index].owner_name,infos[index].dev_id,infos[index].dev_str,infos[index].isvalid);
        
    }
     function search(string owner_id) public returns(string,string,string,string,int){
         for(uint i=0;i<infos.length;i++){
            if(keccak256(infos[i].owner_id)==keccak256(owner_id)){
                return (infos[i].owner_id,infos[i].owner_name,infos[i].dev_id,infos[i].dev_str,infos[i].isvalid);
            }
        }
    }
    function searchdevstr(string owner_id) public returns(string){
         for(uint i=0;i<infos.length;i++){
            if(keccak256(infos[i].owner_id)==keccak256(owner_id)){
                return infos[i].dev_str;
            }
        }
    }
    function searchdevid(string owner_id) public returns(string){
         for(uint i=0;i<infos.length;i++){
            if(keccak256(infos[i].owner_id)==keccak256(owner_id)){
                return infos[i].dev_id;
            }
        }
    }
    function searchownname(string owner_id) public returns(string){
         for(uint i=0;i<infos.length;i++){
            if(keccak256(infos[i].owner_id)==keccak256(owner_id)){
                return infos[i].owner_name;
            }
        }
    }
    function check(string owner_id) public returns(bool){
        for(uint i=0;i<infos.length;i++){
            if(keccak256(infos[i].owner_id)==keccak256(owner_id)){
                infos[i].isvalid = 0;
            }
        }
    }
    //撤消资格
    function getlength() public view returns(uint){
           return infos.length;
    }
    function isin(string owner_id) public returns (bool){
        for(uint i=0;i<infos.length;i++){
            if(keccak256(infos[i].owner_id)==keccak256(owner_id)){
                return true;
            }
        }
        return false;
    }
    struct trackinfo1{
        string time;
        int course;
        string devid;
        int speed;
    }
    struct trackinfo2{
        string gear;
        string position;
        //string long;
        string mileage;
        string state;
    }
    //mapping(address => trackinfo[]) public carinfos;
    trackinfo1[] public trackinfos1;
    trackinfo2[] public trackinfos2;
    //infos.push(newinfo1);
    //"001","老王","002","沪D4313"
    function add1(string memory time,int course,string memory devid,
    int speed)public returns(bool){
        trackinfo1 memory newinfo1 = trackinfo1(
            time,
            course,
            devid,
            speed
        );
        trackinfos1.push(newinfo1);
        return true;
    }
    function add2(string memory gear,string memory position,string memory mileage,string memory state)public returns(bool){
          trackinfo2 memory newinfo2 = trackinfo2(
            gear,
            position,
            mileage,
            state
        );
        trackinfos2.push(newinfo2);
        return true;
    }
    function gettracklength() public view returns(uint){
           return trackinfos1.length;
    }
    function getlengthtest() public returns(string,int){
        //trackinfos[0].time,trackinfos[0].course
          return (trackinfos1[0].time,trackinfos1[0].course);
    }
    function search_1(uint index) public returns(string,int,string,int){
        return (trackinfos1[index].time,trackinfos1[index].course,trackinfos1[index].devid,trackinfos1[index].speed);
    }
    function search_2(uint index) public returns(string,string,string,string){
        return (trackinfos2[index].gear,trackinfos2[index].position,trackinfos2[index].mileage,trackinfos2[index].state);
    }
    //撤消资格

}
//     车主结构体struct 
// {
// id:用户id string
// name:车主名 string
// 车辆编号devid : string
// 车牌号：devstr : string
// }
    