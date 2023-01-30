<template>
  <RoomVideo :uuid="$route.params.uuid" />
</template>

<script setup>
  import RoomVideo from '../components/Video.vue';
</script>