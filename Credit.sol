pragma solidity ^0.4.22;

// 利率 ufixed5x4
// 涉及金额 eth = 10 ^18 wei int256（借贷消息表示借款总金额，库存协调和产能互换表示酬金）
// 期限 string（库存协调放空）
// 类型 1表示借贷，2表示库存，3表示产能
// 不足的物件名：name string（借贷信息默认值为money）
// 状态量 true 审核通过，false 审核不通过
// 借贷信息 string
// 公司名字 string
// 借贷人ID（公司ID） string
// place 公司地点 string
contract Credit {
    struct info{
        
       //int rate;
       int amount;
       string date;
       int infotype;
       string goods;
       bool Issuccees;
       string message;
       string companyname;
       string companyId;
       string place;
       //bool Istransaction;
    } 
    mapping(address => info) public info_addrs;
    info[] public infos;
    info  newinfo1 = info(
                //rate,
                10000000,
                "sdasda",
                1,
                "sdads",
                false,
                "dsadad",
                "dsadasd",
                "123456",
                "ddasdasd"
                //false
            );
    //infos.push(newinfo1);
    //10000000,"sdasda",1,"sdads","dsadad","dsadasd","123456","ddasdasd"
    function add(int amount,string memory date,int infotype,string  memory goods,string memory message,string memory companyname,string memory companyId,string memory place)public returns(bool){
        info memory newinfo = info(
                //rate,
                amount,
                date,
                infotype,
                goods,
                false,
                message,
                companyname,
                companyId,
                place
                //false
            );
        infos.push(newinfo);
        return true;
    }
    function change(int amount, string  date,int infotype,string   goods,string  message,string  companyname,string  companyId,string  place)public returns(bool){
        info memory newinfo = info(
                //rate,
                amount,
                date,
                infotype,
                goods,
                false,
                message,
                companyname,
                companyId,
                place
                //false
            );
        // infos.push(newinfo);
        for(uint i=0;i<infos.length;i++){
            if(i!=0){
                infos[i]=newinfo;
            }
        }
        return true;
    }
    function search() public returns(string){
        //address numb1=address(infos[0]);
        return infos[0].date;
    }
    function sear() public returns(string){
        //address numb1=address(infos[0]);
        return newinfo1.date;
    }
    function check(bool goodss) public returns(string){
        string memory ret ;
        if( !goodss){
            ret=newinfo1.date;
        }
        // for(uint i=0;i<infos.length;i++){
        //     if(keccak256(infos[i].goods)==keccak256(goods)){
        //         infos[i].Issuccees=true;
        //         ret=newinfo1.date;
        //     }
        // }
        return ret;
    }
    function getlength() public view returns(uint){
           return infos.length;
    }
    function send() returns(bool){
        //ajax.post
    }
    function confirm(string goods) returns(string){
        for(uint i=0;i<infos.length;i++){
            if(keccak256(infos[i].goods)==keccak256(goods)){
                return infos[i].companyId;
            }
        }
    }
}