[
  {
    user_id: 1,
    nickname: "fxの神"
  },
  {
    user_id: 2,
    nickname: "株の神"
  },
    {
    user_id: 3,
    nickname: "ビットコインの神"
  },
  {
    user_id: 4,
    nickname: "先物取引の神"
  },
    {
    user_id: 5,
    nickname: "バイナリーオプションの神"
  },
].each_with_index do |profile, index|
    user_profile = UserProfile.new(profile)
    user_profile.avatar.attach(io: File.open(Rails.root.to_s + "/public/img/seed/user_profile/" + (index + 1).to_s + ".jpg"), filename: (index + 1).to_s + ".jpg")
    user_profile.save!
  end