
const fs = require('fs-extra');
const solc = require('solc');
const path = require('path');
 
const compiledPath = path.resolve(__dirname,'../compiled');
fs.removeSync(compiledPath);
fs.ensureDirSync(compiledPath);
 
//check errors
// if(Array.isArray(result.errors) && result.errors.length){
//     throw new Error(result.errors[0]);
// }
 
const contractPath = path.resolve(__dirname,'../contracts','all.sol');
const contractSource = fs.readFileSync(contractPath,'utf-8');
let compileResult = solc.compile(contractSource,1);
 
//console.log(compileResult);
 
Object.keys(compileResult.contracts).forEach(name=>{
    let contractName = name.replace(/^:/,'');
    let filepath = path.resolve(__dirname, '../compiled', `${contractName}.json`);
    fs.outputJsonSync(filepath,compileResult.contracts[name]);
    console.log("Saving json file to ",filepath);
});
