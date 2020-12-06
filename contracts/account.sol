pragma solidity ^0.4.22;

//     车主结构体struct 
// {
// id:用户id string
// name:车主名 string
// 车辆编号devid : string
// 车牌号：devstr : string
// }
    
contract account {
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

}