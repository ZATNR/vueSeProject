<template>
    <el-container class="index-container">
        <!--        上边框-->
        <el-header>
            <div>
                <img src="../assets/img/logo.png" height="60"/>
            </div>
            <!--            开启了路由模式-->
            <el-menu v-if="!isLogin" router
                     class="el-menu-demo" mode="horizontal" background-color="rgb(43,43,43)"
                     text-color="rgb(255,255,255)" active-text-color="#0099FF" default-active="/touristWelcome">
                <el-menu-item index="/touristWelcome">首页</el-menu-item>
                <el-menu-item index="/login">登录</el-menu-item>
                <el-menu-item index="/touristApply">申请加入</el-menu-item>
            </el-menu>
            <div class="out-button" v-if="isLogin">
                <el-menu  router
                         class="el-menu-demo" mode="horizontal" background-color="rgb(43,43,43)"
                         text-color="rgb(255,255,255)" active-text-color="#0099FF" default-active="/touristWelcome">
                    <el-menu-item @click.native="selfHome()">个人主页</el-menu-item>
                </el-menu>
            </div>
        </el-header>
        <!-- 主体区域 -->
        <el-main>
            <!-- 路由占位符 -->
            <router-view></router-view>

        </el-main>

    </el-container>

</template>

<script>
    export default {
        data()
        {
            return {
                isLogin: false,
                name: window.sessionStorage.getItem('name'),
            };
        },
        created()
        {
            this.name = window.sessionStorage.getItem('name');
            console.log(this.name)
            if (this.name != null)
            {
                this.isLogin = true;
            }
        },
        methods: {
            selfHome()
            {

                let userType = window.sessionStorage.getItem('userType');
                console.log(userType);
                if (userType == "member")
                {
                    this.$router.push({path: '/memberHome'});
                }
                else{
                    this.$router.push({path: '/touristHome'});
                }
            },
            login()
            {
                this.$router.push("/login");
            },
            touristApply()
            {
                this.$router.push("/touristApply")
            }

        }

    };
</script>

<style scoped>
    #username-div {
        font-size: 20px;
        font-weight: bold;
        font-family: 楷体;
    }

    .index-container {
        height: 100%;
    }

    .el-header {
        /*background-color: rgb(255,255,255);*/
        background-color: rgb(43, 43, 43);
        display: flex;
        justify-content: space-between;
        margin-left: 0;
        padding-left: 0;
    }

    .el-main {
        /*background-color: rgb(239,239,239);*/
        background-color: rgb(255, 255, 255);
        margin: 0;

        padding: 0;
    }
</style>