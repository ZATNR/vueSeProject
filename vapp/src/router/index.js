import Vue from 'vue'
import VueRouter from 'vue-router'

//tourist相关组件
import touristHome from '../views/touristHome.vue'
import login from '../components/tourist/login.vue'
import touristWelcome from '../components/tourist/touristWelcome.vue'
import touristApply from '../components/tourist/touristApply.vue'



//member相关组件
import memberHome from '../views/memberHome.vue'
import memberWelcome from '../components/member/memberWelcome.vue'
import memberTransaction from '../components/member/memberTransaction.vue'
import memberPublish from '../components/member/memberPublish.vue'
import memberCheck from '../components/member/memberCheck.vue'
import memberNotice from '../components/member/memberNotice.vue'
import memberRate from '../components/member/memberRate.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    redirect: '/touristHome'
  },
  {
    path: '/touristHome',
    component: touristHome,
    redirect: '/touristWelcome',
    children:[
      {path: '/login', component: login},
      {path: '/touristApply', component: touristApply},
      {path: '/touristWelcome', component: touristWelcome}
    ]

  },
  {
    path: '/memberHome',
    component: memberHome,
    redirect:'/memberWelcome',
    children:[
      {path: '/memberWelcome', component: memberWelcome},
      {path: '/memberTransaction', component: memberTransaction},
      {path: '/memberPublish', component: memberPublish},
      {path: '/memberCheck', component: memberCheck},
      {path: '/memberNotice', component: memberNotice},
      {path: '/memberRate', component: memberRate}
    ]
  }
]

const router = new VueRouter({
  routes
})

export default router
