<template>
  <main class="wrapper">
    <div class="start-call-container">
      <form @submit.prevent="createRoom()">
        <input
        name="name"
        type="text"
        v-model="name"
        v-bind:name="name"
        placeholder="Informe o nome da sala"
        @input=""
        />
        <input
        name="videoUrl"
        type="text"
        v-model="videoUrl"
        v-bind:videoUrl="videoUrl"
        placeholder="Informe a URL do vídeo"
        @input=""
        />
        <button type="submit" :disabled="!name.length || !videoUrl.length">
          Criar sala
        </button>
      </form>
    </div>
  </main>
</template>

<script>
  import { api } from '../lib/axios';
  import router from '../router/index';
  import { defineStore } from 'pinia';
  export default {
    data() {
      return {
        name: '',
        videoUrl: '',
      }
    },
    methods: {
      createRoom: async function(){
        if(!this.name.length || !this.videoUrl.length){
          return;
        }
        try {
          let videoId = '';
          let url = this.videoUrl.replace(/(>|<)/gi,'').split(/(vi\/|v=|\/v\/|youtu\.be\/|\/embed\/)/);
          if(url[2] !== undefined) {
            videoId = url[2].split(/[^0-9a-z_\-]/i);
            videoId = videoId[0];
          }else {
            videoId = url;
          }
          const response = await api.post('/rooms', {
            name: this.name,
            video_url: this.videoUrl,
            video_id: videoId,
          });
          router.replace({ 
            name: 'Room',
            params: {
              uuid: response.data.uuid,
            },
          });
        } catch (error) {
          console.log(error);
        }
      }
    }
  };
  </script>

<style scoped>
.wrapper {
  background-color: #f7f9fa;
  height: 100%;
  border-radius: 24px;
  margin: auto;
  display: flex;
  flex-direction: column;
  padding: 50px;
  align-items: center;
  justify-content: center;
}
.start-call-container {
  display: flex;
  flex-direction: column;
  max-width: 200px;
  margin: auto;
}
.start-call-container input {
  margin-top: 8px;
  height: 32px;
  border-radius: 8px;
  border: 1px solid var(--grey);
  padding: 0 16px;
}
.start-call-container button {
  color: #1f2d3d;
  background: #1bebb9;
  border: 1px solid transparent;
  padding: 8px 16px;
  border-radius: 8px;
  font-size: 12px;
  line-height: 16px;
  font-weight: bold;
  cursor: pointer;
  margin-top: 16px;
}
.start-call-container button[type="submit"] {
  color: #1f2d3d;
  background: #c8d1dc;
  border: 1px solid transparent;
  padding: 6px 16px 8px;
  border-radius: 8px;
  font-size: 12px;
  line-height: 16px;
  font-weight: bold;
  cursor: pointer;
  margin-top: 16px;
}

.start-call-container form {
  display: flex;
  flex-direction: column;
  justify-content: center;
}
button:disabled,
.start-call-container input[type="submit"]:disabled {
  cursor: not-allowed;
  background: var(--white);
  border: 1px solid var(--grey);
}
label {
  opacity: 0;
  font-size: 1px;
}
</style>