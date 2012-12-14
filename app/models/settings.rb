# coding: utf-8
#定数などファイルを取り出すためのモデル。
class Settings < Settingslogic
  source "#{Rails.root}/config/application.yml"
  namespace Rails.env
end







