<template>
  <el-row :gutter="0" style="height: 100vh;">
    <el-col :span="5" style="background: #20232a; min-height: 100vh; border-right: 1px solid #222; position: fixed; left: 0; top: 0; height: 100vh; z-index: 10;">
      <el-card shadow="never" style="background: rgba(32,35,42,0.7); border: none; color: #fff; min-height: 100vh;">
        <h2 style="color: #fff; font-size: 1.2rem; margin-bottom: 1.5rem; cursor:pointer;" @click="goHome">章节目录</h2>
        <el-menu :default-active="chapterId" @select="onSelectChapter" style="background: transparent; border: none; color: #fff;">
          <el-menu-item v-for="chapter in chapters" :key="chapter._id" :index="chapter._id" style="background: transparent; color: #fff;">
            {{ chapter.Title }}
          </el-menu-item>
        </el-menu>
      </el-card>
    </el-col>
    <el-col :span="19" style="background: #181818; min-height: 100vh; margin-left: 20.8333%;">
      <el-card shadow="never" style="background: #181818; border: none; color: #fff; min-height: 100vh;">
        <h2 style="color: #fff;">文章列表</h2>
        <div v-if="articles.length">
          <div v-for="article in articles" :key="article._id" @click="onSelectArticle(article._id)" style="cursor:pointer; padding: 1rem; border-bottom: 1px solid #222; transition: background .2s;">
            <b style="color: #fff;">{{ article.Title }}</b>
            <div style="color:#aaa;font-size:13px; margin-top: 4px;">{{ article.Desc?.slice(0, 60) }}</div>
          </div>
        </div>
        <div v-else style="color: #888;">暂无文章</div>
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
const chapterId = ref(route.params.id);
const chapters = ref([]);
const articles = ref([]);

const fetchChapters = async () => {
  const res = await axios.get('https://www.weedxu.com/bill//mongo/notebooks');
  chapters.value = res.data.filter(c => !c.IsDeleted);
};
const fetchArticles = async (id) => {
  const res = await axios.get('https://www.weedxu.com/bill//mongo/notes?notebookId=' + id);
  articles.value = Array.isArray(res.data) ? res.data.filter(a => !a.IsDeleted) : [];
};
const onSelectChapter = (id) => {
  router.push({ name: 'Chapter', params: { id } });
};
const onSelectArticle = (id) => {
  router.push({ name: 'Article', params: { id } });
};

onMounted(() => {
  fetchChapters();
  fetchArticles(chapterId.value);
});

watch(() => route.params.id, (id) => {
  chapterId.value = id;
  fetchArticles(id);
});
</script>

<style scoped>
.el-card {
  margin-bottom: 0;
  box-shadow: none;
}
</style>
