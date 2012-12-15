# coding: utf-8

#Userモデルのシードデータをいれる。

#ユーザーデータ1
@user1 = User.find_or_initialize_by_uid("100002752432599");
@user1.name = "Toshikazu Oka"
@user1.mail = "oka@gmail.com"
@user1.image = "http://graph.facebook.com/100002752432599/picture"
@user1.match = false
@user1.partner_id = nil
#自分のFacebookのIDをいれる。
@user1.follow_id = "100001528767140"
@user1.wait = true
@user1.follow_name = "Yoshifumi Sato"
@user1.follow_image = "http://graph.facebook.com/100001528767140/picture"
@user1.save



#ユーザーデータ2
@user2 = User.find_or_initialize_by_uid("100002295585350");
@user2.name = "Taichi Nihei"
@user2.mail = "nihei@gmail.com"
@user2.image = "http://graph.facebook.com/100002295585350/picture"
@user2.match = false
@user2.partner_id = nil
#自分のFacebookのIDをいれる。
@user2.follow_id = "100001528767140"
@user2.wait = true
@user2.follow_name = "Yoshifumi Sato"
@user2.follow_image = "http://graph.facebook.com/100001528767140/picture"
@user2.save



#ユーザーデータ3
@user3 = User.find_or_initialize_by_uid("100002060389287");
@user3.name = "Konomi Tashiro"
@user3.mail = "konomi@gmail.com"
@user3.image = "http://graph.facebook.com/100002060389287/picture"
@user3.match = false
@user3.partner_id = nil
#自分のFacebookのIDをいれる。
@user3.follow_id = "100001528767140"
@user3.wait = true
@user3.follow_name = "Yoshifumi Sato"
@user3.follow_image = "http://graph.facebook.com/100001528767140/picture"
@user3.save






