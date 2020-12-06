
const Web3 = require('web3')
const web3 = new Web3(new Web3.providers.HttpProvider("Http://localhost:8545"));
const path = require('path')
 
const filePath = path.resolve(__dirname,'../compiled/all.json');
const {interface , bytecode} = require(filePath);
 
const abi = JSON.parse(interface);
const contract = web3.eth.contract(abi);
const _from = web3.eth.accounts[0];
//const txObj = {data:bytecode,from:_from,gas:5000000};
const txObj = {data:bytecode,from:_from,gas:6000000};
 
let contractInstance = contract.new(txObj,(err,res)=>{
    if(err)
        console.log("Error:",err);
    else
        console.log("Result:",res);
});
