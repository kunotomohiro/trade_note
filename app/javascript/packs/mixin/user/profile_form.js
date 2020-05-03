export default {
  data: {
    user_profile: {
      nickname: "",
      avatar: ""
    },
    avatar: "/img/noface.png",
    nicknameStatus: false,
    errors: []
  },
  methods: {
    inputNickname() {
      if (self.user_profile.nickname.length <= 8) {
        self.nicknameStatus = true
      } else {
        self.nicknameStatus = false
      }
    }
  }
}