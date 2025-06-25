<template>
  <el-row :gutter="0" style="height: 100vh;">
    <el-col :span="5" style="background: #20232a; min-height: 100vh; border-right: 1px solid #222; position: fixed; left: 0; top: 0; height: 100vh; z-index: 10;">
      <el-card shadow="never" style="background: rgba(32,35,42,0.7); border: none; color: #fff; min-height: 100vh;">
        <h2 style="color: #fff; font-size: 1.2rem; margin-bottom: 1.5rem; cursor:pointer;" @click="goHome">章节目录</h2>
        <el-menu :default-active="currentChapterId" @select="onSelectChapter" style="background: transparent; border: none; color: #fff;">
          <el-menu-item v-for="chapter in chapters" :key="chapter._id" :index="chapter._id" style="background: transparent; color: #fff;">
            {{ chapter.Title }}
          </el-menu-item>
        </el-menu>
      </el-card>
    </el-col>
    <el-col :span="19" style="background: #181818; min-height: 100vh; margin-left: 20.8333%;">
      <el-card shadow="never" style="background: #181818; border: none; color: #fff; min-height: 100vh;">
        <h2 style="color: #fff;">{{ article?.Title }}</h2>
        <div v-if="article" v-html="article.Content" style="line-height:2; font-size:1.1rem; color: #eee;"></div>
        <div v-else style="color: #888;">加载中...</div>
      </el-card>
    </el-col>
  </el-row>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import axios from 'axios';

const route = useRoute();
const router = useRouter();
const articleId = ref(route.params.id);
const chapters = ref([]);
const article = ref(null);
const currentChapterId = ref('');

const fetchChapters = async () => {
  const res = await axios.get('https://www.weedxu.com/bill//mongo/notebooks');
  chapters.value = res.data.filter(c => !c.IsDeleted);
};
const fetchArticle = async (id) => {
  const res = await axios.get('https://www.weedxu.com/bill//mongo/note?id=' + id);
  article.value = res.data;
  currentChapterId.value = res.data.NotebookId;
};
const onSelectChapter = (id) => {
  router.push({ name: 'Chapter', params: { id } });
};

onMounted(() => {
  fetchChapters();
  fetchArticle(articleId.value);
});

watch(() => route.params.id, (id) => {
  articleId.value = id;
  fetchArticle(id);
});
</script>

<style scoped>
.el-card {
  margin-bottom: 0;
  box-shadow: none;
}
</style>
