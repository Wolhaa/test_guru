module BadgesHelper
  def rules_for_select
    BadgeService::BADGES_TYPE.map { |rule| I18n.t(:rules)[rule.to_sym] }
  end
end
