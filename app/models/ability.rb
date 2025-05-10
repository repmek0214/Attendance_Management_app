# frozen_string_literal: true

class Ability
  include CanCan::Ability

  

  def initialize(user)
    user ||= User.new # ログインしていない場合のゲストユーザー

    if user.admin?
      # 管理者ユーザーにはすべての操作を許可
      can :manage, :all
    else
      # 一般ユーザーの操作制限
      # 例: 勤怠記録 (Attendance) を読むだけ
      can :read, Attendance
    end
  end
end
