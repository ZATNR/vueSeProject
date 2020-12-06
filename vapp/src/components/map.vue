<template>
    <el-container class="testContainer">
        <!-- 头部 -->
        <el-header class="Header">
            <!-- <img src="../assets/logo.jpg" alt=""> -->
            <span class="systemTitle">车辆轨迹Dapp系统</span>
            <div class="divRight">
                <el-button style="margin-left:22px" class="quitButton" type="danger" >退出</el-button>
            </div>
        </el-header>
        <el-container class="Body">
            <el-aside class="Aside" width="300px">
                <el-menu
                  default-active="3"
                  class="el-menu-vertical-demo">
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
                </el-menu>
            </el-aside>
            <el-main class="Main">
              <div id="container" class="map"></div> 
              <div id="panel"></div>
              <div class="info" id="text">
                  请用鼠标在地图上操作试试
              </div>
              <div id="myPageTop">
                  <table>
                      <tr>
                          <td>
                              <label>请输入关键字：</label>
                          </td>
                      </tr>
                      <tr>
                          <td>
                              <input id="tipinput" v-model="address"/><button v-on:click="searchA()">搜索</button>
                          </td>
                      </tr>
                  </table>
              </div>
            </el-main>
            
        </el-container>

    </el-container>
</template>

<style>
    #container {width:100%; height: 100%; position: relative;}  
    #myPageTop {
      position: absolute;
      top: 5px;
      right: 10px;
      background: #fff none repeat scroll 0 0;
      border: 1px solid #ccc;
      margin-top: 108px;
      margin-right: 10px;
      padding:6px;
      font-family: "Microsoft Yahei", "微软雅黑", "Pinghei";
      font-size: 14px;
    }
    #text {
      position: absolute;
      top: 5px;
      right: 10px;
      background: #fff none repeat scroll 0 0;
      border: 1px solid #ccc;
      margin-top: 75px;
      margin-right: 10px;
      padding:6px;
      font-family: "Microsoft Yahei", "微软雅黑", "Pinghei";
      font-size: 14px;
    }
    #myPageTop label {
      margin: 0 20px 0 0;
      color: #666666;
      font-weight: normal;
    }
    #myPageTop input {
      width: 170px;
    }
    #myPageTop .column2{
      padding-left: 25px;
    }
    .el-menu-item{
      border:0;
    }

    .testContainer{
      height: 100%;
    }

    .Header{
      background-color: #EEF6FF;
      display: flex;
      justify-content:space-between;
      align-items: center;
      font-size: 22px;
      color: #409EFF;
    }

    .Aside{
      background-color: #fff;
    }

    .Main{
      background-color: rgb(250, 250, 250);
    }




    .button-group {
	position: absolute;
	bottom: 20px;
	right: 20px;
	font-size: 12px;
	padding: 10px;
}

.button-group .button {
	height: 28px;
	line-height: 28px;
	background-color: #0D9BF2;
	color: #FFF;
	border: 0;
	outline: none;
	padding-left: 5px;
	padding-right: 5px;
	border-radius: 3px;
	margin-bottom: 4px;
	cursor: pointer;
}
.button-group .inputtext {
	height: 26px;
	line-height: 26px;
	border: 1px;
	outline: none;
	padding-left: 5px;
	padding-right: 5px;
	border-radius: 3px;
	margin-bottom: 4px;
	cursor: pointer;
}
 /*
.tip {
	position: absolute;
	bottom: 30px;
	right: 10px;
	background-color: #FFF;
	text-align: center;
	border: 1px solid #ccc;
	line-height: 30px;
	border-radius: 3px;
	padding: 0 5px;
	font-size: 12px;
}
*/
#tip {
	background-color: #fff;
	padding-left: 10px;
	padding-right: 10px;
	position: absolute;
	font-size: 12px;
	right: 10px;
	top: 20px;
	border-radius: 3px;
	border: 1px solid #ccc;
	line-height: 30px;
}

/*
#tip input[type='button'] {
	margin-top: 10px;
	margin-bottom: 10px;
	background-color: #0D9BF2;
	height: 30px;
	text-align: center;
	line-height: 30px;
	color: #fff;
	font-size: 12px;
	border-radius: 3px;
	outline: none;
	border: 0;
}
*/
.amap-info-content {
	font-size: 12px;
}

        #panel {
            position: absolute;
            background-color: white;
            max-height: 90%;
            overflow-y: auto;
            top: 10px;
            right: 10px;
            width: 280px;
        }



</style>

<script>
import AMap from 'AMap';
export default {
  data () {
    return {
      placeSearch:'',
      address:"",
      userLocation:{
        lng:"",
        lat:""
      }
    }
  },
  mounted(){
    this.initMap();
  },
  methods: {
    initMap(){
      var map = new AMap.Map("container", {
          resizeEnable: true
      });
      //输入提示
      var autoOptions = {
          input: "tipinput"
      };
      var auto = new AMap.Autocomplete(autoOptions);
      var placeSearch = new AMap.PlaceSearch({
          map: map
      });  //构造地点查询类
      AMap.event.addListener(auto, "select", select);//注册监听，当选中某条记录时会触发
      function select(e) {
          placeSearch.setCity(e.poi.adcode);
          placeSearch.search(e.poi.name);  //关键字查询查询
      }
      map.on('click', showInfoClick);
      function showInfoClick(e){
          var text = '您在 [ '+e.lnglat.getLng()+','+e.lnglat.getLat()+' ] 的位置单击了地图！'
          document.querySelector("#text").innerText = text;
      }
    },
    searchA() {
        this.placeSearch.search(this.address);
    },
    goToUser () {
      this.$router.push('/userManage')
    },
    goToPath () {
      this.$router.push('/pathManage')
    },
    goToMap () {
      this.$router.push('/map')
    },
    addUser () {
      this.newUserVisible = true
    }
  }
}
</script>