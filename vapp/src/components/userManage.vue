<template>
  <el-container>
    <!-- 头部 -->
    <el-header class="Header">
      <img src="../assets/创新项目LOGO.png" alt="">
      <span class="systemTitle">车辆轨迹Dapp系统</span>
      <div class="divRight">
        <div style="display: inline-block">
          <el-input
            class="input-with-select"
            placeholder="请输入内容"
            v-model="userIdSearched"
          >
            <el-button
              v-on:click="searchUser()"
              slot="append"
              icon="el-icon-search"
            ></el-button>
          </el-input>
        </div>
        <el-button
          style="margin-left: 22px"
          class="quitButton"
          type="danger"
          v-on:click="quit"
          >退出</el-button
        >
      </div>
    </el-header>
    <el-container class="Body">
      <el-aside class="Aside" width="320px">
        <el-menu default-active="1" class="el-menu-vertical-demo">
          <el-menu-item v-on:click="goToUser()" index="1">
            <i class="el-icon-menu"></i>
            <span slot="title">用户管理</span>
          </el-menu-item>
          <el-menu-item v-on:click="goToPath()" index="2">
            <i class="el-icon-document"></i>
            <span slot="title">车辆轨迹管理</span>
          </el-menu-item>
          <el-menu-item v-on:click="goToMap()" index="3">
            <i class="el-icon-document"></i>
            <span slot="title">地图</span>
          </el-menu-item>
          <el-collapse v-model="activeNames" @change="handleChange">
            <el-collapse-item title="加盟交易信息公示栏" name="1" class="public">
              <el-tree
                :data="userData"
                :props="defaultProps"
                @node-click="handleNodeClick"
              ></el-tree>
            </el-collapse-item>
            <el-collapse-item title="轨迹存储交易信息公示栏" name="2" class="public">
              <el-tree
                :data="pathData"
                :props="defaultProps"
                @node-click="handleNodeClick"
              ></el-tree>
            </el-collapse-item>
          </el-collapse>
        </el-menu>
      </el-aside>
      <el-main class="Main">
        <el-dialog title="添加用户" :visible.sync="newUserVisible" width="40%">
          <el-form
            ref="newUserForm"
            :model="newUserForm"
            label-width="150px"
            class="insertaccount"
          >
            <el-form-item label="用户名">
              <el-input
                v-model="newUserForm.userName"
                style="width: 250px"
                placeholder="请输入用户名"
              ></el-input>
            </el-form-item>
            <el-form-item label="用户ID">
              <el-input
                v-model="newUserForm.userID"
                style="width: 250px"
                placeholder="请输入用户ID"
              ></el-input>
            </el-form-item>
            <el-form-item label="车辆ID">
              <el-input
                v-model="newUserForm.carID"
                style="width: 250px"
                placeholder="请输入车辆ID"
              ></el-input>
            </el-form-item>
            <el-form-item label="车辆号">
              <el-input
                v-model="newUserForm.carNumber"
                style="width: 250px"
                placeholder="请输入车辆号"
              ></el-input>
            </el-form-item>
          </el-form>
          <div style="margin-top: 50px; margin-left: 280px" class="nbtn">
            <el-button type="info" icon="" v-on:click="close()" size="small"
              >取消</el-button
            >
            <el-button
              type="primary"
              icon=""
              v-on:click="newUser()"
              size="small"
              >提交</el-button
            >
          </div>
        </el-dialog>
        <el-button
          type="primary"
          icon="el-icon-edit"
          v-on:click="addUser()"
          size="small"
          >添加用户</el-button
        >
        <el-table :data="userTable" style="width: 1900">
          <el-table-column prop="userID" label="用户ID" width="150">
          </el-table-column>
          <el-table-column prop="userName" label="用户名" width="160">
          </el-table-column>
          <el-table-column prop="carID" label="车辆ID" width="160">
          </el-table-column>
          <el-table-column prop="carNumber" label="车牌号" width="160">
          </el-table-column>
          <el-table-column prop="isValid" label="状态" width="160">
          </el-table-column>
          <el-table-column label="操作" width="160"> </el-table-column>
        </el-table>
      </el-main>
    </el-container>
  </el-container>
</template>

<style lang="less" scoped>
.public{
  overflow: auto;
  padding-left: 25px;
  word-break: break-all;
  el-tree {
    word-break: break-all;
    overflow: auto;
  }
}
.el-menu-item {
  border: 0;
}
.insertaccount {
  box-sizing: border-box;
}
.testContainer {
  height: 100%;
}

.Header {
  background-color: #eef6ff;
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 22px;
  color: #409eff;
  background-image: "../";
}
.btn {
  display: flex;
  justify-content: flex-end;
}
.Aside {
  background-color: #fff;
}

.Main {
  background-color: rgb(250, 250, 250);
}
</style>
<script src="../../../web3.min.js"></script>
<script>
var web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
var abi = JSON.parse(
  "[{\"constant\":true,\"inputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"name\":\"infos\",\"outputs\":[{\"name\":\"owner_id\",\"type\":\"string\"},{\"name\":\"owner_name\",\"type\":\"string\"},{\"name\":\"dev_id\",\"type\":\"string\"},{\"name\":\"dev_str\",\"type\":\"string\"},{\"name\":\"isvalid\",\"type\":\"int256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"owner_id\",\"type\":\"string\"}],\"name\":\"searchdevid\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"owner_id\",\"type\":\"string\"},{\"name\":\"owner_name\",\"type\":\"string\"},{\"name\":\"dev_id\",\"type\":\"string\"},{\"name\":\"dev_str\",\"type\":\"string\"}],\"name\":\"change\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"\",\"type\":\"address\"}],\"name\":\"info_addrs\",\"outputs\":[{\"name\":\"owner_id\",\"type\":\"string\"},{\"name\":\"owner_name\",\"type\":\"string\"},{\"name\":\"dev_id\",\"type\":\"string\"},{\"name\":\"dev_str\",\"type\":\"string\"},{\"name\":\"isvalid\",\"type\":\"int256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"index\",\"type\":\"uint256\"}],\"name\":\"searchfromindex\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"},{\"name\":\"\",\"type\":\"string\"},{\"name\":\"\",\"type\":\"string\"},{\"name\":\"\",\"type\":\"string\"},{\"name\":\"\",\"type\":\"int256\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"owner_id\",\"type\":\"string\"}],\"name\":\"searchdevstr\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"owner_id\",\"type\":\"string\"}],\"name\":\"search\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"},{\"name\":\"\",\"type\":\"string\"},{\"name\":\"\",\"type\":\"string\"},{\"name\":\"\",\"type\":\"string\"},{\"name\":\"\",\"type\":\"int256\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"owner_id\",\"type\":\"string\"},{\"name\":\"owner_name\",\"type\":\"string\"},{\"name\":\"dev_id\",\"type\":\"string\"},{\"name\":\"dev_str\",\"type\":\"string\"}],\"name\":\"add\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"name\":\"trackinfos1\",\"outputs\":[{\"name\":\"time\",\"type\":\"string\"},{\"name\":\"course\",\"type\":\"int256\"},{\"name\":\"devid\",\"type\":\"string\"},{\"name\":\"speed\",\"type\":\"int256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"getlength\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"owner_id\",\"type\":\"string\"}],\"name\":\"check\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"index\",\"type\":\"uint256\"}],\"name\":\"search_1\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"},{\"name\":\"\",\"type\":\"int256\"},{\"name\":\"\",\"type\":\"string\"},{\"name\":\"\",\"type\":\"int256\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"gettracklength\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[],\"name\":\"getlengthtest\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"},{\"name\":\"\",\"type\":\"int256\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"gear\",\"type\":\"string\"},{\"name\":\"position\",\"type\":\"string\"},{\"name\":\"mileage\",\"type\":\"string\"},{\"name\":\"state\",\"type\":\"string\"}],\"name\":\"add2\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"name\":\"trackinfos2\",\"outputs\":[{\"name\":\"gear\",\"type\":\"string\"},{\"name\":\"position\",\"type\":\"string\"},{\"name\":\"mileage\",\"type\":\"string\"},{\"name\":\"state\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"index\",\"type\":\"uint256\"}],\"name\":\"search_2\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"},{\"name\":\"\",\"type\":\"string\"},{\"name\":\"\",\"type\":\"string\"},{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"owner_id\",\"type\":\"string\"}],\"name\":\"searchownname\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"time\",\"type\":\"string\"},{\"name\":\"course\",\"type\":\"int256\"},{\"name\":\"devid\",\"type\":\"string\"},{\"name\":\"speed\",\"type\":\"int256\"}],\"name\":\"add1\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"owner_id\",\"type\":\"string\"}],\"name\":\"isin\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"}]"
);
var contractAddr = '0x1501555b54700b4c02cdc20ba186b796802ca16f';
var VotingContract = web3.eth.contract(abi);
var contractInstance = VotingContract.at(contractAddr);
export default {
  data() {
    return {
      newUserForm: {
        userID: "",
        userName: "",
        carID: "",
        carNumber: "",
      },
      // activeNames: ["1"],
      // activeNames: ["2"],
      userIdCurrent: "",
      userTable: [],
      userIdSearched: "",
      input: "",
      newUserVisible: false,
      userData: this.GLOBAL.userArray,
      pathData: this.GLOBAL.pathArray,
      defaultProps: {
        children: "children",
        label: "label",
      },
    };
  },

  methods: {
    close() {
      this.newUserVisible = false;
    },
    getlist() {
      var length = contractInstance.getlength.call();
      console.log(length);
      this.userTable = [];
      for (var i = 0; i < length; i++) {
        var item = contractInstance.searchfromindex.call(i);
        this.userTable.push({
          userID: item[0],
          userName: item[1],
          carID: item[2],
          carNumber: item[3],
          isValid: item[4].toString(),
        });
        console.log(item);
        //this.userTable.push({userID:"001",userName:"老王",carID:"002",carNumber:"沪D4313",isValid:1})
      }
      this.loading = false;
    },
    goToUser() {
      this.$router.push("/userManage");
    },
    goToPath() {
      this.$router.push("/pathManage");
    },
    goToMap(){
      this.$router.push("/map");
    },
    searchUser() {
      this.userTable = [];
      var length = contractInstance.getlength.call();
      for (var i = 0; i < length; i++) {
        var item = contractInstance.searchfromindex.call(i);
        if (item[0] === this.userIdSearched) {
          this.userTable.push({
            userID: item[0],
            userName: item[1],
            carID: item[2],
            carNumber: item[3],
            isValid: item[4].toString(),
          });
        }
        console.log(item);
        console.log(item[0]);
        //this.userTable.push({userID:"001",userName:"老王",carID:"002",carNumber:"沪D4313",isValid:1})
      }
      console.log(this.userIdSearched);
      this.loading = false;
    },
    addUser() {
      this.newUserForm = {
        userID: this.userID,
        userName: this.userName,
        carID: this.carID,
        carNumber: this.carNumber,
      };
      this.newUserVisible = true;
    },
    newUser() {
      this.newUserVisible = false;
      web3.eth.defaultAccount = web3.eth.accounts[0];
      web3.personal.unlockAccount(web3.eth.defaultAccount);
      console.log(this.newUserForm);
      var str = contractInstance.add.sendTransaction(
        this.newUserForm.userID,
        this.newUserForm.userName,
        this.newUserForm.carID,
        this.newUserForm.carNumber,
        { from: web3.eth.accounts[0], gas: 6000000 }
      );
      console.log(str);
      this.$message.success({
        message:"成功执行加盟交易,交易hash为：\n" + str,
        center:true,
        duration: 10000
      });
      var tran = web3.eth.getTransaction(str)
      this.userData.push({
          label: "交易信息",
          children: [
            {
              label: "hash(交易哈希)",
              children: [
                {
                  label: tran.hash,
                },
              ],
            },
            {
              label: "nonce(此前交易数)",
              children: [
                {
                  label: tran.nonce,
                },
              ],
            },
            {
              label: "blockHash(交易块哈希)",
              children: [
                {
                  label: tran.blockHash,
                },
              ],
            },
            {
              label: "blockNumber(交易块编号)",
              children: [
                {
                  label: tran.blockNumber,
                },
              ],
            },
            {
              label: "transactionIndex(交易编号)",
              children: [
                {
                  label: tran.transactionIndex,
                },
              ],
            },
            {
              label: "from(发送方地址)",
              children: [
                {
                  label: tran.from,
                },
              ],
            },
            {
              label: "to(接收方地址)",
              children: [
                {
                  label: tran.to,
                },
              ],
            },
            {
              label: "value(涉及金额)",
              children: [
                {
                  label: tran.value.toString(),
                },
              ],
            },
            {
              label: "input(交易数据)",
              children: [
                {
                  label: tran.input,
                },
              ],
            }
          ],
        })
        if(this.userData.length>10){
          this.userData.pop();
        }
        this.GLOBAL.userArray = this.userData
      //console.log(contractInstance.add.sendTransaction(this.newUserForm.userID,this.newUserForm.userName,this.newUserForm.carID,this.newUserForm.carNumber,{from:web3.eth.accounts[0],gas: 6000000}));
      this.getlist();
    },
  },
  created() {
    this.getlist();
    this.userData=this.GLOBAL.userArray;
    this.pathData=this.GLOBAL.pathArray;
  },
};
</script>
