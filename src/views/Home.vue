<template>
  <el-row :gutter="0" style="height: 100vh;">
    <el-col :span="5" style="background: #20232a; min-height: 100vh; border-right: 1px solid #222;">
      <el-card shadow="never" style="background: #20232a; border: none; color: #fff; min-height: 100vh;">
        <h2 style="color: #fff; font-size: 1.2rem; margin-bottom: 1.5rem; cursor:pointer;" @click="goHome">章节目录</h2>
        <el-menu :default-active="activeChapterId" @select="onSelectChapter" style="background: transparent; border: none; color: #fff;">
          <el-menu-item v-for="chapter in chapters" :key="chapter._id" :index="chapter._id" style="background: transparent; color: #fff;">
            {{ chapter.Title }}
          </el-menu-item>
        </el-menu>
      </el-card>
    </el-col>
    <el-col :span="19" style="background: #181818; min-height: 100vh;">
      <el-card shadow="never" style="background: #181818; border: none; color: #fff; min-height: 100vh;">
        <template v-if="article">
          <h2 style="color: #fff;">{{ article.Title }}</h2>
          <div v-html="article.Content" style="line-height:2; font-size:1.1rem; color: #eee;"></div>
        </template>
        <template v-else>
          <h2 style="color: #fff;">引言</h2>
          <div style="color: #888;">加载中...</div>
        </template>
      </el-card>
    </el-col>
  </el-row>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import axios from 'axios';

const chapters = ref([]);
const activeChapterId = ref('');
const article = ref(null);
const router = useRouter();

const fetchChapters = async () => {
  const res = await axios.get('https://www.weedxu.com/bill//mongo/notebooks');
  chapters.value = res.data.filter(c => !c.IsDeleted);
};

const fetchIntro = async () => {
  const res = await axios.get('https://www.weedxu.com/bill//mongo/note?id=685b654a9e829a3cdb000000');
  article.value = res.data;
};

const onSelectChapter = (id) => {
  activeChapterId.value = id;
  router.push({ name: 'Chapter', params: { id } });
};

const goHome = () => {
  router.push({ name: 'Home' });
};

onMounted(() => {
  fetchChapters();
  fetchIntro();
});
</script>

<style scoped>
.el-card {
  margin-bottom: 0;
  box-shadow: none;
}
</style>
