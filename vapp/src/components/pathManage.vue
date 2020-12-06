<template>
  <el-container class="testContainer">
    <!-- 头部 -->
    <el-header class="Header">
      <img src="../assets/创新项目LOGO.png" alt="" />
      <span class="systemTitle">车辆轨迹Dapp系统</span>
      <div class="divRight">
        <div style="display: inline-block">
          <el-input
            class="input-with-select"
            placeholder="请输入内容"
            v-model="carIdSearched"
          >
            <el-button
              v-on:click="searchcar()"
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
      <el-aside class="Aside" width="300px">
        <el-menu default-active="2" class="el-menu-vertical-demo">
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
        <el-dialog
          title="添加车辆轨迹"
          :visible.sync="newUserVisible"
          width="40%"
        >
          <el-form
            ref="newCarForm"
            :model="newCarForm"
            label-width="150px"
            class="insertcar"
          >
            <el-form-item label="当前时间">
              <el-input
                v-model="newCarForm.time"
                style="width: 250px"
                placeholder="请输入时间"
                :disabled="true"
              ></el-input>
            </el-form-item>
            <el-form-item label="行驶方向">
              <el-input
                v-model="newCarForm.course"
                style="width: 250px"
                placeholder="请输入行驶方向"
              ></el-input>
            </el-form-item>
            <el-form-item label="车辆ID">
              <el-input
                v-model="newCarForm.devid"
                style="width: 250px"
                placeholder="请输入车辆ID"
              ></el-input>
            </el-form-item>
            <el-form-item label="行驶速度">
              <el-input
                v-model="newCarForm.speed"
                style="width: 250px"
                placeholder="请输入行驶速度"
              ></el-input>
            </el-form-item>
            <el-form-item label="挡位">
              <el-select v-model="newCarForm.gear" placeholder="请选择">
                <el-option
                  v-for="item in options"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value"
                >
                </el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="汽车坐标">
              <el-input
                v-model="newCarForm.position"
                style="width: 250px"
                placeholder="请输入汽车坐标"
              ></el-input>
            </el-form-item>
            <el-form-item label="行驶距离">
              <el-input
                v-model="newCarForm.mileage"
                style="width: 250px"
                placeholder="请输入行驶距离"
              ></el-input>
            </el-form-item>
            <el-form-item label="汽车状态">
              <el-input
                v-model="newCarForm.state"
                style="width: 250px"
                placeholder="请输入汽车状态"
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
              v-on:click="newcarpath()"
              size="small"
              >提交</el-button
            >
          </div>
        </el-dialog>
        <el-button
          type="primary"
          icon="el-icon-edit"
          v-on:click="addcar()"
          size="small"
          >添加车辆</el-button
        >
        <el-table :data="pathTable" style="width: 1900">
          <el-table-column prop="time" label="当前时间" width="180">
          </el-table-column>
          <el-table-column prop="course" label="行驶方向(度)" width="100">
          </el-table-column>
          <el-table-column prop="devid" label="车辆ID" width="200">
          </el-table-column>
          <el-table-column prop="speed" label="行驶速度" width="150">
          </el-table-column>
          <el-table-column prop="gear" label="挡位" width="100">
          </el-table-column>
          <el-table-column prop="position" label="坐标" width="150">
          </el-table-column>
          <el-table-column prop="mileage" label="行驶公里数" width="200">
          </el-table-column>
          <el-table-column prop="state" label="车辆状态" width="150">
          </el-table-column>
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

.testContainer {
  height: 100%;
}

.Header{
  background-color: #eef6ff;
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 22px;
  color: #409eff;
}

.Aside {
  background-color: #fff;
}

.Main {
  background-color: rgb(250, 250, 250);
}
</style>
<script src="../../../web3.min.js"></script>
<script type=＂text/javascript＂>
//import Web3 from "web3";
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
      carIdCurrent: "",
      pathTable: [],
      pathData: this.GLOBAL.pathArray,
      userData: this.GLOBAL.userArray,
      // activeNames: ["1"],
      // activeNames: ["2"],
      userIdCurrent: "",
      newCarForm: {
        time: "",
        course: 0,
        devid: "",
        speed: 0,
        gear: "",
        position: "",
        mileage: "",
        state: "",
      },
      options: [
        {
          value: "手动档",
          label: "手动档",
        },
        {
          value: "自动档",
          label: "自动档",
        },
      ],
      //Carsearched: "",
      carIdSearched: "",
      input: "",
      newUserVisible: false,
      loading: true,
      //carIdSearched: ''
    };
  },

  methods: {
    close() {
      this.newUserVisible = false;
    },
    getlist() {
      var length = contractInstance.gettracklength.call();
      console.log(length);
      this.pathTable = [];
      for (var i = 0; i < length; i++) {
        var item1 = contractInstance.search_1.call(i);
        var item2 = contractInstance.search_2.call(i);
        console.log(item1);
        console.log(item2);
        this.pathTable.push({
          time: item1[0],
          course: item1[1].toString(),
          devid: item1[2],
          speed: item1[3].toString(),
          gear: item2[0],
          position: item2[1],
          mileage: item2[2],
          state: item2[3],
        });
        //this.userTable.push({userID:"001",userName:"老王",carID:"002",carNumber:"沪D4313",isValid:1})
      }

      console.log(this.pathTable);
      console.log('hahahahahha');


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
    searchcar() {
      this.pathTable = [];
      var length = contractInstance.gettracklength.call();
      for (var i = 0; i < length; i++) {
        var item1 = contractInstance.search_1.call(i);
        var item2 = contractInstance.search_2.call(i);
        console.log(item1)
        if (item1[0] === this.carIdSearched) {
          this.pathTable.push({
            time: item1[0],
            course: item1[1].toString(),
            devid: item1[2],
            speed: item1[3].toString(),
            gear: item2[0],
            position: item2[1],
            mileage: item2[2],
            state: item2[3],
          });
        }
        console.log(item1);
        console.log(item1[0]);
        //this.userTable.push({userID:"001",userName:"老王",carID:"002",carNumber:"沪D4313",isValid:1})
      }
      console.log(this.Carsearched);
      this.loading = false;
    },
    addcar() {
      var date = new Date();
      console.log(date);
      var year = date.getFullYear();
      var month = date.getMonth()+1;
      var day = date.getDate();
      console.log(year);
      console.log(month);
      console.log(day);
      var ntime = year + "-" + month + "-" + day;
      console.log(ntime);
      this.newCarForm = {
        time: ntime,
        course: this.course,
        devid: this.devid,
        speed: this.speed,
        gear: this.gear,
        position: this.position,
        mileage: this.mileage,
        state: this.state,
      };
      //console.log(newCarForm)
      this.newUserVisible = true;
    },
    newcarpath() {
      this.newUserVisible = false;
      web3.eth.defaultAccount = web3.eth.accounts[0];
      console.log(this.newCarForm);
      web3.personal.unlockAccount(web3.eth.defaultAccount);
      var str = contractInstance.add1.sendTransaction(
        this.newCarForm.time,
        this.newCarForm.course,
        this.newCarForm.devid,
        this.newCarForm.speed,
        { from: web3.eth.accounts[0], gas: 6000000 }
      );
      var str2 = contractInstance.add2.sendTransaction(
        this.newCarForm.gear,
        this.newCarForm.position,
        this.newCarForm.mileage,
        this.newCarForm.state,
        { from: web3.eth.accounts[0], gas: 6000000 }
      );
      console.log(str);
      console.log(contractInstance.gettracklength.call());
      //console.log(contractInstance.searchdevstr.call("001"));
      //this.pathTable.push({time:"一月五号",course:123,devid:"001",speed:100,gear:true,position:"30,50",mileage:"500km",state:1});
      this.$message.success({
        message:"成功执行加盟交易,交易hash为：\n" + str
        +"\n成功执行加盟交易,交易hash为：\n" + str2,
        center:true,
        duration: 10000
      });
      var tran = web3.eth.getTransaction(str)
      this.pathData.push({
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
        tran = web3.eth.getTransaction(str2)
        this.pathData.push({
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
        if(this.pathData.length>10){
          this.pathData.pop();
        }
        this.GLOBAL.pathArray = this.pathData
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
