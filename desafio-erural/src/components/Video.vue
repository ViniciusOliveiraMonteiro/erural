<template>
  <div class="container">
    <h1>{{ name }}</h1>
    <div class="video-container">
      <iframe
        :src="`https://www.youtube.com/embed/${videoId}?autoplay=1&mute=1`"
        frameborder="0" 
        allow="autoplay; encrypted-media; picture-in-picture" 
        allowfullscreen
      ></iframe>
    </div>
  </div>
  <div class="video-info">
    <div>
      <button @click.prevent="copy">{{message}}</button>
    </div>
    <div>
      <p>Espectadores 1</p>
    </div>
  </div>
</template>

<script>
  import { api } from '../lib/axios';
  export default {
    data(){
      return {
        name: '',
        videoId: '',
        videoUrl: '',
        videoUuid: '',
        message: 'Copiar código da sala',
      }
    },
    beforeMount(){
      (async () => {
        try {
          const response = await api.get(`/rooms/${this.uuid}`);
          this.name = response.data.name;
          this.videoId = response.data.video_id;
          this.videoUrl = response.data.video_url;
          this.videoUuid = response.data.uuid;
        } catch (error) {
          console.log(error);
        }
      })();
    },
    props:{
      uuid: String
    },
    methods: {
      async copy() {
        try {
          this.message = "Copiado!";
          setTimeout(() => {
            this.message = "Copiar código da sala";
          }, 1000);
          await navigator.clipboard.writeText(this.videoUuid);
        } catch(error) {
          console.log(error);
          alert('Não foi possível copiar o código');
        }
      }
    }
  }
</script>

<style scoped>
  .video-container iframe {
    position: absolute;
    top: 0;
    left: 0;
    bottom: 0;
    right: 0;
    width: 100%;
    height: 100%;
  }

  .video-container {
    position: relative;
    overflow: hidden;
    width: 100%;
    padding-top: 56.25%;
  }

  .container{
    padding: 20px;
    background-color: #f7f9fa;
    border-radius: 24px;
  }

  .container h1 {
    padding-bottom: 20px;
    text-align: center;
    font-size: 30px;
  }

  .video-info {
    padding-top: 20px;
    display: flex;
    flex-direction: row-reverse;
    justify-content: space-between;
    margin: 0 50px 0 50px;
  }

  .video-info div {
    display: flex;
    align-items: center;
  }
  .video-info button {
    color: #1f2d3d;
    background: #1bebb9;
    border: 1px solid transparent;
    padding: 8px 16px;
    border-radius: 8px;
    font-size: 12px;
    line-height: 16px;
    font-weight: bold;
    cursor: pointer;
  }

  @media (min-width: 600px) {
    .video-container {
      min-height: 200px;
      min-width: 400px;
    }
  }

  @media (min-width: 1000px) {
    .video-container {
      min-height: 400px;
      min-width: 800px;
    }
  }

  @media (min-width: 1900px) {
    .video-container {
      min-height: 700px;
      min-width: 1200px;
    }
  }
</style>