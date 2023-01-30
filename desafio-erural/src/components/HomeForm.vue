<template>
  <main class="wrapper">
    <div class="home" v-if="true">
      <h2>Crie salas para assistir em grupo</h2>
      <p>Inicie uma nova sala ou informe a URL de uma sala já existente</p>
      <div class="start-call-container">
          <button @click="$router.push('/create')">
            Crie a sua sala
          </button>
        <p class="subtext">ou</p>
        <form @submit.prevent="searchRoom">
          <input
            id="room"
            type="text"
            v-model="videoUrl"
            placeholder="Informe a sua URL"
            @input=""
          />
          <button type="submit">
            Entrar na sala
          </button>
        </form>
      </div>
    </div>
  </main>
</template>

<script>
  import { api } from '../lib/axios';
  import router from '../router';
  export default {
    data(){
      return {
        videoUrl: '' 
      }
    },
    methods: {
      async searchRoom(){
        const response = await api.get(`/rooms/${this.videoUrl}`);
        router.replace({ 
          name: 'Room',
          params: {
            uuid: response.data.uuid,
          },
        });
      }
    }
  }
</script>

<style scoped>
.wrapper {
  background-color: #f7f9fa;
  height: 100%;
  border-radius: 24px;
  margin: auto;
  padding: 20px;
}
.home {
  display: flex;
  flex-direction: column;
  padding: 10px;
  align-items: center;
  justify-content: center;
}
.start-call-container {
  display: flex;
  flex-direction: column;
  max-width: 200px;
  margin: auto;
}
.subtext {
  margin: 8px 0 0;
  text-align: center;
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