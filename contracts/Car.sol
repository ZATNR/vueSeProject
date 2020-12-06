
pragma solidity =0.4.22;
contract Car{
    string brand;
    uint public price;
    function setBrand(string newBrand)public{
        brand=newBrand;
    }
    function getBrand()public view returns(string){
        return brand;
    }
    constructor(string initBrand,uint initPrice){
        brand=initBrand;
        price =initPrice;
    }
}
