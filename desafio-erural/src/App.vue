<script setup>
import { RouterLink, RouterView } from 'vue-router'
import BackHome from './components/BackHome.vue'
</script>

<template>
  <header>
    <BackHome />
  </header>
  <RouterView />
</template>