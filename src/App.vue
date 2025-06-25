<template>
  <el-container style="min-height: 100vh; background: #181818;">
    <el-header style="background: #111; color: #fff; font-size: 2rem; letter-spacing: 2px; border-bottom: 1px solid #222; cursor: pointer;"
      @click="goHome">
      <div style="display: flex; align-items: center; height: 100%;">
        <span style="font-weight: bold;">这是一部小说</span>
      </div>
    </el-header>
    <el-main style="background: #181818; padding: 0;">
      <router-view />
    </el-main>
  </el-container>
</template>

<script setup>
import { useRouter } from 'vue-router';
const router = useRouter();
const goHome = () => {
  router.push({ name: 'Home' });
};
</script>

<style>
body {
  margin: 0;
  font-family: 'PingFang SC', 'Microsoft YaHei', Arial, sans-serif;
  background: #181818;
}
</style>
