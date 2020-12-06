pragma solidity ^0.4.22;

//     车主结构体struct 
// {
// id:用户id string
// name:车主名 string
// 车辆编号devid : string
// 车牌号：devstr : string
// }
    
contract trail {
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
    function getlength() public view returns(uint){
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